#! /bin/sh

printf "You will be promted to enter password at some moments so keep a watch !\n" 

sleep 2

### CHECK UPDATE###
printf "Checking for Updates ...\n"
sudo pacman --noconfirm -Suy
sleep 1

### SET PARALLEL DOWNLOADS ###
printf "Setting up Parallel Downloads to 5 ... \n"
sudo bash -c 'sed -i "s/#ParallelDownloads = 5/ParallelDownloads = 5/g" /etc/pacman.conf'
sleep 1

### INSTALL YAY ###
printf "Installing git...\n"
sudo pacman --noconfirm -S git
printf "Installing yay...\n"
git clone https://aur.archlinux.org/yay.git && cd ./yay && makepkg -si --noconfirm && cd $OLDPWD && rm -rf ./yay
sleep 1

### INSTALL PACKAGES ###
pritnf "Installling all the packages...\n"
yay --sudoloop --answerclean N --answerdiff N --noconfirm  -S $(echo $(cat ./packages.txt))
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
mkdir $HOME/.face
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

###  ENABLE LIGHTDM ###
printf "Enabling Lightdm...\n"

cp ./.face $HOME/.face
sudo systemctl enable lightdm.service
sleep 1

printf "Done Thanks "
