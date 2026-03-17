# Home Server Docker Services

A comprehensive Docker Compose setup for managing home services including media, home automation, security, and infrastructure.

## 🚀 Quick Start

```bash
# Clone the repository
git clone https://github.com/yourusername/home-server.git
cd home-server

# Copy environment file
cp .env.example .env

# Edit .env with your settings
nano .env

# Start all services
docker compose up -d
```

## 📦 Service Stacks

This repository organizes services into logical stacks:

| Stack | File | Profiles |
|-------|------|----------|
| **Infrastructure** | `docker-compose-infra.yml` | `infra`, `proxy`, `management`, `dashboard` |
| **Home Automation** | `docker-compose-domotica.yml` | `domotica`, `iot`, `database`, `mqtt` |
| **Media Management** | `docker-compose-arr.yml` | `media`, `arr` |
| **Media Services** | `docker-compose-media.yml` | `media`, `streaming`, `books`, `torrent` |
| **Security** | `docker-compose-frigate.yml` | `frigate` |
| **System** | `docker-compose.yml` | `system`, `updates` |

## 🎯 Common Commands

### Start Specific Stacks

```bash
# Start infrastructure
docker compose --profile infra up -d

# Start home automation
docker compose --profile domotica up -d

# Start media services
docker compose --profile media --profile arr up -d

# Start everything
docker compose up -d
```

### Service Management

```bash
# View running services
docker compose ps

# View logs
docker compose logs -f

# Update services
docker compose pull && docker compose up -d

# Stop all services
docker compose down
```

### Stack-Specific Management

```bash
# Update only arr services
docker compose -f docker-compose-arr.yml pull
docker compose -f docker-compose-arr.yml up -d

# View home automation logs
docker compose -f docker-compose-domotica.yml logs -f home-assistant
```

## 🗂️ Configuration

### Environment Variables

Edit `.env` file with your settings:

```env
# User IDs - match your system user
PUID=1000
PGID=1000

# Timezone
TZ=Europe/Brussels

# Media storage paths
MEDIA_PATH_1=/media/external/data
MEDIA_PATH_2=/media/external2/media

# Database credentials
INFLUXDB_USER=homeassistant
INFLUXDB_PASSWORD=your_secure_password
INFLUXDB_ORG=home
INFLUXDB_BUCKET=homeassistant
```

### Configuration Structure

```
config/
├── arr/          # Sonarr, Radarr, Bazarr, Readarr
├── media/        # Plex, Jellyfin, Calibre, qBittorrent
├── domotica/     # Home Assistant, InfluxDB, Mosquitto
├── network/      # Pi-hole, Omada
└── monitoring/   # Future monitoring services
```

## 🔧 Service Details

### 🏠 Home Automation Stack

- **Home Assistant**: Full home automation with dashboard
- **InfluxDB**: Time-series database for metrics
- **Mosquitto**: MQTT broker for IoT devices
- **Zigbee2MQTT**: Zigbee device integration

**Access**: `http://ha.lan:8123`

### 🎬 Media Stack

- **Plex/Jellyfin**: Media servers with transcoding
- **Sonarr/Radarr**: TV/Movie management
- **Bazarr/Readarr**: Subtitles and e-books
- **qBittorrent/NZBGet**: Download clients

**Access**:
- Plex: `http://plex.lan:32400`
- Sonarr: `http://sonarr.lan:8989`
- Radarr: `http://radarr.lan:7878`

### 🛡️ Security Stack

- **Frigate**: NVR with AI object detection
- **Pi-hole**: Network-wide ad blocking

**Access**:
- Frigate: `http://frigate.lan:5000`
- Pi-hole: `http://pihole.lan:8099`

### 🌐 Infrastructure Stack

- **Traefik**: Reverse proxy and load balancer
- **Portainer**: Docker management UI
- **Dashy**: Beautiful dashboard

**Access**:
- Portainer: `http://portainer.lan:9000`
- Dashy: `http://dashy.lan:4000`

## 📊 Profiles Reference

| Profile | Services | Description |
|---------|----------|-------------|
| `infra` | Traefik, Portainer, Dashy, Pi-hole | Core infrastructure |
| `domotica` | Home Assistant, InfluxDB, Mosquitto, Zigbee2MQTT | Home automation |
| `media` | Plex, Jellyfin, Calibre, qBittorrent, NZBGet, *arr | Media services |
| `arr` | Sonarr, Radarr, Bazarr, Readarr | Media management |
| `frigate` | Frigate | Security/NVR |
| `iot` | Home Assistant | IoT devices |
| `database` | InfluxDB | Databases |
| `mqtt` | Mosquitto | MQTT broker |
| `streaming` | Plex, Jellyfin | Media streaming |
| `books` | Calibre, Calibre-Web | E-book management |
| `torrent` | qBittorrent | Torrent client |

## 🔄 Update Strategy

Services are configured with:
- **Watchtower**: Automatic container updates
- **Health checks**: Service monitoring
- **Restart policies**: Automatic recovery

## 💾 Backup & Recovery

### Backup Configuration

```bash
# Backup Home Assistant
./scripts/backup_homeassistant.sh

# Manual backup of all configs
tar -czvf backup_$(date +%Y%m%d).tar.gz config/
```

**Backup Location**: `/media/external2/backups/`
**Retention**: 30 days (automatic cleanup)

### Restore

```bash
# Stop services
docker compose down

# Restore configuration
tar -xzvf backup.tar.gz -C /

# Start services
docker compose up -d
```

## 🛠️ Maintenance

### Regular Tasks

```bash
# Clean up unused images and containers
docker system prune -f

# Check for updates
docker compose pull

# Restart services
docker compose restart
```

### Troubleshooting

**Service won't start**:
```bash
docker compose logs <service>
docker compose restart <service>
```

**Permission issues**:
```bash
chown -R ${PUID}:${PGID} config/
```

**Profile issues**:
```bash
docker compose config --profiles
```

## 📈 Resource Management

Consider adding resource limits to services:

```yaml
deploy:
  resources:
    limits:
      cpus: '2.0'
      memory: 4G
    reservations:
      cpus: '0.5'
      memory: 1G
```

## 🔒 Security Best Practices

1. **Use strong passwords** for all services
2. **Regularly update** services
3. **Backup frequently** using provided scripts
4. **Monitor logs** for suspicious activity
5. **Isolate networks** where possible
6. **Use VPN** for remote access

## 🚧 Roadmap

- [ ] Add monitoring stack (Prometheus, Grafana)
- [ ] Implement centralized logging
- [ ] Add notification services (Telegram, Discord)
- [ ] Expand backup coverage to all services
- [ ] Add resource limits to all services
- [ ] Implement network segmentation

## 📚 Documentation

- [Full Service Overview](AGENTS.md)
- [Docker Compose Reference](https://docs.docker.com/compose/)
- [Traefik Documentation](https://doc.traefik.io/traefik/)
- [Home Assistant Docs](https://www.home-assistant.io/docs/)

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Open a pull request

## 📜 License

MIT License - See [LICENSE](LICENSE) file for details.

---

**Maintainer**: [Your Name](https://github.com/yourusername)
**Version**: 1.0
**Last Updated**: 2024

🌟 Star this repo if you find it useful!
🐳 Happy Dockerizing!