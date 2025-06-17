#!/usr/bin/env bash
set -e

CONFIG_PATH=/data/options.json
WG_CONF_PATH=/etc/wireguard/wg0.conf

echo "[INFO] Reading WireGuard configuration from options..."

# Extract the user-provided config
WG_CONFIG=$(jq -r '.wg_config' "$CONFIG_PATH")

# Check if it contains any content
if [ -z "$WG_CONFIG" ] || [ "$WG_CONFIG" == "null" ]; then
    echo "[ERROR] No WireGuard configuration provided in wg_config!"
    exit 1
fi

# Write to wg0.conf
mkdir -p /etc/wireguard
echo "$WG_CONFIG" > "$WG_CONF_PATH"
chmod 600 "$WG_CONF_PATH"

echo "[INFO] Starting WireGuard VPN..."
sysctl -w net.ipv4.ip_forward=1

# Start WireGuard
wg-quick up wg0

# Keep container alive
while true; do sleep 3600; done
