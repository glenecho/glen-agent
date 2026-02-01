use anyhow::{Context, Result};
use regex::Regex;
use tokio::process::Command;

#[derive(Debug, Clone, PartialEq, Eq, serde::Serialize)]
pub struct Service {
    pub name: String,
    pub port: u16,
}

pub async fn discover_services() -> Result<Vec<Service>> {
    let mut services = Vec::new();
    services.extend(parse_systemctl(
        &run_cmd(&[
            "systemctl",
            "list-units",
            "--type=service",
            "--state=running",
        ])
        .await?,
    )?);
    services.extend(parse_docker(
        &run_cmd(&["docker", "ps", "--format", "{{.Names}} {{.Ports}}"]).await?,
    )?);
    services.sort_by(|a, b| a.name.cmp(&b.name).then(a.port.cmp(&b.port)));
    services.dedup();
    Ok(services)
}

async fn run_cmd(args: &[&str]) -> Result<String> {
    let (cmd, rest) = args.split_first().context("empty command")?;
    let output = Command::new(cmd).args(rest).output().await?;
    if !output.status.success() {
        anyhow::bail!("command {cmd} failed with status {}", output.status);
    }
    Ok(String::from_utf8_lossy(&output.stdout).to_string())
}

fn parse_systemctl(output: &str) -> Result<Vec<Service>> {
    let mut services = Vec::new();
    let re = Regex::new(r"^(\S+)\s").unwrap();
    for line in output.lines() {
        if let Some(cap) = re.captures(line) {
            let name = cap[1].to_string();
            if let Some(port) = extract_port(&name) {
                services.push(Service { name, port });
            }
        }
    }
    Ok(services)
}

fn parse_docker(output: &str) -> Result<Vec<Service>> {
    let mut services = Vec::new();
    let re = Regex::new(r"^(\S+)\s+(.*)$").unwrap();
    for line in output.lines() {
        if let Some(cap) = re.captures(line) {
            let name = cap[1].to_string();
            let ports = &cap[2];
            for port in ports.split(',') {
                if let Some(port_num) = parse_docker_port(port.trim()) {
                    services.push(Service {
                        name: name.clone(),
                        port: port_num,
                    });
                }
            }
        }
    }
    Ok(services)
}

fn extract_port(name: &str) -> Option<u16> {
    // Prefer ports encoded as service@PORT.service
    if let Some(cap) = Regex::new(r"@(\d+)").unwrap().captures(name) {
        return cap
            .get(1)
            .and_then(|m| m.as_str().parse::<u16>().ok());
    }
    name.split('.')
        .next()
        .and_then(|base| base.split('-').last())
        .and_then(|p| p.parse().ok())
}

fn parse_docker_port(segment: &str) -> Option<u16> {
    // Examples: "0.0.0.0:8080->80/tcp", ":::443->443/tcp"
    let re = Regex::new(r":(\d+)->").unwrap();
    re.captures(segment)
        .and_then(|c| c.get(1))
        .and_then(|m| m.as_str().parse().ok())
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_parse_docker_port() {
        assert_eq!(parse_docker_port("0.0.0.0:8080->80/tcp"), Some(8080));
        assert_eq!(parse_docker_port(":::443->443/tcp"), Some(443));
        assert_eq!(parse_docker_port("80/tcp"), None);
    }

    #[test]
    fn test_parse_systemctl() {
        let input =
            "nginx.service loaded active running A high performance web server\nhttpd@8080.service loaded active running";
        let parsed = parse_systemctl(input).unwrap();
        assert!(parsed.contains(&Service {
            name: "httpd@8080.service".into(),
            port: 8080
        }));
    }

    #[test]
    fn test_parse_docker() {
        let input = "web1 0.0.0.0:8080->80/tcp\nweb2 :::443->443/tcp";
        let parsed = parse_docker(input).unwrap();
        assert!(parsed.contains(&Service {
            name: "web1".into(),
            port: 8080
        }));
        assert!(parsed.contains(&Service {
            name: "web2".into(),
            port: 443
        }));
    }
}
