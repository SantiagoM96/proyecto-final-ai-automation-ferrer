# Arquitectura del workflow definitivo (58 nodos)

Este es un **diagrama funcional esquemático**, realizado a partir de la exportación de n8n. No sustituye una captura de pantalla ni representa cada uno de los 58 nodos.

```mermaid
flowchart TD
    A[Webhook HTTP simulado] --> V[Validar entrada]
    M[Manual Trigger para brief] --> V
    S[Schedule Trigger 09:00 lun-vie] --> V
    V --> T[Trello API - lectura]
    T --> D{Consulta o brief?}
    D -->|Consulta| C[Resolver consultas determinísticas]
    C -->|Consulta simple| R[Respond to Webhook]
    C -->|Requiere IA| I[Preparar contexto]
    I --> Q{Consulta documental?}
    Q -->|Sí| E[RAG: indexar / embeddings / recuperar]
    Q -->|No| AG[AI Agent + Ollama]
    E --> AG
    AG --> N[Normalizar JSON de respuesta]
    N --> F{Validar fuente, acción y evidencia}
    F -->|Válido| R
    F -->|No válido| ER[Respuesta de error controlado]
    ER --> R
    D -->|Brief| B[Seleccionar seguimientos]
    B --> L[Basic LLM Chain + Ollama]
    L --> CO[Validar cobertura / respaldo determinístico]
    CO --> P{¿Ejecución de prueba sin correo?}
    P -->|Sí| NO[Fin: previsualización]
    P -->|No, envío autorizado| G[Gmail]
```

## Controles del prototipo

- El agente no tiene herramientas para editar Trello. Los cambios se derivan a intervención humana.
- `due` se interpreta como **fecha de seguimiento**, no vencimiento de entrega.
- RAG usa fragmentos de las preentregas académicas y nunca sustituye los datos operativos actuales.
- El normalizador de JSON está aislado en un nodo `Code`; los `IF` posteriores comprueban evidencia y formato.
- El modo manual de brief no envía Gmail.
- El Vector Store es de memoria y se reconstruye durante el recorrido documental.

Para reproducirlo se requieren credenciales locales de Trello, Ollama y Header Auth, y el reemplazo de los IDs privados indicados en [README.md](../README.md).
