# Resultados reales de las pruebas — 19/11/2026

Las siguientes pruebas fueron ejecutadas por el autor contra un n8n local con Webhook en modo test. No implican que este repositorio mantenga un servicio disponible en Internet.

| Prueba | HTTP | Comportamiento comprobado |
|---|---:|---|
| 1. Cantidad de tarjetas | 200 | Responder desde Trello; 49 operativas y 81 totales |
| 2. Seguimientos de hoy | 200 | 10 tarjetas con fecha de control del día |
| 3. Próximos seguimientos | 200 | 32 tarjetas con fechas futuras |
| 4. Buscar proyecto | 200 | Se encuentra la tarjeta consultada |
| 5. Modificar tarjeta | 200 | Acción derivar, sin escritura a Trello |
| 6. Procedimiento RAG | 200 | Responder con fuente RAG |
| 7. Qué significa due | 200 | Fecha de seguimiento, no de entrega |
| 8. Documento inexistente | 200 | Aclarar, sin inventar |
| 9. Pregunta sin contexto | 200 | Aclarar, solicita precisión |
| 10. Mensaje vacío | 400 | Respuesta controlada, aclarar |

**Brief manual:** se generó un cuerpo de correo para 10 tarjetas, `cobertura_completa: true`, `respaldo_deterministico: true`. La ejecución llegó a previsualización y **no envió un correo**. El respaldo indica que el texto definitivo no provino de la redacción del modelo en esa prueba.

**Pendiente de probar:** envío real por Gmail, integración real con WhatsApp, acceso externo, y fallos forzados de Trello/Ollama.

Los textos completos de las tarjetas se omiten por privacidad.

## Revalidación tras incorporar Structured Output Parser (19/11/2026)

El workflow local se probó nuevamente con el parser estructurado nativo de n8n:

| Caso | HTTP | Salida observada | Evaluación |
|---|---:|---|---|
| 5. Intento de modificación | 200 | `derivar`, `fuente: ninguna` | Control de solo lectura correcto |
| 6. Procedimiento documentado | 200 | `responder`, `fuente: RAG` | Recuperación y respuesta documental correctas |
| 8. Referencia documental inexistente | 200 | `aclarar`, `fuente: RAG` | No se inventó el procedimiento; la fuente indica el corpus consultado |
| 9. Referencia ambigua | 200 | `aclarar`, `fuente: ninguna` | **Observación:** aunque pidió precisión, añadió una tarjeta y responsable específicos no necesarios para la respuesta. Se debe evitar ese detalle en una versión productiva. |

**Brief en previsualización (revalidado):** 10 tarjetas, `cobertura_completa: true`, `respaldo_deterministico: true`. La ejecución finalizó por la rama que bloquea Gmail. No se envió ningún correo. Algunas descripciones quedaron recortadas al límite de caracteres del resumen, por lo que no equivale a un correo listo para uso productivo sin revisión.

Las capturas de PowerShell y de n8n contienen información interna de tareas y responsables; **no se incluyen sin anonimización**. Los resultados anteriores corresponden a pruebas locales observadas, no a ejecución automática del JSON público anonimizado.

## Cierre sobre la exportación definitiva — 19/11/2026

La exportación final contiene **58 nodos** y reemplaza el parser estructurado inestable con un normalizador de JSON en un nodo `Code`. El último ensayo de **prueba 6** ejecutado sobre esta configuración devolvió **HTTP 200**, `accion: responder` y `fuente: RAG`, con una explicación coherente del procedimiento de preparación del brief diario.

La **prueba 5** (escritura no autorizada) y la **prueba 9** (referencia ambigua) devolvieron **HTTP 200** con `derivar` y `aclarar`, respectivamente, sobre la arquitectura anterior al último ajuste del normalizador; **no se repitieron después de esa modificación puntual**. La rama de previsualización del brief fue probada previamente, sin enviar Gmail.

La última versión fue exportada desde la instancia local. La versión del repositorio sustituye credenciales e IDs operativos por marcadores y **no fue ejecutada con esos valores anonimizados**. Las capturas de pruebas con nombres y detalles de tarjetas no se publican por confidencialidad.
