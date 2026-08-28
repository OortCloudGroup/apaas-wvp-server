#!/bin/sh
# This file must remain LF-only because it is executed directly by the Linux container.
set -eu

secret=$(printf '%s' "${ZLM_SECRET:?ZLM_SECRET is required}" | sed 's/[&|]/\\&/g')
rtp_range="${RTP_PORT_START:?RTP_PORT_START is required}-${RTP_PORT_END:?RTP_PORT_END is required}"
hook_host=$(printf '%s' "${ZLM_HOOK_IP:-wvp-backend}" | sed 's/[&|]/\\&/g')

sed -e "s|^secret=.*|secret=${secret}|" \
  -e "s|^port_range=.*|port_range=${rtp_range}|" \
  -e "s|__ZLM_HOOK_HOST__|${hook_host}|g" \
  /opt/media/conf/config.ini.template > /opt/media/conf/config.ini

exec /opt/media/bin/MediaServer -c /opt/media/conf/config.ini
