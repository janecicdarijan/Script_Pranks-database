@echo off
echo Sredjujem tvoj Windows... Molim sacekaj.

:: 1. Primeni Windows Dark temu (sa tvoje slike)
:: Koristimo start komandu da pokrenemo .theme fajl koji automatski menja pozadinu i boje
start "" "C:\Windows\Resources\Themes\dark.theme"

:: 2. Centriraj Taskbar (1 = Centar)
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAl /t REG_DWORD /d 1 /f

:: 3. Ugasi suvisne ikonice (Search, Task View, Widgets, Chat)
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v SearchboxTaskbarMode /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowTaskViewButton /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarDa /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarMn /t REG_DWORD /d 0 /f

:: Kratka pauza da sistem procesira temu pre restarta explorera
timeout /t 2 /nobreak >nul

:: Restartuj Explorer da se taskbar osvezi
taskkill /f /im explorer.exe
start explorer.exe

echo Sve je sredjeno! Uzivaj u tamnoj temi.
exit