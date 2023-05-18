yay -S awesome-git rofi-git picom-jonaburg-git ttf-meslo-nerd-font-powerlevel10k

sudo pacman -S papirus-icon-theme pulseaudio-alsa upower bluez bluez-utils xorg-setxkbmap xfce4-power-manager playerctl lightdm light-locker alacritty thunar flameshot

cd
git clone --recurse-submodules https://github.com/Crylia/crylia-theme
cd crylia-theme
cp -r awesome ~/.config/.
cp -r picom.conf ~/.config/.
cp -r rofi ~/.config/.
cp -r alacritty ~/.config/.
