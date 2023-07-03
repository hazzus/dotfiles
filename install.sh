#!/bin/sh

# installing git & vim
sudo dnf install -y git vim

# generating ssh key in .ssh without keyphrase
ssh-keygen -t ed25519 -C "dfa.sro591@gmail.com" -f ~/.ssh/id_auto -q -N ""
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_auto
cat ~/.ssh/id_auto.pub
read -n 1 -p "^Insert this to github ssh keys and press Enter" _


echo "Downloading self repo"
git clone git@github.com:hazzus/dotfiles.git
cd dotfiles

echo "Installing zsh & ohmyzsh"
sudo dnf install -y zsh wget neofetch
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

cp zsh/.zshrc ~


echo "Installing IBM plex mono fonts"
sudo mkdir -p /usr/local/share/fonts/IBMPlexMono
wget "https://github.com/IBM/type/archive/master.zip"
unzip master.zip "plex-master/IBM-Plex-Mono/fonts/complete/ttf/*"
sudo cp plex-master/IBM-Plex-Mono/fonts/complete/ttf/* /usr/local/share/fonts/IBMPlexMono
sudo chown -R root: /usr/local/share/fonts/IBMPlexMono
sudo chown 644 /usr/local/share/fonts/IBMPlexMono
sudo restorecon -vFr /usr/local/share/fonts/IBMPlexMono
sudo fc-cache -v
rm master.zio
rm -rf plex-master


echo "Changing foot config"
mkdir -p ~/.config/foot
cp foot/foot.ini ~/.config/foot


echo "Installing awesome vimrc"
git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh

cp vim/my_configs.vim ~/vim_runtime


echo "Installing sddm minimal theme"
git clone git@github.com:stepanzubkov/where-is-my-sddm-theme.git theme-git
sudo cp -r theme/where_is_my_sddm_theme /usr/share/sddm/themes/wimst
rm -rf theme-git
wget -O flowers.png "https://images.pexels.com/photos/1083822/pexels-photo-1083822.jpeg?cs=srgb&dl=pexels-lisa-fotios-1083822.jpg&fm=jpg&w=6000&h=4000&_gl=1*yycnmr*_ga*OTA1OTg2NDM1LjE2ODgyOTcwNTI.*_ga_8JE65Q40S6*MTY4ODI5NzA1MS4xLjEuMTY4ODI5NzQ2Ny4wLjAuMA.."
sudo mv flowers.png /usr/share/sddm/themes/wimst
sudo cp sddm/theme.conf /usr/share/sddm/themes/wimst
sudo cp sddm/sddm.conf /etc

