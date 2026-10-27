#!/usr/bin/env bash
# Comprueba que OpenCode ve la skill y que el agente tutor no puede editar ni ejecutar.
set -uo pipefail
export PATH="$HOME/.opencode/bin:$PATH"
ok=0
opencode debug skill 2>/dev/null | grep -q '"name": "tutor-python"' && echo "OK  skill tutor-python encontrada" || { echo "ERROR  no se encuentra la skill"; ok=1; }
deny=$(opencode debug agent tutor 2>/dev/null | python3 -c '
import sys, json
t = sys.stdin.read()
d = json.loads(t[t.index("{"):t.rindex("}") + 1])
print(" ".join(sorted(p["permission"] for p in d["permission"] if p["action"] == "deny")))' 2>/dev/null)
for p in edit bash webfetch task; do
  [[ " $deny " == *" $p "* ]] && echo "OK  agente tutor: $p bloqueado" || { echo "ERROR  agente tutor: $p no bloqueado"; ok=1; }
done
exit $ok
