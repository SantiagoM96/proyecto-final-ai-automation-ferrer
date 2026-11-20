# Entrega del Proyecto Final — AI Automation

**Autor:** Santiago Ferrer  
**Fecha de las pruebas:** 19/11/2026  
**Modalidad:** prototipo ejecutado en n8n local; entrada de WhatsApp simulada por Webhook HTTP.

## Archivo principal para evaluación

**[Workflow público n8n: 58 nodos](workflow/asistente-trello-ollama-rag.json)**

Esta es la exportación definitiva anonimizada del workflow probado. Se conservaron los nodos y las conexiones; se quitaron credenciales y se sustituyeron los identificadores privados del tablero y de cinco listas por marcadores. Para ejecutar una copia externa es necesario configurar esos valores.

## Qué se implementó

- **Dos orígenes de datos**: Webhook HTTP (consulta simulando la estructura WhatsApp) y API de Trello (tarjetas, miembros, listas y fechas).
- **AI Agent local con Ollama Qwen2.5 7B**: decide responder, pedir aclaración o derivar; utiliza memoria por remitente.
- **RAG**: ocho síntesis académicas, separación en fragmentos, embeddings `nomic-embed-text`, Simple Vector Store en memoria y recuperación documental.
- **Seguimientos y brief diario**: selección determinística, resumen mediante Basic LLM Chain, control de cobertura y ruta segura de previsualización.
- **Seguridad y manejo de errores**: sin escritura sobre Trello; validaciones de formato, evidencia y datos; fallos controlados por HTTP y sin envío real de Gmail en las pruebas.

## Pruebas y evidencias

- [Resultados HTTP y limitaciones de las pruebas](tests/RESULTADOS-REALES.md)
- [Salidas de consola representativas, anonimizadas](tests/EVIDENCIAS-SANITIZADAS.md)
- [Guía de las capturas reales de n8n](capturas/LEER.md)
- [Diagrama de arquitectura](docs/ARQUITECTURA.md)
- [Script de pruebas PowerShell](tests/probar-asistente-final.ps1)
- [README completo, ROI y System Prompt](README.md)

La **prueba 6** de RAG se revalidó en el workflow final y devolvió HTTP 200, `accion: responder`, `fuente: RAG`. Las pruebas 5 y 9 se comprobaron en una iteración anterior al último ajuste de normalización; el cambio final no se sometió a una repetición exhaustiva de todos los escenarios. El brief se previsualizó sin envío de correo.

## Alcance y limitaciones declarados

No se implementó la integración oficial de WhatsApp/Meta ni un despliegue HTTPS público. El Vector Store se reconstruye en memoria; las credenciales y el tablero real no están incluidos en el repositorio; Gmail **no se ejecutó realmente**. El ROI de 16 h 40 min/mes (83,33 %) es una proyección académica, no ahorro observado en producción.

Se omitieron capturas con información operativa municipal para no divulgar nombres, descripciones de tarjetas o enlaces internos. Las evidencias escritas son transcripciones resumidas de ejecuciones reales, no capturas fabricadas.

**La copia pública requiere reconfiguración y no fue ejecutada nuevamente después de anonimizarla.**
