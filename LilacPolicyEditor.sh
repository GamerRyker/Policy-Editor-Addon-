#!/bin/bash

set -euo pipefail

LOGFILE="/var/log/lilac-deploy.log"
POLICY_FILE="/opt/lilac/policies"

log() {
    echo "$(date '+%F %T') $1" | tee -a "$LOGFILE"
}

backup_policy() {
    cp /var/lib/devicesettings/policies \
       /var/lib/devicesettings/policies.bak
}

main() {
    log "Starting lilac deployment!"

    backup_policy

    if [[ ! -f "$POLICY_FILE" ]]; then
        log "Policy file not found..."
        exit 1
    fi

    log "Applying policy data"
    cp "$POLICY_FILE" /var/lib/devicesettings/policies

    log "Deployment complete. Enjoy!"
}

main
