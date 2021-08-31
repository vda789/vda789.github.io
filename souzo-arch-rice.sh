echo "Iniciando a pós instalacao do arch linux..."
if [ $EUID -ne 0 ]
    then echo "Error... Run as root"
    exit
fi

#installation core
echo "Instalando e configurando recursos"
pacman --noconfirm -Sy sudo vim nnn curl git wget base-devel
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

#criando usuario
useradd -m -g users -G wheel,power souzo

#iwd
echo "Configurando ambiente wifi"
pacman --noconfirm -S iwd
mkdir /etc/iwd
echo -e "[General]\nEnableNetworkConfiguration=true\n" > /etc/iwd/main.conf
if []
#echo -e "[Settings]\r\nAutoConnect=true" >> /var/lib/iwd/spaceship.psk
systemctl enable iwd

#grub
#read -p "Digite o local de instalação do grub ex:/dev/XXX -> " igruba
#grub-install --force $igruba
#grub-install --target=x86_64-efi --efi-directory=/boot/EFI --bootloader-id=GRUB
echo "GRUB_DISABLE_OS_PROBER=false" >> /etc/default/grub
#grub-mkconfig -o /boot/grub/grub.cfg

#tema do grub
#mkdir /tmp/archthemetmp
#cd /tmp/archthemetmp
#git clone https://github.com/kalanaj2005/hex-grub-theme-arch
#cd hex-grub-theme-arch
#cat install.sh | sh
#rm -rf /tmp/archthemetmp
#cd
pacman -S --noconfirm grub dmenu xorg noto-fonts ttf-liberation ttf-desjavu papirus-icon-theme arc-icon-theme ttf-font-awesome picom i3-gaps alsa-utils pulseaudio flameshot firefox lxappearance gnu-free-fonts mesa libgl fx86-video-intel nitrogen lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings efibootmgr

echo "GRUB_DISABLE_OS_PROBER=false" >> /etc/default/grub

locale-gen
mkinitcpio -P
systemctl enable lightdm
#grub-install --target=x86_64-efi --efi-directory=/boot/EFI --bootloader-id=GRUB
