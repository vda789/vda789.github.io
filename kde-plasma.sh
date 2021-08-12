echo "Iniciando a pós instalacao do arch linux..."
if [ $EUID -ne 0 ]
    then echo "Error... Run as root"
    exit
fi

#installation core
echo "Instalando e configurando recursos"
pacman --noconfirm -Sy sudo vim curl git wget base-devel sddm grub networkmanager pulseaudio-alsa pulseaudio alsa-utils alsa-lib alsa-firmware alsa-plugins flameshot xf86-video-intel libgl mesa plasma kde-applications
echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

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

#tcpio
mkinitcpio -P

#criando usuario
useradd -m -g users -G wheel,storage,power souzo

#iwd
echo "Configurando ambiente wifi"
pacman --noconfirm -S iwd
mkdir /etc/iwd
echo -e "[General]\r\nEnableNetworkConfiguration=true\r\n" > /etc/iwd/main.conf
#echo -e "[Settings]\r\nAutoConnect=true" >> /var/lib/iwd/spaceship.psk

systemctl enable NetworkManager
systemctl enable sddm
