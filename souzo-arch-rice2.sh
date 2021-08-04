cd ~
#baixando
echo "Baixando pacotes..."
mkdir Programs
cd Programs
git clone https://aur.archlinux.org/yay.git
git clone git://git.suckless.org/dmenu
git clone git://git.suckless.org/dwm
git clone git://git.suckless.org/dwmstatus
git clone git://git.suckless.org/st
git clone git://git.suckless.org/slock
git clone https://aur.archlinux.com/ly
#instalando
echo "Instalando pacotes..."
cd yay; makepkg -si; cd ..;
cd dmenu; make; sudo make install; cd ..;
cd dwm; make; sudo make install; cd ..;
cd dwmstatus; make;sudo make install; cd ..;
cd slock; make; sudo make install; cd ..;
cd st; make; sudo make install; cd ..;
cd ly; makepkg -si; cd ..;
#brave browser
yay -S brave-bin
#telegram
sudo pacman -S --noconfirm telegram-desktop 
#vim dots
echo "Instalando VimDots"
mkdir /tmp/vimdots
cd /tmp/vimdots
git clone https://github.com/Mangeshrex/vim-dots
rm -rf ~/.vim
cd vim-dots && mkdir ~/.vim
cp -r autoload pack session colors ~/.vim
cp vimrc ~/.vimrc
#zsh
curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sh
