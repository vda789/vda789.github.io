cd ~

#baixando
mkdir Programs
cd Programs
git clone https://aur.archlinux.org/yay.git
git clone git://git.suckless.org/dmenu
git clone git://git.suckless.org/dwm
git clone git://git.suckless.org/st
git clone git://git.suckless.org/slock

#instalando
echo "Instalando pacotes..."
cd yay; makepkg -si; cd ..;
cd dmenu; make; sudo make install; cd ..;
cd dwm; make; sudo make install; cd ..;
cd slock; make; sudo make install; cd ..;
cd st; make; sudo make install; cd ..;

yay -S ly
yay -S brave-bin

#telegram
sudo pacman -S --noconfirm telegram-desktop

#window manager
sudo systemctl enable ly

#vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
curl https://github.com/vda789/vda789.github.io/blob/main/.vimrc > ~/.vimrc
