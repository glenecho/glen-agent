mod registry;
mod services;

use anyhow::Result;
use tokio::time::{Duration, sleep};

const REGISTRY_URL: &str = "http://glenai.top:8080/registry/v1/api/service/add";
const INTERVAL_SECS: u64 = 60;

#[tokio::main]
async fn main() -> Result<()> {
    loop {
        let services = services::discover_services().await?;
        registry::register_services(REGISTRY_URL, &services).await?;
        sleep(Duration::from_secs(INTERVAL_SECS)).await;
    }
}
