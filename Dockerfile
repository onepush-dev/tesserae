# Tesserae on Railway: the official upstream image (dmellok/tesserae v0.511.0, AGPL-3.0), app unmodified.
# This layer only: serves on port 8080, trusts Railway's edge proxy for X-Forwarded-* (so cookies/URLs are HTTPS),
# and pre-seeds the admin password from TESSERAE_ADMIN_PASSWORD on first boot so the public URL never shows the
# open first-run "set a password" page. Data lives on the Railway volume at /app/data.
FROM ghcr.io/dmellok/tesserae:0.511.0
LABEL org.opencontainers.image.source="https://github.com/onepush-dev/tesserae"
USER root
COPY railway/seed_password.py /opt/railway/seed_password.py
COPY railway/start.sh /opt/railway/start.sh
RUN chmod 755 /opt/railway/start.sh
ENV TESSERAE_BIND_PORT=8080 \
    TESSERAE_BIND_HOST=0.0.0.0 \
    TESSERAE_TRUSTED_PROXIES=100.64.0.0/10 \
    TESSERAE_IN_DOCKER=1
EXPOSE 8080
ENTRYPOINT ["/opt/railway/start.sh"]
CMD ["tesserae"]
