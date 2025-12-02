$OutputDirectory = ".\bin"
$ExecutableName = "output.exe"
$SourceFile = ".\main.cpp"

$ExecutablePath = Join-Path -Path $OutputDirectory -ChildPath $ExecutableName

mkdir $OutputDirectory -ea 0

cl.exe /nologo /utf-8 /EHsc /GS- `
    /MD /O2 /Oi /Oy /Ob2 /Gw /Gy /GF /GL `
    /Fe:"$ExecutablePath" "$SourceFile" `
    /link /IGNORE:4254,4108 /NOLOGO /OPT:REF /OPT:ICF /MERGE:.rdata=.text /MERGE:.data=.text `
    /RELEASE /SUBSYSTEM:WINDOWS /ALIGN:16 /LTCG /emittoolversioninfo:no # no /FIXED for stability

if ($LASTEXITCODE -eq 0) {
    $Binary = Get-Item $ExecutablePath -ErrorAction SilentlyContinue
    if ($null -ne $Binary) {
        $FileSize = $Binary.Length
        Write-Host "Binary size: $($FileSize.ToString("N0")) bytes" -ForegroundColor Green
    } else {
        Write-Host "Error: Compilation succeeded, but the executable was not found at $ExecutablePath." -ForegroundColor Yellow
    }
} else {
    Write-Host "Error: cl.exe compilation failed (Exit code: $LASTEXITCODE)." -ForegroundColor Red
}

$ObjectFile = (Get-Item $SourceFile).BaseName + ".obj"
Remove-Item $ObjectFile -ErrorAction SilentlyContinue
