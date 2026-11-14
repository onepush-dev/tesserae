"""Set Tesserae's admin password from TESSERAE_ADMIN_PASSWORD if none is stored yet.

Uses the app's own SettingsStore + auth.set_password (PBKDF2), so the stored hash is exactly what the
first-run /setup page would write. Never overwrites an existing password: change it later in
Settings -> System -> Authentication (or clear it with `tesserae --reset-password`).
"""
import os
import sys
from pathlib import Path

sys.path.insert(0, "/app")
from app import auth  # noqa: E402
from app.state.settings_store import SettingsStore  # noqa: E402

pw = os.environ.get("TESSERAE_ADMIN_PASSWORD", "")
root = Path(os.environ.get("TESSERAE_DATA_ROOT", "").strip() or "/app/data")
store = SettingsStore(root / "core" / "settings.json")
if auth.password_is_set(store):
    print("railway: admin password already set, leaving it unchanged")
elif len(pw) >= 8:
    auth.set_password(store, pw)
    print("railway: admin password seeded from TESSERAE_ADMIN_PASSWORD")
else:
    print("railway: WARNING TESSERAE_ADMIN_PASSWORD missing/short; first visitor will be asked to set a password")
