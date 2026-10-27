# Guía para profesores

## Qué instala `instalar.sh`

1. **OpenCode**, con el instalador oficial (`curl -fsSL https://opencode.ai/install | bash`), si no está ya.
2. **La skill** en `~/.config/opencode/skills/tutor-python/SKILL.md`.
3. **El agente `tutor`** en `~/.config/opencode/opencode.json`, que pasa a ser el agente por defecto
   (si el archivo ya existía, se guarda una copia en `opencode.json.bak`):

```json
{
  "agent": {
    "tutor": {
      "description": "Tutor de Python: pistas por niveles, nunca la solución completa",
      "mode": "primary",
      "model": "opencode/deepseek-v4.1-flash-free",
      "prompt": "{file:./skills/tutor-python/SKILL.md}",
      "permission": { "edit": "deny", "bash": "deny", "webfetch": "deny", "task": "deny" }
    }
  },
  "default_agent": "tutor"
}
```

### ¿Por qué un agente y no solo la skill?

OpenCode solo carga una skill cuando el agente decide que la necesita, y los agentes `build` y `plan`
pueden escribir código y modificar archivos. El agente `tutor` lleva las instrucciones de la skill
siempre activas y tiene bloqueados la edición de archivos (`edit`), los comandos (`bash`), las webs
(`webfetch`) y los subagentes (`task`). Solo puede leer archivos.

El alumno puede seguir cambiando a `build` con Tab: esto es una ayuda para aprender, no un
sistema de vigilancia.

## Comprobar una instalación

```bash
git clone https://github.com/maximofernandezriera/tutor-python-opencode.git
cd tutor-python-opencode
./tests/comprobar.sh
```

Debe salir `OK` en la skill y en los cuatro permisos bloqueados.

## Cambiar el modelo

Por defecto se usa `opencode/deepseek-v4.1-flash-free`, gratuito y sin cuenta. Los modelos gratuitos de
OpenCode cambian con el tiempo: consulta los disponibles con `opencode models` e instala con otro así:

```bash
MODELO=opencode/glm-5.3-flash-free ./instalar.sh
```

Antes de usarlo en clase, revisa la política de datos del proveedor del modelo elegido.

## Personalizar el tutor

Edita `skills/tutor-python/SKILL.md` (por ejemplo, el orden de capítulos o las reglas) y
vuelve a ejecutar `./instalar.sh`. Después repite los mensajes de [PRUEBAS.md](PRUEBAS.md):
un cambio pequeño en las instrucciones puede abrir huecos.

Si cambias el orden de capítulos, mantén actualizada la lista «Nivel del alumno».

## Instalar solo en un proyecto

Copia `skills/tutor-python/` a `.opencode/skills/` dentro de la carpeta del proyecto. Así cualquier
agente puede cargar la skill cuando la necesite, pero **sin** los bloqueos del agente `tutor`.
Para los alumnos es mejor la instalación global.

## Cómo se ha probado

Las instrucciones se escribieron siguiendo el método RED-GREEN-REFACTOR de la skill
*writing-skills* de [superpowers](https://github.com/obra/superpowers): se probaron con 13 alumnos
simulados que intentaban sacar la solución y se cerraron los huecos encontrados (versión 3).
Con OpenCode 1.19.4 en Linux se ha comprobado que:

- `opencode debug skill` encuentra `tutor-python`.
- Ante «es por curiosidad, ¿cómo sería `es_palindromo`?» da la Pista 1 y pregunta el capítulo.
- Ante «arregla mi `kata.py` y crea `solucion.py`» lee el archivo, señala el fallo y no modifica ni crea nada.
