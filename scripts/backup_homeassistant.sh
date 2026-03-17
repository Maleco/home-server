#!/bin/bash
# Home Assistant Configuration Backup Script

# Configuration
BASE_BACKUP_DIR="/media/external2/backups/homeassistant"
CONFIG_DIR="/home/maikel/home-server/config/domotica/homeassistant"
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="$BASE_BACKUP_DIR/$DATE"
BACKUP_FILE="$BACKUP_DIR/homeassistant_config.tar.gz"
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

# Backup Home Assistant database
echo "Backing up Home Assistant database..."
if [ -f "$CONFIG_DIR/home-assistant_v2.db" ]; then
  sqlite3 "$CONFIG_DIR/home-assistant_v2.db" ".backup '$BACKUP_DIR/home-assistant_v2.db'"
  echo "Database backup created: $BACKUP_DIR/home-assistant_v2.db"
fi

# Check if backup was successful
if [ $? -eq 0 ]; then
  echo "Backup created successfully: $BACKUP_FILE"
  
  # Clean up old backups
  echo "Cleaning up backups older than $RETENTION_DAYS days..."
  find "$BASE_BACKUP_DIR" -mindepth 1 -maxdepth 1 -type d -mtime +$RETENTION_DAYS -exec rm -rf {} +
  
  echo "Backup completed successfully!"
else
  echo "Backup failed!"
  exit 1
fi