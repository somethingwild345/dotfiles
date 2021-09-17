#!/bin/bash

if [ $(id -u) = 0 ]; then
	echo "This script changes your users gsettings and should thus not be run as root!"
	echo "You may need to enter your password multiple times!"
	exit 1
fi

cat <<EOF

###############################
#        Initial Setup        #
###############################

EOF

printf
"fastestmirror=True\nkeepcache=True\nmax_parallel_downloads=10\ndeltarpm=true" | sudo tee -a /etc/dnf/dnf.conf

cat <<EOF

###############################
#      Install Repositories   #
###############################

EOF

# RpmFusion Free Repo
sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm

# RpmFusion NonFree Repo
sudo dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# Disable the Modular Repos
sudo sed -i 's/enabled=1/enabled=0/g' /etc/yum.repos.d/fedora-updates-modular.repo
sudo sed -i 's/enabled=1/enabled=0/g' /etc/yum.repos.d/fedora-modular.repo

# Rpmfusion makes this obsolete
sudo sed -i 's/enabled=1/enabled=0/g' /etc/yum.repos.d/fedora-cisco-openh264.repo

# Disable Machine Counting for all repos
sudo sed -i 's/countme=1/countme=0/g' /etc/yum.repos.d/*

# VSCodium Repository
sudo rpm --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=gitlab.com_paulcarroty_vscodium_repo\nbaseurl=https://paulcarroty.gitlab.io/vscodium-deb-rpm-repo/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg" | sudo tee -a /etc/yum.repos.d/vscodium.repo

# Brave Browser Repository
sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc

# Flathub Repository
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

cat <<EOF

###############################
#      Upgrade Packages       #
###############################

EOF

# Upgrade system packages
sudo dnf upgrade -y
sudo dnf distro-sync -y

cat <<EOF

###############################
#      Install Codecs         #
###############################

EOF

# Install RPMFusion codecs
sudo dnf groupupdate core -y
sudo dnf groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin -y
sudo dnf groupupdate sound-and-video -y

cat <<EOF

###############################
#    Install Packages         #
###############################

EOF

# Install needed packages
sudo dnf install -y \
	akmod-nvidia \
	bat \
	brave-browser \
	celluloid \
	clang \
	clang-tools-extra \
	cmake \
	codium \
	dconf-editor \
	ffmpeg \
	ffmpeg-libs \
	fira-code-fonts \
	foliate \
	fuse-exfat \
	fuse-sshfs \
	glances \
	gnome-shell-extension-appindicator \
	gnome-shell-extension-dash-to-dock \
	gnome-shell-extension-pomodoro \
	gnome-tweaks \
	golang \
	'google-roboto-*' \
	gvfs-nfs \
	htop \
	iotop \
	kitty \
	libreoffice-langpack-ar \
	libva-intel-driver \
	libva-intel-hybrid-driver \
	libva-utils \
	lm_sensors \
	meld \
	'mozilla-fira-*' \
	mosh \
	mpv \
	neofetch \
	neovim \
	nethogs \
	ninja-build \
	nnn \
	nodejs \
	p7zip \
	p7zip-plugins \
	protonvpn-cli \
	podman-docker \
	powertop \
	python3-devel \
	python3-neovim \
	ripgrep \
	rpmconf \
	starship \
	telegram-desktop \
	transmission \
	unar \
	youtube-dl \
	zsh \
	zoxidie

# Install Flatpak packages
flatpak update
flatpak install flathub \
	com.getpostman.Postman \
	-y

cat <<EOF

###############################
#            General          #
###############################

EOF

# The user needs to reboot to apply all changes.
cat <<EOF

###############################
#        Please Reboot        #
###############################

EOF
exit 0
