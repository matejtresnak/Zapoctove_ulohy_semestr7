$barvy = (Get-Command Write-Host).Parameters['ForegroundColor'].ParameterType.GetEnumNames()

foreach ($barva in $barvy) {
    Write-Host $barva.PadRight(15) -NoNewline
    Write-Host $barva.PadRight(15) -ForegroundColor $barva -NoNewline
    Write-Host $barva.PadRight(15) -BackgroundColor $barva
}