#!/bin/bash
# Home Assistant Configuration Backup Script

# Configuration
BACKUP_DIR="/home/maikel/backups/homeassistant"
CONFIG_DIR="/home/maikel/home-server/config/domotica/homeassistant"
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="$BACKUP_DIR/homeassistant_config_$DATE.tar.gz"
RETENTION_DAYS=30

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Create backup
echo "Creating backup of Home Assistant configuration..."
tar -czvf "$BACKUP_FILE" \
  --exclude='.storage' \
  --exclude='*.log' \
  --exclude='*.tmp' \
  --exclude='.cache' \
  --exclude='.cloud' \
  --exclude='.cloud_old' \
  --exclude='OAuth2_token.txt' \
  -C "$CONFIG_DIR" .

# Check if backup was successful
if [ $? -eq 0 ]; then
  echo "Backup created successfully: $BACKUP_FILE"
  
  # Clean up old backups
  echo "Cleaning up backups older than $RETENTION_DAYS days..."
  find "$BACKUP_DIR" -name "homeassistant_config_*.tar.gz" -mtime +$RETENTION_DAYS -delete
  
  echo "Backup completed successfully!"
else
  echo "Backup failed!"
  exit 1
fi