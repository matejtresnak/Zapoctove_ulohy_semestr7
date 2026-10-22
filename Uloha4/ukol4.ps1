function Test-Palindrom {
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [string]$Text
    )

    process {
        # 1. Rozložení znaků na základní písmena a diakritická znaménka (FormD)
        $normalized = $Text.Normalize([System.Text.NormalizationForm]::FormD)

        # 2. Odstranění diakritiky (\p{Mn}), mezer a interpunkce + převod na malá písmena
        $cleaned = ($normalized -replace '\p{Mn}', '' -replace '[^a-zA-Z0-9]', '').ToLower()

        # 3. Otočení vyčištěného řetězce přes pole znaků
        $charArray = $cleaned.ToCharArray()
        [array]::Reverse($charArray)
        $reversed = -join $charArray

        # 4. Porovnání a vrácení výsledného objektu
        $isPalindrome = ($cleaned -eq $reversed)
        
        [PSCustomObject]@{
            ZadanyText  = $Text
            CistyTvar   = $cleaned
            OtocenyTvar = $reversed
            JePalindrom = $isPalindrome
        }
    }
}

# --- 1. ČÁST: Testovací sada ze zadání ---
$testovaciVety = @(
    "Jelenovi pivo nelej",
    "Kobyla má malý bok",
    "Kupředu udeř puk",
    "Dal kopat Ota poklad"
)

Write-Host "=== Automatický test vzorových vět ===" -ForegroundColor Cyan
$testovaciVety | Test-Palindrom | Format-Table -AutoSize


# --- 2. ČÁST: Vlastní vstup z konzole ---
Write-Host "=== Vlastní testování ===" -ForegroundColor Cyan
$vlastniText = Read-Host -Prompt "Zadejte vlastní text pro ověření palindromu"

# Kontrola, zda uživatel nezadal prázdný text (jen neodklepl Enter)
if (-not [string]::IsNullOrWhiteSpace($vlastniText)) {
    $vysledek = Test-Palindrom -Text $vlastniText
    $vysledek | Format-Table -AutoSize
} else {
    Write-Host "Nebyl zadán žádný text." -ForegroundColor Yellow
}