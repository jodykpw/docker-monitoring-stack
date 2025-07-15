#!/bin/bash

# Exit script on any error
set -e

echo "Updating Prometheus configuration..."
docker cp ./data/prometheus/prometheus.yml prometheus:/opt/bitnami/prometheus/conf
docker cp ./data/prometheus/alert.rules prometheus:/opt/bitnami/prometheus/conf
echo "Prometheus restarted."

echo "Updating Thanos configuration..."
docker cp ./data/thanos/bucket_config.yaml thanos-sidecar:/etc/thanos
echo "Thanos restarted."

echo "Updating Alertmanager configuration..."
docker cp ./data/alertmanager/config.yml alertmanager:/etc/alertmanager
docker restart alertmanager
echo "Alertmanager restarted."

docker-compose restart

echo "All services updated and restarted successfully."
