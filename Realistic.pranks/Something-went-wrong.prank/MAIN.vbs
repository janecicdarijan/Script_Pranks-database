dim answer
dim shell
set shell = CreateObject("WScript.Shell")

msgbox "Scanning system...", 64, "Totally Legit Virus"
msgbox "Suspicious file detected.", 48, "Totally Legit Virus"

answer = msgbox("Delete suspicious_file.exe?", 52, "Totally Legit Virus")

if answer = 6 then
    shell.Run "payload.bat"
else
    msgbox "Wise choice. Your PC survives today.", 64, "Totally Legit Virus"
end if