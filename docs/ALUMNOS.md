# Guía para alumnos

## 1. Instalar

Necesitas Linux o macOS con `curl` y `python3` (normalmente ya vienen instalados).
Abre un terminal y pega:

```bash
curl -fsSL https://raw.githubusercontent.com/maximofernandezriera/tutor-python-opencode/main/instalar.sh | bash
```

Cuando acabe, **cierra el terminal y ábrelo otra vez**.

> En Windows: instala [WSL](https://learn.microsoft.com/es-es/windows/wsl/install)
> (Ubuntu) y ejecuta el mismo comando dentro de la terminal de Ubuntu.

## 2. Usar

```bash
cd carpeta-de-tus-ejercicios
opencode
```

Abajo a la derecha tiene que poner **tutor**. Si pone `build` o `plan`, pulsa **Tab** hasta que salga `tutor`.

Escribe tu duda y pulsa Intro. Algunos ejemplos:

- «Estoy en el capítulo 5. No sé cómo empezar el ejercicio de los números pares.»
- «Mira mi `kata.py`, no da el resultado que espero.»
- «¿Qué diferencia hay entre `print` y `return`?»
- «Me sale este error: `TypeError: can only concatenate str (not "int") to str`»

Para salir: escribe `/exit` o pulsa **Ctrl+C**.

## 3. Cómo te ayuda

El tutor **no te va a dar la solución**: te ayuda a que la encuentres tú.

1. Te preguntará en qué capítulo de *Think Python* estás y qué has probado.
2. Si te atascas, pide la siguiente pista. Hay tres:
   - **Pista 1:** la idea que necesitas.
   - **Pista 2:** los pasos, explicados con palabras.
   - **Pista 3:** un ejemplo resuelto de **otro** problema parecido.
3. El código lo escribes y lo ejecutas tú (por ejemplo, `python3 kata.py`).

Las preguntas de teoría («¿qué es una lista?») sí te las explica directamente.

## 4. Problemas frecuentes

| Problema | Solución |
|---|---|
| `opencode: command not found` | Cierra el terminal y ábrelo de nuevo. Si sigue, ejecuta `~/.opencode/bin/opencode`. |
| No sale `tutor` abajo a la derecha | Pulsa Tab. Si no aparece, vuelve a ejecutar el instalador. |
| Dice que el modelo no existe o no responde | El modelo gratuito puede haber cambiado. Avisa al profesor. |
| Falta `python3` | Linux: `sudo apt install python3`. macOS: `xcode-select --install`. |

Para desinstalarlo:

```bash
curl -fsSL https://raw.githubusercontent.com/maximofernandezriera/tutor-python-opencode/main/desinstalar.sh | bash
```
