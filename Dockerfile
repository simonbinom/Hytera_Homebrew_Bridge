# Basis-Image mit Python 3.7+ verwenden
FROM python:3.9-slim

# Arbeitsverzeichnis innerhalb des Containers erstellen
WORKDIR /app

# Sicherstellen, dass pip, wheel und setuptools auf dem neuesten Stand sind
RUN python3 -m pip install --no-cache-dir pip wheel setuptools --upgrade

# Hytera Homebrew Bridge installieren
RUN python3 -m pip install --no-cache-dir hytera-homebrew-bridge --upgrade

# Minimal-Config-Datei herunterladen
RUN apt-get update && apt-get install -y curl && \
    curl "https://raw.githubusercontent.com/OK-DMR/Hytera_Homebrew_Bridge/master/settings.ini.minimal.default" -o settings.ini && \
    apt-get remove -y curl && apt-get autoremove -y && rm -rf /var/lib/apt/lists/*

# Ports für UDP freigeben
EXPOSE 54000/udp
EXPOSE 54001/udp

# Befehl zum Starten der Bridge
CMD ["python3", "-u", "hytera-homebrew-bridge.py", "settings.ini"]