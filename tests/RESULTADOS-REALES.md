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
