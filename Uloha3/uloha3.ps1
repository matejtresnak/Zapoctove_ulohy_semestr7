Write-Host "--- 1. VYTVARIM ALIASY A ZALOHUJI ---" -ForegroundColor Cyan
Set-Alias -Name np -Value notepad.exe
Set-Alias -Name ct -Value control.exe

# Zaloha do JSON a XML
Get-Alias np, ct | Select-Object Name, Definition | ConvertTo-Json | Out-File ".\aliasy.json" -Encoding utf8
Get-Alias np, ct | Select-Object Name, Definition | Export-Clixml ".\aliasy.xml"
Get-Alias np, ct

Write-Host "`n--- 2. MAZU ALIASY ---" -ForegroundColor Yellow
Remove-Item Alias:np, Alias:ct -ErrorAction SilentlyContinue
if (-not (Get-Alias np, ct -ErrorAction SilentlyContinue)) {
    Write-Host "Aliasy byly uspesne smazany!" -ForegroundColor Red
}

Write-Host "`n--- 3. OBNOVUJI Z JSONU ---" -ForegroundColor Green
(Get-Content ".\aliasy.json" -Raw | ConvertFrom-Json) | ForEach-Object {
    Set-Alias -Name $_.Name -Value $_.Definition
}
Get-Alias np, ct

Write-Host "`n--- 4. ZNOVU MAZU ALIASY ---" -ForegroundColor Yellow
Remove-Item Alias:np, Alias:ct -ErrorAction SilentlyContinue
if (-not (Get-Alias np, ct -ErrorAction SilentlyContinue)) {
    Write-Host "Aliasy byly uspesne smazany!" -ForegroundColor Red
}

Write-Host "`n--- 5. OBNOVUJI Z XML ---" -ForegroundColor Green
(Import-Clixml ".\aliasy.xml") | ForEach-Object {
    Set-Alias -Name $_.Name -Value $_.Definition
}
Get-Alias np, ct