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
echo -e "127.0.0.1\tlocalhost\r\n::1\t\tlocalhost\r\n127.0.1.1\tsouzo-arch.localdomain\tsouzo-arch" > /etc/hosts
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
useradd -m -g users -G wheel souzo

#iwd
echo "Configurando ambiente wifi"
pacman --noconfirm -S iwd
mkdir /etc/iwd
echo -e "[General]\r\nEnableNetworkConfiguration=true\r\n" > /etc/iwd/main.conf
#echo -e "[Settings]\r\nAutoConnect=true" >> /var/lib/iwd/spaceship.psk
systemctl enable iwd

#grub
read -p "Digite o local de instalação do grub ex:/dev/XXX -> " igruba
pacman -S --noconfirm grub;
grub-install --force $igruba
echo "GRUB_DISABLE_OS_PROBER=false" >> /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

#tema do grub
mkdir /tmp/archthemetmp
cd /tmp/archthemetmp
git clone https://github.com/kalanaj2005/hex-grub-theme-arch
cd hex-grub-theme-arch
cat install.sh | sh
rm -rf /tmp/archthemetmp
cd

#ambiente gráfico
#dwm xf86-video-intel mesa libgl
pacman -S --noconfirm xorg gnu-free-fonts nitrogen lxappearance zathura nnn firefox slock arc-gtk-theme arc-icon-theme calcurse mpv alsa-utils pulseaudio flameshot
#change 1366×768 for 1920x1080 if your screen accept this resolution

mkdir /usr/share/xsessions
echo -e "[Desktop Entry]\r\nEncoding=UTF-8\r\nName=Dwm\r\nComment=Dynamic Window Manager\r\nExec=dwm\r\nIcon=dwm\r\nType=XSession" > /usr/share/xsessions/dwm.desktop

#config user
echo -e "setxkbmap br &\r\nnitrogen --restore &\r\nxrandr --output eDP1 --mode 1366×768 &\r\n" > /home/souzo/xprofile
curl https://vda789.github.io/souzo-arch-rice2.sh >> /home/souzo/userconf.sh
curl https://blackarch.org/strap.sh >> /root/blackarch.sh

locale-gen
pacman -S ttf-font-awesome picom

echo "Depois da instalacao execute o script em /root/arch.sh e como usuario comum em /home/souzo/userconf.sh :)"
echo "Caso voce tenha mais de um monitor dê uma olhada em xrand, para adicionar outro, edite o arquivo .xprofile"
echo "Digite passwd USUARIO e depois passwd root para poder setar as senhas de usuario e root"
