cd ~
#baixando
echo "Baixando pacotes..."
mkdir Programs
cd Programs
git clone git://git.suckless.org/dmenu
git clone git://git.suckless.org/dwm
git clone git://git.suckless.org/dwmstatus
git clone git://git.suckless.org/st
git clone git://git.suckless.org/slock
git clone https://aur.archlinux.com/ly
#instalando
echo "Instalando pacotes..."
cd dmenu; make; sudo make install; cd ..;
cd dwm; make; sudo make install; cd ..;
cd dwmstatus; make;sudo make install; cd ..;
cd slock; make; sudo make install; cd ..;
cd st; make; sudo make install; cd ..;
cd ly; makepkg -si; cd ..;
