use anyhow::Result;
use reqwest::Client;

use crate::services::Service;

pub async fn register_services(url: &str, services: &[Service]) -> Result<()> {
    if services.is_empty() {
        return Ok(());
    }
    let client = Client::new();
    let payload = serde_json::json!({ "services": services });
    client
        .post(url)
        .json(&payload)
        .send()
        .await?
        .error_for_status()?;
    Ok(())
}

#[cfg(test)]
mod tests {
    use super::*;

    #[tokio::test]
    async fn empty_noop() {
        let res = register_services("http://example.com", &[]).await;
        assert!(res.is_ok());
    }
}
