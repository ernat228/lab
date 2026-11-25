# Lab 5 - convert staff-broken.csv from RK1048 to UTF-8 with BOM, CRLF kept
# Run from the lab05-encoding folder:  powershell -ExecutionPolicy Bypass -File .\scripts\fix.ps1
$in  = Join-Path $PWD 'evidence\staff-broken.csv'
$out = Join-Path $PWD 'evidence\staff-fixed.csv'
$cp  = [Text.Encoding]::GetEncoding(1251)

# bytes where RK1048 differs from CP1251 -> Unicode code point
$map = @{
  0x8D=0x049A; 0x8E=0x04BA; 0x9D=0x049B; 0x9E=0x04BB
  0xA1=0x04B0; 0xA2=0x04B1; 0xA3=0x04D8; 0xA5=0x04E8
  0xAA=0x0492; 0xAF=0x04AE; 0xB4=0x04E9; 0xBA=0x0493
  0xBC=0x04D9; 0xBD=0x04A2; 0xBE=0x04A3; 0xBF=0x04AF
}

$bytes = [IO.File]::ReadAllBytes($in)
$sb = New-Object Text.StringBuilder
foreach ($x in $bytes) {
  if ($map.ContainsKey([int]$x)) { [void]$sb.Append([char]$map[[int]$x]) }
  else { [void]$sb.Append($cp.GetString([byte[]]@($x))) }
}
$text = $sb.ToString()
# $text = $text -replace "`r`n", "`n"     # only if you want LF

$utf8 = New-Object Text.UTF8Encoding($true)   # $true = write BOM
[IO.File]::WriteAllText($out, $text, $utf8)
