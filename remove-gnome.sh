#!/bin/bash

echo "🔧 Starte Entfernung von GNOME-Komponenten..."

# === 1. Schutz deaktivieren (temporär) ===
if ! grep -q "^protected_packages=" /etc/dnf/dnf.conf; then
    echo "→ Schalte temporär Paket-Schutz aus"
    echo "protected_packages=" | sudo tee -a /etc/dnf/dnf.conf
fi

# === 2. GNOME-Pakete entfernen ===
echo "→ Entferne GNOME-Komponenten..."
sudo dnf remove -y \
  gnome-shell \
  gnome-session \
  gnome-control-center \
  gnome-settings-daemon \
  gnome-terminal \
  gnome-software \
  gnome-system-monitor \
  gnome-disk-utility \
  gnome-contacts \
  gnome-calendar \
  gnome-logs \
  gnome-user-docs \
  gnome-themes-extra \
  gnome-backgrounds \
  gnome-bluetooth \
  gnome-classic-session \
  gnome-screenshot \
  mutter \
  nautilus \
  yelp \
  gdm

# === 3. Leichten Display Manager installieren ===
echo "→ Installiere leichten Display Manager (sddm)..."
sudo dnf install -y sddm
sudo systemctl enable sddm

# === 4. Aufräumen ===
echo "→ Bereinige System..."
sudo dnf autoremove -y

# === 5. Schutz zurücksetzen ===
echo "→ Setze Paket-Schutz zurück"
sudo sed -i '/^protected_packages=/d' /etc/dnf/dnf.conf

# === 6. Optional: Zusätzliche Tools für Hyprland (zum Aktivieren auskommentieren) ===
# echo "→ Installiere nützliche Tools für Hyprland..."
# sudo dnf install -y thunar kitty waybar mako grim slurp pavucontrol blueman rofi-wayland

# === 7. Erfolgsmeldung ===
echo "✅ GNOME erfolgreich entfernt. System läuft jetzt unter Hyprland!"
echo "ℹ️ Starte dein System neu, um Reste vollständig zu entladen: sudo reboot"
