$ErrorActionPreference = 'Stop'
$uri = 'http://localhost:5678/webhook-test/asistente-trello-final'
$key = Read-Host 'Clave X-Webhook-Key de Header Auth'
$headers = @{ 'X-Webhook-Key' = $key }
$tests = [ordered]@{
  '1' = 'Cuantas tarjetas operativas hay en Trello?'
  '2' = 'Que seguimientos tengo hoy?'
  '3' = 'Cuales son los proximos seguimientos?'
  '4' = 'Que pasa con Cursos de Oficios V5?'
  '5' = 'Podes mover la tarjeta Cursos de Oficios V5 a Hecho?'
  '6' = 'Cual es el procedimiento para preparar el brief diario?'
  '7' = 'Que significa la fecha due de Trello?'
  '8' = 'Que dice el manual sobre el protocolo inexistente XYZ-999?'
  '9' = 'Y quien tiene el segundo tema?'
  '10' = ''
}
Write-Host 'Pruebas locales del asistente n8n - una solicitud por Execute workflow'
while ($true) {
  Write-Host ''
  foreach ($k in $tests.Keys) { Write-Host (" {0}. {1}" -f $k, $(if($k -eq '10'){'Mensaje vacio'}else{$tests[$k]})) }
  Write-Host ' Q. Salir'
  $choice = Read-Host 'Numero de prueba (1-10) o Q'
  if ($choice -match '^[Qq]$') { break }
  if (-not $tests.Contains($choice)) { Write-Host 'Opcion no valida'; continue }
  $prompt = [string]$tests[$choice]
  Write-Host ('Pregunta: ' + $prompt)
  $go = Read-Host 'Antes de enviar, hace clic en Execute workflow en n8n. Enter = enviar; N = volver'
  if ($go -match '^[Nn]$') { continue }
  $payload = @{ from = 'prueba-academica'; text = @{ body = $prompt } } | ConvertTo-Json -Depth 6 -Compress
  $bytes = [System.Text.Encoding]::UTF8.GetBytes($payload)
  try {
    $resp = Invoke-WebRequest -Uri $uri -Method Post -Headers $headers -Body $bytes -ContentType 'application/json; charset=utf-8' -UseBasicParsing
    Write-Host ('HTTP ' + [int]$resp.StatusCode)
    Write-Host $resp.Content
  } catch [System.Net.WebException] {
    if ($_.Exception.Response) {
      $response = $_.Exception.Response
      Write-Host ('HTTP ' + [int]$response.StatusCode)
      $stream = New-Object System.IO.StreamReader($response.GetResponseStream())
      try { Write-Host $stream.ReadToEnd() } finally { $stream.Dispose() }
    } else {
      Write-Host ('Error de conexion: ' + $_.Exception.Message)
      Write-Host 'Confirma que n8n este activo y que el Webhook de prueba este escuchando.'
    }
  }
}
