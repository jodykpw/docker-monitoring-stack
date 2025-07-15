# Docker Monitoring Stack with Prometheus and Thanos

This project sets up a Docker-based monitoring stack using Prometheus and Thanos, enabling scalable metrics collection and querying. It also includes the integration of Fluentd for logging and Traefik for reverse proxying.

## Prerequisites

1. **Centralised Grafana**: Ensure that Grafana is set up and running. Follow the [Setting Up Centralised Grafana using Docker Compose](https://homelab.jodywan.com/en/docker/setup-centralised-grafana-using-docker-compose) guide for setup details.

2. **MinIO**: Ensure that MinIO is set up and running on Docker VMs. Follow the [How to Set Up MinIO for Each Docker VM: A Step-by-Step Guide](https://homelab.jodywan.com/en/docker/setup-minio-per-docker-vm-guide) for detailed instructions.

3. **Reverse Proxy (Optional)**: If Prometheus, Thanos and Grafana are not on the same Docker VM, make sure you have a reverse proxy configured. For this setup, you will need:
   - **Traefik**: Follow the [Install and Configure Traefik on Docker](https://homelab.jodywan.com/en/initial-setup/13-install-and-configure-traefik-on-docker) guide.
   - **pfSense HAProxy with Let's Encrypt and Cloudflare DNS**: Follow the [pfSense HAProxy with Let's Encrypt and Cloudflare DNS](https://homelab.jodywan.com/en/initial-setup) guide. Configure HAProxy to restrict access to Thanos Query Frontend.

## Overview

This setup uses two Prometheus instances, Thanos sidecars, a query frontend, compactor, and other components that support high availability and long-term storage with MinIO. Fluentd is used for logging to Loki, and all services are proxied through Traefik.

## Services

- **Prometheus**: Scrapes metrics and stores time series data.
- **Thanos Sidecars**: Acts as the bridge between Prometheus and Thanos.
- **Thanos Query Frontend**: Allows querying across multiple Prometheus instances.
- **Thanos Store Gateway**: Provides long-term storage in MinIO.
- **Thanos Compactor**: Compacts old data to improve performance.
- **Thanos Ruler**: Executes Prometheus recording and alerting rules.
- **Alertmanager**: Handles alerts sent by Prometheus.
- **Node Exporter**: Collects system-level metrics.
- **cAdvisor**: Collects container-level metrics.

## Volumes

- `prometheus_config`: Stores the configuration for Prometheus.
- `prometheus_data`: Stores data for Prometheus.
- `alertmanager_config`: Stores the configuration for Alertmanager.
- `alertmanager_data`: Stores data for Alertmanager.
- `thanos_config`: Stores the configuration for Thanos components.

## Networks

- **traefik**: The external network used by Traefik to manage routing between services.

## Configuration Files

The configuration files are located in the /data directory.

## Configure GitLab CICD Variables: 

Make sure to set the following variables in your GitLab CI/CD settings:

* SSH_PRIVATE_KEY: Your SSH private key used for connecting to the remote server.
* SSH_DOCKER_USER: The SSH user for the remote Docker server.
* REMOTE_IPADDRESS: The IP address of the remote server.
* MINIO_ACCESS_KEY_ID: MinIO access key.
* MINIO_SECRET_ACCESS_KEY: MinIO secret access key.

## Usage

### 1. Deployment

To deploy the Prometheus and Thanos, manually trigger the `ssh_scp_docker-compose-up` job from the GitLab CI/CD pipeline. This will:

- Upload project files to the remote server using `rsync`.
- Start all the services on Docker.

### 2. Service Shutdown

To stop and remove all the services, manually trigger the `ssh_scp_docker-compose-down` job.

### 3. Destroying Services and Volumes

To remove the containers and associated volumes, trigger the `ssh_scp_docker-compose-remove` job.

### 4. Cleanup on Failure

If a deployment fails, the `cleanup_deployment_failure` job will automatically remove the project folder on the remote server.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🇬🇧🇭🇰 Author Information

* Author: Jody WAN
* Linkedin: https://www.linkedin.com/in/jodywan/
* Website: https://www.jodywan.com