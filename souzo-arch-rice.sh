echo "Iniciando a pós instalacao do arch linux..."
if[ $EUID -ne 0 ]
    then echo "Error... Run as root"
    exit
fi
#installation core
echo "Instalando e configurando recursos"
pacman --noconfirm -Sy sudo vim nnn curl zsh git wget base-devel
echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
#host
echo "Configurando Host"
echo -e "127.0.0.1\tlocalhost\r\n::1\t\tlocalhost\r\n127.0.1.1\tsouzo-arch.localdomain\tsouzo-arch" > /etc/hosts
echo "souzo-arch" > /etc/hostname
#localtime
echo "Configurando relogio"
timedatectl set-ntp true
ln -sf /usr/share/zoneinfo/America/Fortaleza /etc/localtime
hwclock --systohc
#locale
echo "Configurando o locale-gen"
echo "pt_BR.UTF-8 UTF-8" > /etc/locale.conf
echo "LANG=pt_BR.UTF-8" > /etc/locale.gen
locale-gen
echo "KEYMAP=br-abnt2" > /etc/vconsole.conf
#tcpio
mkinitcpio -P
#root password
echo "Digite a nova senha para o root"
passwd
#baixando e executando arquivo de configuração do black arch para ferramentas de pentest
curl https://blackarch.org/strap.sh | sh
#criando usuario
read -s "Digite o nome do novo usuario: " suser
useradd -m -g users -G wheel $suser -s /usr/bin/zsh
echo "Crie uma senha para o usuário"
passwd $suser
#iwd
read -p "Deseja configurar ambiente wifi? y|n: " iwifi
case $iwifi in
    n|N) ;;
    y|Y|s|S|*)
         echo "Configurando ambiente wifi"
         pacman --noconfirm -S iwd
         echo -e "[General]\r\nEnableNetworkConfiguration=true\r\n" > /etc/iwd/main.conf
         #echo -e "[Settings]\r\nAutoConnect=true" >> /var/lib/iwd/spaceship.psk
         systemctl enable iwd ;;
esac
#grub
read -p "Deseja instalar o grub? y|n -> " igrub
case $igrub in
    n|N) ;;
    y|Y|s|S|*)
        read -p "Digite o local de instalação do grub ex:/dev/sdX -> " igruba
        pacman -S grub;
        grub-install --force $igruba
        echo "GRUB_DISABLE_OS_PROBER=false" >> /etc/default/grub
        grub-mkconfig -o /boot/grub/grub.cfg;;
esac
#grub theme
read -p "Deseja alterar o tema do grub? y|n -> " tgrub
case $tgrub in
    n|N) ;;
    y|Y|s|S|*)
        echo "Alterando tema do grub"
        mkdir /tmp/archthemetmp
        cd /tmp/archthemetmp
        git clone https://github.com/kalanaj2005/hex-grub-theme-arch
        cd hex-grub-theme-arch
        cat install.sh | sh
        rm -rf /tmp/archthemetmp
        cd;;
esac
read -p "Deseja configurar a Internet? y|n -> " sinet
case $sinet in
    n|N) ;;
    y|Y|s|S|*)
        echo "Configurando internet"
        pacman -S --noconfirm networkmanager dhclient
        systemctl enable NetworkManager;;
esac
#ambiente gráfico
#dwm xf86-video-intel mesa libgl
read -p "Deseja instalar interface gráfica? y|n -> " sinet
case $sinet in
    n|N) ;;
    y|Y|s|S|*)
        pacman -S --noconfirm xorg gnu-free-fonts nitrogen lxappearance zathura nnn firefox slock arc-gtk-theme arc-icon-theme 
        #change 1366×768 for 1920x1080 if your screen accept this resolution
        sudo -u $suser echo -e "setxkbmap br\r\nnitrogen --restore\r\nxrandr --output Virtual-1 --mode 1366×768" > ~/.xprofile
        mkdir /usr/share/xsessions
        echo -e "[Desktop Entry]\r\nEncoding=UTF-8\r\nName=Dwm\r\nComment=Dynamic Window Manager\r\nExec=dwm\r\nIcon=dwm\r\nType=XSession" > /usr/share/xsessions/dwm.desktop
        sudo -u $suser bash -c "curl https://vda789.github.io/souzo-arch-rice2.sh | sh"
        systemctl enable ly
esac
