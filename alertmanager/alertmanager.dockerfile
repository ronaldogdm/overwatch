FROM prom/alertmanager
LABEL maintainer Adam Alston
COPY ./alertmanager.yml /etc/alertmanager/
VOLUME alertmanager-data:/alertmanager
CMD ["--config.file=/etc/alertmanager/alertmanager.yml", "--storage.path=/alertmanager" ]
EXPOSE 9093