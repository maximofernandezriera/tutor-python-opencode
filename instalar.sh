#!/usr/bin/env bash
# Instala OpenCode (si falta) y el "Tutor de Python" como agente por defecto.
# Uso: curl -fsSL https://raw.githubusercontent.com/maximofernandezriera/tutor-python-opencode/main/instalar.sh | bash
set -euo pipefail
RAW="https://raw.githubusercontent.com/maximofernandezriera/tutor-python-opencode/main"
CONF="$HOME/.config/opencode"
MODELO="${MODELO:-opencode/deepseek-v4.1-flash-free}"
DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" 2>/dev/null && pwd || echo .)"

command -v python3 >/dev/null || { echo "Falta python3. Instálalo y vuelve a ejecutar." >&2; exit 1; }

if ! command -v opencode >/dev/null 2>&1 && [ ! -x "$HOME/.opencode/bin/opencode" ]; then
  echo "==> Instalando OpenCode..."
  curl -fsSL https://opencode.ai/install | bash
fi

echo "==> Instalando la skill tutor-python..."
mkdir -p "$CONF/skills/tutor-python"
if [ -f "$DIR/skills/tutor-python/SKILL.md" ]; then
  cp "$DIR/skills/tutor-python/SKILL.md" "$CONF/skills/tutor-python/SKILL.md"
else
  curl -fsSL "$RAW/skills/tutor-python/SKILL.md" -o "$CONF/skills/tutor-python/SKILL.md"
fi

echo "==> Configurando el agente tutor en $CONF/opencode.json..."
python3 - "$CONF/opencode.json" "$MODELO" <<'PY'
import json, os, shutil, sys
path, modelo = sys.argv[1], sys.argv[2]
cfg = {}
if os.path.exists(path):
    try:
        with open(path) as f:
            cfg = json.load(f)
    except ValueError:
        sys.exit(f"{path} no es JSON válido (¿tiene comentarios?). Arréglalo o bórralo y vuelve a ejecutar.")
    shutil.copy(path, path + ".bak")
cfg.setdefault("$schema", "https://opencode.ai/config.json")
cfg.setdefault("agent", {})["tutor"] = {
    "description": "Tutor de Python: pistas por niveles, nunca la solución completa",
    "mode": "primary",
    "model": modelo,
    "prompt": "{file:./skills/tutor-python/SKILL.md}",
    "permission": {"edit": "deny", "bash": "deny", "webfetch": "deny", "task": "deny"},
}
cfg["default_agent"] = "tutor"
with open(path, "w") as f:
    json.dump(cfg, f, indent=2, ensure_ascii=False)
PY

echo
echo "Listo. Cierra y vuelve a abrir el terminal, entra en la carpeta de tus ejercicios y escribe: opencode"
