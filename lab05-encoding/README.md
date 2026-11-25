# Lab 5 — Encoding forensics

## Diagnosis (before the fix)
file says: `Non-ISO extended-ASCII text, with CRLF line terminators` (evidence/file-before.txt; file 5.45)

First 16 bytes (evidence/hexdump-before.txt):
`D2 E0 E1 2E B9 3B D4 C8 CE 3B C4 EE EB E6 ED EE`

| Offset | Bytes | What they are |
|---|---|---|
| 00-02 | D2 E0 E1 | "Таб" as single-byte Cyrillic. No BOM: the file does not start with EF BB BF |
| 03 | 2E | "." |
| 04 | B9 | "№" |
| 05 | 3B | ";" the column separator (semicolon) |
| 06-08 | D4 C8 CE | "ФИО" |
| 09 | 3B | ";" |
| 10-15 | C4 EE EB E6 ED EE | "Должно" (start of "Должность") |

The first non-ASCII byte is D2 followed by E0, which is not a valid UTF-8 sequence (a lead byte D2 needs a continuation byte 80-BF). So the file is not UTF-8; every Cyrillic letter is one byte.

Encoding: **RK1048** (Kazakh single-byte code page) — evidence: decoding as CP1251 gives
"Ќасымова Јлия Серікќызы", decoding as RK1048 gives "Қасымова Әлия Серікқызы".
The 12 bytes that differ between the two are 8D 8E 9D A2 A3 A5 AA AF B4 BC BE BF
(Қ Һ қ ұ Ә Ө Ғ Ү ө ә ң ү). CP866 and KOI8-R give nonsense. PT154 was not tested
(not available in .NET Framework / PowerShell 5.1).
Line ending: **CRLF** — evidence: 26 CR and 26 LF bytes, 26 lines, no mixed endings.
BOM: **absent** — evidence: the file starts with D2 E0 E1.
Separator: semicolon. SHA256 of the original: `919027F1F8C71D85CBA3F12AAD0F6C927D4E0450CFB2A2D63378A69F14CAB270` (checked again at the end, unchanged).

## What each application was doing wrong
Excel: assumed the system ANSI code page (CP1251) because there is no BOM, so the Kazakh letters became Ќ Ћ ќ ў Ј Ґ Є Ї ґ ј ѕ ї; Russian letters still looked right because CP1251 and RK1048 agree on them.
LibreOffice: not tested on the original, to keep it untouched. On the fixed file Calc detected UTF-8 by itself (see Verification).
cat / terminal: expects UTF-8; the bytes are not valid UTF-8, so it prints replacement characters or nothing readable.

## Fix
Script: scripts/fix.ps1 (Windows PowerShell 5.1, run from the lab05-encoding folder)
Changed: encoding RK1048 -> UTF-8; line ending kept (CRLF); BOM added (EF BB BF)
because Excel opening by double-click decides it: without a BOM it assumes CP1251 and breaks the Kazakh letters.
.NET Framework has no RK1048, so the script reads the bytes as CP1251 and replaces the bytes that RK1048 defines differently with the correct Kazakh letters.
Result checked independently: staff-fixed.csv equals BOM + the original decoded as RK1048, byte for byte.

## Verification
file after: `Unicode text, UTF-8 (with BOM) text, with CRLF line terminators` (evidence/file-after.txt)
First bytes of the fixed file: `EF BB BF D0 A2 D0 B0 D0` (one BOM, no double BOM)
Opened in: Excel 16.0.20527.20150 (unactivated; opened by double-click, not the import wizard), LibreOffice Calc 26.8.3.1 (import dialog proposed "Unicode (UTF-8)", nothing changed), PowerShell `Get-Content -Encoding UTF8` on Windows 11 in place of cat — evidence/opens-correctly.png (combined from three separate screenshots).
Original unchanged: SHA256 identical to the value above.

Note: Windows PowerShell has no `file` command, so `file` 5.45 was run on the same two files (checksum verified) outside my Windows machine. CRLF was kept on purpose, so the awk check would show the "|" at the start of the line.
