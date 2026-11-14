# Tesserae on Railway

[Tesserae](https://github.com/dmellok/tesserae) (by dmellok, AGPL-3.0) — an e-ink dashboard companion: compose dashboards in the browser, render them server-side and push them to e-ink panels over REST or MQTT. Deploy on Railway with one click.

[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/deploy/4lA1lE)

## What this template runs

- One service from `ghcr.io/onepush-dev/tesserae:0.511.0`: the official `ghcr.io/dmellok/tesserae:0.511.0` image, app unmodified, plus a small start wrapper.
- Public HTTPS domain on port 8080, healthcheck `/healthz`, restart policy Always.
- One volume at `/app/data`: settings, pages, schedules, render cache, gallery photos and backups.

## Variables

| Variable | Value | Notes |
|---|---|---|
| `TESSERAE_ADMIN_PASSWORD` | generated per deploy | Admin password, written on first boot only (so the public URL never shows the open "set a password" page). Change it later in Settings → System → Authentication. |
| `TESSERAE_SECRET_KEY` | generated per deploy (64 hex) | Encrypts plugin/integration secrets at rest. Keep it stable. |

Baked into the image: `TESSERAE_BIND_PORT=8080`, `TESSERAE_BIND_HOST=0.0.0.0`, `TESSERAE_TRUSTED_PROXIES=100.64.0.0/10` (Railway's edge proxy, so HTTPS and client IPs are read correctly).

## Notes

- Sign in at your Railway domain with `TESSERAE_ADMIN_PASSWORD`, then follow the onboarding wizard.
- Panels fetch frames over HTTPS from the public URL using signed render links. Railway only exposes HTTP(S), so the built-in MQTT broker (1883) and Visionect (11113) listeners are not reachable from outside; use REST/HTTP devices or an external MQTT broker.
- LAN features (mDNS discovery) don't apply on a cloud host.
