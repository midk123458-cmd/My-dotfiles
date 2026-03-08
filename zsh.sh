#!/bin/bash

# 1. Actualización e instalación de paquetes oficiales
sudo pacman -Syu --noconfirm
sudo pacman -S --needed --noconfirm \
amd-ucode base base-devel blueman bluez bluez-utils booster \
cliphist cowsay dhcpcd efibootmgr fastfetch firefox gcc git \
gst-libav gst-plugin-pipewire gst-plugins-bad gst-plugins-base \
gst-plugins-good gst-plugins-ugly hyprland hyprpaper hyprpolkitagent \
inter-font iwd kitty sddm linux linux-firmware linux-lts linux-lts-headers \
mako mpv nano nautilus neohtop networkmanager nm-connection-editor \
otf-font-awesome pavucontrol pipewire pipewire-alsa pipewire-jack \
pipewire-pulse ranger rofi rofimoji rust sudo swww ttf-noto-nerd \
unzip vlc vlc-plugin-ffmpeg waybar wayland-utils waypaper which \
wireplumber wl-clip-persist woff2-font-awesome xdg-desktop-portal-gtk \
xdg-desktop-portal-hyprland xorg-server-xephyr zram-generator zsh

# 2. Instalación de Oh My Zsh (Modo desatendido para que el script siga)
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# 3. Clonar Plugins (Ahora sí funcionará)
ZSH_CUSTOM_DIR=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}

git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM_DIR/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM_DIR/plugins/zsh-syntax-highlighting
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git $ZSH_CUSTOM_DIR/plugins/fast-syntax-highlighting
git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git $ZSH_CUSTOM_DIR/plugins/zsh-autocomplete
git clone https://github.com/zsh-users/zsh-completions $ZSH_CUSTOM_DIR/plugins/zsh-completions

# 4. FastCat y Cambio de Shell
chsh -s $(which zsh)
git clone https://github.com/m3tozz/FastCat.git && cd FastCat && bash ./fastcat.sh --shell

# 5. Cambiar el tema a 'bira'
sed -i 's/^ZSH_THEME=".*"/ZSH_THEME="bira"/' ~/.zshrc

# 6. Activar los plugins en el archivo .zshrc
# Esta línea busca la lista de plugins por defecto y añade los nuevos que instalaste
sed -i 's/^plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting zsh-autocomplete zsh-completions)/' ~/.zshrc
source ~/.zshrc

# Agrega inicio y fin
if ! grep -q "beginning-of-line" ~/.zshrc; then
  cat << EOF >> ~/.zshrc

# Teclas Inicio y Fin
bindkey "\e[H" beginning-of-line
bindkey "\e[F" end-of-line
EOF
fi
echo "Instalación completada. Recuerda añadir los plugins a tu .zshrc manualmente."
