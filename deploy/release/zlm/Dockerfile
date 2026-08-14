ARG BASE_IMAGE=zlmediakit/zlmediakit:master
FROM ${BASE_IMAGE}
COPY config.ini /opt/media/conf/config.ini.template
COPY entrypoint-release.sh /opt/media/entrypoint-release.sh
RUN chmod +x /opt/media/entrypoint-release.sh
ENTRYPOINT ["/opt/media/entrypoint-release.sh"]
