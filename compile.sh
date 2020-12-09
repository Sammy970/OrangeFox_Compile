#!/bin/bash
sudo apt-get update
sudo apt-get upgrade -y
echo "Credits gghhkm https://github.com/gghhkm"
Set=$1
Sync=$2
DeviceTrees=$3
Build=$4

#Setup
if [ "$Set" -eq 1 ]; then
	cd ~ || exit
	sudo apt install git aria2 -y
	git clone https://gitlab.com/OrangeFox/misc/scripts
	cd scripts || exit
	sudo bash setup/android_build_env.sh
	sudo bash setup/install_android_sdk.sh
elif [ "$Set" -eq 0 ]; then
	echo "Setup Skipped"
fi


#Sync
if [ "$Sync" -eq 1 ]; then
	mkdir OrangeFox || exit
	cd OrangeFox || exit
	repo init --depth=1 -u https://gitlab.com/OrangeFox/Manifest.git -b fox_9.0
	repo sync -j8 --force-sync
elif [ "$Sync" -eq 0 ]; then
	echo "Sync Skipped"
fi

#DeviceTree, Kernel, Vendor Cloning
if [ "$DeviceTrees" -eq 0 ]; then
	echo "Trees skipped"

elif [ "$DeviceTrees" = 'jasmin_sprout' ]; then
	cd
        cd scripts/OrangeFox
	git clone https://github.com/gghhkm/Xiaomi_Jasmine_Sprout_OFRP_Tree.git -b test device/xiaomi/jasmine_sprout
        cd
  
#Build
if [ "$Build" -eq 0 ]; then
	echo "Build skipped"
elif [ "$Build" = 'jasmine_sprout' ]; then
	cd 
	cd scripts/OrangeFox
	source build/envsetup.sh
	lunch omni_jasmine_sprout-eng && mka recoveryimage | tee XMIA2Log.txt
fi
echo "done"
