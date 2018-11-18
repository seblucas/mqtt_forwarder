FROM seblucas/alpine-python3:latest
LABEL maintainer="Sebastien Lucas <sebastien@slucas.fr>"
LABEL Description="mqtt_forwarder image"

COPY *.py /usr/bin/

RUN chmod +x /usr/bin/mqtt_forwarder.py

ENTRYPOINT ["python3", "-u", "mqtt_forwarder.py"]
CMD ["--help"]
