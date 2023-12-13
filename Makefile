
config/mosquitto:
	[ ! -d "config/mosquitto/" ] && mkdir config/mosquitto && touch config/mosquitto/mosquitto.conf;

config/mariadb:
	[ ! -d "config/mariadb/" ] && mkdir config/mariadb;

config/homeassistant:
	[ ! -d "config/homeassistant/" ] && mkdir config/homeassistant;

config/influxdb:
	[ ! -d "config/influxdb/" ] && mkdir config/influxdb;

infra/up:
	docker compose --profile infra up --build -d

domotica/start: config/mosquitto config/mariadb config/influxdb config/homeassistant
	docker compose --profile domotica up --build -d

domotica/stop:
	docker compose --profile domotica down

frigate/up:
	docker compose --profile frigate up --build -d

frigate/down:
	docker compose --profile frigate down

infra/up:
	docker compose --profile infra up --build -d

infra/down:
	docker compose --profile infra down

media/up:
	docker compose --profile media up --build -d

media/down:
	docker compose --profile media down
