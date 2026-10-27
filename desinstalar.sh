#!/usr/bin/env bash
# Quita el "Tutor de Python" de OpenCode (no desinstala OpenCode).
set -euo pipefail
CONF="$HOME/.config/opencode"
rm -rf "$CONF/skills/tutor-python"
if [ -f "$CONF/opencode.json" ]; then
  python3 - "$CONF/opencode.json" <<'PY'
import json, sys
path = sys.argv[1]
with open(path) as f:
    cfg = json.load(f)
cfg.get("agent", {}).pop("tutor", None)
if not cfg.get("agent"):
    cfg.pop("agent", None)
if cfg.get("default_agent") == "tutor":
    cfg.pop("default_agent")
with open(path, "w") as f:
    json.dump(cfg, f, indent=2, ensure_ascii=False)
PY
fi
echo "Tutor de Python desinstalado."
