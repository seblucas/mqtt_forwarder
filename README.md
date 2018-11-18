# mqtt_forwarder

Some sensors I'm using at home runs on ESP8266. I've been trying for a long time to sync them to NTP and so to provide the timstamp of each readings. I've failed so I chose a safer route and created this program that forward the payload add the timestamp. In my case each ESP8266 sends a message to a topic with its Chip Id to keep the same code base for all ESPs.

# Usage

## Prerequisite

You simply need Python3 (never tested with Python2.7) and the only dependency is `paho-mqtt` (for MQTT broker interaction) so this line should be enough  :

```bash
pip3 install paho-mqtt
```

## Using the script

Easy, first try a dry-run command :

```bash
./mqtt_forwarder.py -m 127.0.0.1 -n -v
```

About the path to your credentials, you can also use the json directly instead of a path. See the `docker-compose.yml` for more details.

and then a real command :

```bash
./mqtt_forwarder.py -a '{ "src": "dest" }' -m 127.0.0.1 -n -v
```

With this exemple any message coming from the topic `sensor/esp/src` will be forwarded to `sensor/raw/dest`.

The hashmap can also be set with environment variables, see the help for more detail.

## Help

```bash
/ # mqtt_forwarder.py --help
usage: mqtt_forwarder.py [-h] [-m HOST] [-a HASHMAP] [-n] [-d DESTINATION]
                         [-t TOPIC] [-T TOPIC] [-v]

Send MQTT payload received from a topic to firebase.

optional arguments:
  -h, --help            show this help message and exit
  -m HOST, --mqtt-host HOST
                        Specify the MQTT host to connect to. (default:
                        127.0.0.1)
  -a HASHMAP, --hash-map HASHMAP
                        Specify the MQTT host to connect to. (default: None)
  -n, --dry-run         No data will be sent to the MQTT broker. (default:
                        False)
  -d DESTINATION, --destination DESTINATION
                        The destination MQTT topic base. (default: sensor/raw)
  -t TOPIC, --topic TOPIC
                        The listening MQTT topic. (default: sensor/esp/#)
  -T TOPIC, --topic-error TOPIC
                        The MQTT topic on which to publish the message (if it
                        wasn't a success). (default: error/transformer)
  -v, --verbose         Enable debug messages. (default: False)
```

## Docker

I added a sample Dockerfile, I personaly use it with a `docker-compose.yml` like this one :

```yml
version: '3'

services:
  mqtt_forwarder:
    build: https://github.com/seblucas/mqtt_forwarder.git
    image: mqtt_forwarder-python3:latest
    restart: always
    command: "-m mosquitto -v"
    environment:
      MQTT_FORWARDER_HASHMAP: >-
        {
          "src": "dest"
        }
```


# Limits

 * None I hope ;).

# License

This program is licenced with GNU GENERAL PUBLIC LICENSE version 3 by Free Software Foundation, Inc.

