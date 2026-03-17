# Docker Services Overview

This repository manages multiple Docker services for a local server, organized into logical groups using Docker Compose profiles.

## Service Categories

### 1. Infrastructure Services (`infra` profile)
- **Traefik**: Reverse proxy and load balancer (v3.0)
- **Portainer**: Docker management UI
- **Dashy**: Dashboard/organization tool
- **Pi-hole**: Network-wide ad blocking
- **Omada**: Network controller

### 2. Media Services (`media` profile)
- **Sonarr**: TV show management
- **Radarr**: Movie management
- **Bazarr**: Subtitle management
- **Readarr**: E-book management
- **Calibre**: E-book library management
- **Calibre-Web**: Web interface for Calibre
- **NZBGet**: Usenet downloader
- **qBittorrent**: Torrent client
- **Plex**: Media server
- **Jellyfin**: Alternative media server

### 3. Domotica/Home Automation (`domotica` profile)
- **Home Assistant**: Home automation platform
- **InfluxDB**: Time-series database
- **Mosquitto**: MQTT broker
- **Zigbee2MQTT**: Zigbee device bridge

### 4. Security (`frigate` profile)
- **Frigate**: NVR with AI object detection

### 5. System Services
- **Watchtower**: Automatic container updates

## Architecture

```
├── docker-compose.yml (main)
├── docker-compose-infra.yml (infrastructure)
├── docker-compose-media.yml (media)
├── docker-compose-frigate.yml (security)
└── config/ (service configurations)
```

## Key Features

- **Modular**: Services organized by profiles for selective deployment
- **Persistent Storage**: Volumes for data persistence
- **Networking**: Traefik handles routing with host-based rules
- **Security**: Pi-hole for DNS filtering, Frigate for surveillance
- **Automation**: Home Assistant with Zigbee2MQTT integration

## Usage

Start specific service groups:
```bash
docker compose --profile infra up -d
docker compose --profile media up -d
docker compose --profile domotica up -d
```

All services are configured to restart automatically unless stopped.