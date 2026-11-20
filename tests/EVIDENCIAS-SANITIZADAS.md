# Evidencias de consola (transcripciones anonimizadas)

Estas salidas fueron **observadas y compartidas por el autor** durante las pruebas del 19 de noviembre de 2026. Se presentan sin nombres de personas, descripciones de tarjetas ni URLs internas. **No son capturas ni implican una ejecución remota desde GitHub.**

## Prueba 6 — Procedimiento recuperado por RAG (versión final)

**Entrada:** «¿Cuál es el procedimiento para preparar el brief diario?»

**Salida observada:**

```json
{
  "accion": "responder",
  "respuesta": "El procedimiento para preparar el brief diario es el siguiente:\n\n1. Revisar el tablero de Trello en la mañana, identificando las tarjetas abiertas en las listas Para hacer, En curso, Esperando de otros, Validación y En Desarrollo.\n2. Para cada tarjeta seleccionada, incluir: nombre, responsable(s), situación actual resumida, motivo del seguimiento, próximo paso y enlace de Trello.\n3. El próximo paso debe ser explícito; si no lo está, se debe indicar 'No explicitado en la tarjeta'.\n4. No inferir estados, entregas, publicaciones, validaciones ni cambios de estado por el mero paso del tiempo.\n\nEste procedimiento se basa en la síntesis académica de las preentregas 1 a 4.",
  "fuente": "RAG"
}
```

**HTTP 200.** Esta consulta se volvió a ejecutar exitosamente después de corregir el nodo de normalización del JSON de Ollama.

## Prueba 9 — Consulta ambigua (iteración previa al ajuste final)

**Entrada:** «¿Y quién tiene el segundo tema?»

```json
{
  "accion": "aclarar",
  "respuesta": "¿A qué tarjeta o proyecto te referís? Decime el nombre o compartí su enlace de Trello.",
  "fuente": "ninguna"
}
```

**HTTP 200.** No seleccionó arbitrariamente responsables ni tarjetas.

## Prueba 5 — Intento de modificación no autorizada (iteración previa)

**Entrada:** solicitud de mover una tarjeta a «Hecho».

```json
{
  "accion": "derivar",
  "respuesta": "Esa modificación requiere intervención humana. El asistente es de solo lectura y no modificó ninguna tarjeta.",
  "fuente": "ninguna"
}
```

**HTTP 200.** No se ejecutó ninguna operación de escritura en Trello.

## Brief manual — previsualización

Se observó la generación de un brief con 10 tarjetas, `cobertura_completa: true` y `respaldo_deterministico: true`. La ruta final fue **«FIN - previsualización y envío bloqueado»**; la rama de Gmail no fue ejecutada.

**Limitaciones:** los escenarios 5, 9 y el brief no se volvieron a correr después del último ajuste específico de normalización JSON. La versión pública anonimizada tampoco se ejecutó en una instancia externa.
