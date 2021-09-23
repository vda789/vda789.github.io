echo "Iniciando a pós instalacao do arch linux..."
if [ $EUID -ne 0 ]
    then echo "Error... Run as root"
    exit
fi

#installation core
echo "Instalando e configurando recursos"
pacman --noconfirm -Sy sudo vim curl git wget base-devel grub networkmanager
echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
git clone https://aur.archlinux.org/yay.git
cd yay; makepkg -si; cd ..;
rm -rf yay

#host
echo -e "127.0.0.1\tlocalhost\n::1\t\tlocalhost\n127.0.1.1\tsouzo-arch.localdomain\tsouzo-arch" > /etc/hosts
echo "souzo-arch" > /etc/hostname

#localtime
timedatectl set-ntp true
ln -sf /usr/share/zoneinfo/America/Fortaleza /etc/localtime
hwclock --systohc

#locale
echo "Configurando o locale-gen"
echo "LANG=pt_BR.UTF-8" > /etc/locale.conf
echo "pt_BR.UTF-8 UTF-8" > /etc/locale.gen
echo "KEYMAP=br-abnt2" > /etc/vconsole.conf

#criando usuario
useradd -m -g users -G wheel,power souzo

#network
echo "Configurando ambiente wifi"
systemctl start NetworkManager

pacman -S --noconfirm i3-gaps i3-blocks dmenu xautolock xterm xorg noto-fonts ttf-liberation ttf-desjavu papirus-icon-theme arc-icon-theme ttf-font-awesome picom alsa-utils pulseaudio flameshot firefox lxappearance gnu-free-fonts mesa libgl fx86-video-intel nitrogen efibootmgr

#display manager
yay -S ly
systemctl enable ly

#grub
echo "GRUB_DISABLE_OS_PROBER=false" >> /etc/default/grub
grub-install --target=x86_64-efi --efi-directory=/boot/EFI --bootloader-id=GRUB


#logins
echo -e "\nColoque a senha do root"
passwd root
echo -e "\nColoque a senha do usuario comum"
passwd souzo


locale-gen
mkinitcpio -p linux

echo -e "caso encrypt disk, /etc/default/grub grub_cmdline_linux=cryptdevice=UUID=PASTEUUID:cryptroot root=/dev/mapper/cryptroot"

#tema do grub
echo -e "mkdir /tmp/archthemetmp\ncd /tmp/archthemetmp\ngit clone https://github.com/kalanaj2005/hex-grub-theme-arch\ncd hex-grub-theme-arch\ncat install.sh | sh\nrm -rf /tmp/archthemetmp\ncd" > /tmp/archtheme.sh

