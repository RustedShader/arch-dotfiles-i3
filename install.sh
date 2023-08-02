#! /bin/sh

printf "You will be promted to enter password at some moments so keep a watch !\n" 
printf "If You have NVIDIA DRIVER INSTALLED PLS UNINSTALL IT !\n"
printf "Starting in 5 seconds\n\n\n"
sleep 5

### CHECK UPDATE###
printf "Checking for Updates ...\n"
sudo pacman --noconfirm -Suy && sleep 1

### SET PARALLEL DOWNLOADS ###
printf "Setting Parallel Downloads ...\n"
parallel=$(cat /etc/pacman.conf | grep -o "#ParallelDownloads = [0-9]*")
if [[ -z "$parallel" ]];
then
printf "Already Set\n"
else
printf "Setting up Parallel Downloads to 5 ... \n"
sudo bash -c 'sed -i "s/#ParallelDownloads = 5/ParallelDownloads = 5/g" /etc/pacman.conf'
fi

### INSTALL Compiling Stuff ###
printf "Installing Compiling Tools...\n"
sudo pacman --noconfirm -S make fakeroot binutils base-devel git

## INSTALL YAY ###
ISYAY=/sbin/yay
if [[ -f "$ISYAY" ]]; then 
    printf "yay was located, moving on.\n"
else 
printf "Installing yay...\n"
git clone https://aur.archlinux.org/yay.git && cd ./yay && makepkg -si --noconfirm && cd $OLDPWD && rm -rf ./yay
fi

## Getting Best Mirrors ##
printf "Getting Best Mirrors ...\n"
yay --sudoloop --noconfirm -S rate-mirrors-bin && rate-mirrors arch | sudo tee /etc/pacman.d/mirrorlist

## NVIDIA Users ##
printf "Are You NVIDIA User ? \n Press y for yes or n for No \n"
read nvidia
if [[ "$nvidia" == y ]];
then
yay -S nvidia nvidia-utils nvidia-settings
else
printf "Nothing to Do Here \n"
fi

## ASUS User ##
printf "Are You Asus User ? \n Press y for yes or n for No \n"
read asus

if [[ "$asus" == y ]];
then
yay -S rog-control-center
### ENABLE ASUSCTL ###
printf "Enabling Asusctl"
sudo systemctl enable --now power-profiles-daemon.service
sudo systemctl enable --now supergfxd
else
printf "Nothing to Do Here \n"
fi

### INSTALL MAIN PACKAGES ###
printf "Installling all the Main packages...\n"
yay --sudoloop --noconfirm -S $(echo $(cat ./main_packages.txt)) && sleep 1

printf "Do you want other packages...\n Press y for yes or n for No \n"
read package
if [[ "$package" == y]];
then
### INSTALL MY PACKAGES ###
pritnf "Installling all the other packages...\n"
yay --sudoloop --noconfirm -S $(echo $(cat ./packages.txt)) && sleep 1
else
printf "\n"
fi

### COPY CONFIG FILES ###
printf "Copying config files to config folder...\n"
cp -r ./config/* $HOME/.config  && sleep 1

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
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended && cp $HOME/.oh-my-zsh/templates/zshrc.zsh-template $HOME/.zshrc
 
### CHANGING OHMYZSH THEME ###
printf "Changing Default zsh theme...\n"
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="gianu"/g' $HOME/.zshrc && chsh -s $(which zsh)

### ENABLING WIFI ###
printf "Setting Up Network Manger...\n"
sudo systemctl enable NetworkManager.service

###  ENABLE SDDM ###
printf "Enabling SDDM...\n"
sudo systemctl enable sddm.service && sleep 1 && printf "Done Thanks You can reboot now !"
