
config/mosquitto:
	[ ! -d "config/mosquitto/" ] && mkdir config/mosquitto && touch config/mosquitto/mosquitto.conf;

config/mariadb:
	[ ! -d "config/mariadb/" ] && mkdir config/mariadb;

config/homeassistant:
	[ ! -d "config/homeassistant/" ] && mkdir config/homeassistant;

config/influxdb:
	[ ! -d "config/influxdb/" ] && mkdir config/influxdb;

domotica/start: config/mosquitto config/mariadb config/influxdb config/homeassistant
	docker compose --profile domotica up --build -d

domotica/stop:
	docker compose --profile domotica down
