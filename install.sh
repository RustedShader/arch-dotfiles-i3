#! /bin/sh

printf "You will be promted to enter password at some moments so keep a watch !\n" 
printf "If You have NVIDIA DRIVER INSTALLED PLS UNINSTALL IT !\n"
printf "Starting in 5 seconds\n\n\n"
sleep 5

### CHECK UPDATE###
printf "Checking for Updates ...\n"
sudo pacman --noconfirm -Suy
sleep 1

### SET PARALLEL DOWNLOADS ###
parallel=$(cat /etc/pacman.conf | grep -o "#ParallelDownloads = [0-9]*")
if [ "$parallel" == "" ];
then
printf "Already Set\n"
else
printf "Setting up Parallel Downloads to 5 ... \n"
sudo bash -c 'sed -i "s/#ParallelDownloads = 5/ParallelDownloads = 5/g" /etc/pacman.conf'
sleep 1
fi

### INSTALL Make ###
printf "Installing make...\n"
sudo pacman --noconfirm -S make

### SETTING MAKEFLAGS TO USE ALL CORES ###
printf "Setting up MAKEFLAGS...\n"
makeflags=$(cat /etc/makepkg.conf | grep -o '#MAKEFLAGS="-j[0-9]*"')
if [ "$makeflags" == "" ];
then
printf "Already Set\n"
else
cores=$(nproc)
sudo sed -i 's/#MAKEFLAGS="-j2"/MAKEFLAGS="-j8"/g' /etc/makepkg.conf
fi
### INSTALL YAY ###
ISYAY=/sbin/yay
if [ -f "$ISYAY" ]; then 
    echo -e "yay was located, moving on."
else 
printf "Installing yay...\n"
git clone https://aur.archlinux.org/yay.git && cd ./yay && makepkg -si --noconfirm && cd $OLDPWD && rm -rf ./yay
sleep 1
fi

### INSTALL PACKAGES ###
pritnf "Installling all the Main packages...\n"
yay --sudoloop --noconfirm -S $(echo $(cat ./main_packages.txt))
sleep 1

### GRUB ENTRY ZEN KERNEL ###
printf "Making grub config for zen kernel...\n"
sudo grub-mkconfig -o /boot/grub/grub.cfg

### COPY CONFIG FILES ###
printf "Copying config files to config folder...\n"
cp -r ./config/* $HOME/.config
sleep 1

#### MAKING EXECUTABLE ###
chmod +x $HOME/.config/scripts/*
chmod +x $HOME/.config/polybar/launch.sh
chmod +x $HOME/.config/picom/launch.sh
chmod +x $HOME/.config/dunst/launch.sh


### MAKE DEFAULT DIRECTORIES ###
printf "Making Default Directories...\n"
mkdir $HOME/Videos
mkdir $HOME/Documents
mkdir $HOME/Downloads
mkdir $HOME/wallpaper
mkdir $HOME/Pictures
mkdir $HOME/Music
sleep 1 

### Setting up Wallpaper ###
cp ./wallpaper/* $HOME/wallpaper/ 

### INSTALLING OH MY ZSH ###
printf "Installing OHmyzsh...\n"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
 
cp $HOME/.oh-my-zsh/templates/zshrc.zsh-template $HOME/.zshrc
 
### CHANGING OHMYZSH THEME ###
printf "Changing Default zsh theme...\n"
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="agnoster"/g' $HOME/.zshrc
chsh -s $(which zsh)

### ENABLING WIFI ###
printf "Setting Up Network Manger...\n"
sudo systemctl enable NetworkManager.service

### ENABLE ASUSCTL ###
printf "Enabling Asusctl"
sudo systemctl enable --now power-profiles-daemon.service
sudo systemctl enable --now supergfxd

### LUNAR VIM ###
printf "Do you want to Install Lunar Vim ? " 
read responce

if ["$responce" == y ];then
	bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)
else
	sleep 1
fi

###  ENABLE LIGHTDM ###
printf "Enabling Lightdm...\n"

cp ./.face $HOME/
sudo systemctl enable lightdm.service
sleep 1

printf "Done Thanks "
