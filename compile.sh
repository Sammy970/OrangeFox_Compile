#!/bin/bash
echo " Hello, Thankyou for using this script "
echo " You can easily build orange fox with this script for your Xiaomi Device "
echo " First lets setup the environment "
echo " Press Enter to Start "
read Ans

echo "_________________________________________________________________________________________"

cd
git clone https://github.com/akhilnarang/scripts
bash scripts/setup/android_build_env.sh

echo "_________________________________________________________________________________________"

echo " Now lets sync the Latest Orange Fox Sources [ Latest 9.0 ] "
read ans 
cd
cd scripts
mkdir Orangefox
cd Orangefox
repo init --depth=1 -q -u https://gitlab.com/OrangeFox/Manifest.git -b fox_9.0
repo sync -c -f -q --force-sync --no-clone-bundle --no-tags -j$(nproc --all)

echo "_________________________________________________________________________________________"

clear

echo "_________________________________________________________________________________________"

echo " Now tell me your Xiaomi device codename "
read code 

echo " Now Give me your trees github link "
read trees

cd
cd scripts/Orangefox
git clone $trees device/xiaomi/$code

echo "_________________________________________________________________________________________"

echo " Now lets start building the environment "
cd
cd scripts/Orangefox/
source build/envsetup.sh

echo "_________________________________________________________________________________________"

echo " Now tell me the name of the maintainer "
read main

echo " Now tell me the Fox Version [ eg:- Official, Unofficial etc ] "
read ver

echo "_________________________________________________________________________________________"

echo " Now lets export some stuff related to Mi A2 [Jasmine_sprout] "
export OF_MAINTAINER="$main"
export OF_AB_DEVICE=1
export ALLOW_MISSING_DEPENDENCIES=true
export FOX_USE_TWRP_RECOVERY_IMAGE_BUILDER=1
export FOX_R11=1
export FOX_ADVANCED_SECURITY=1
export FOX_REPLACE_BUSYBOX_PS=1
export FOX_REPLACE_TOOLBOX_GETPROP=1
export FOX_USE_TAR_BINARY=1
export FOX_USE_NANO_EDITOR=1
export FOX_VERSION="$ver"
export OF_USE_TWRP_SAR_DETECT=1
export OF_USE_MAGISKBOOT=1
export OF_USE_MAGISKBOOT_FOR_ALL_PATCHES=1
export OF_NO_SAMSUNG_SPECIAL=1
export OF_DISABLE_MIUI_SPECIFIC_FEATURES=1
export OF_OTA_BACKUP_STOCK_BOOT_IMAGE=1
export OF_SKIP_MULTIUSER_FOLDERS_BACKUP=1
export OF_PATCH_AVB20=1
export OF_SUPPORT_PRE_FLASH_SCRIPT=1
export OF_DONT_KEEP_LOG_HISTORY=1
export OF_HIDE_NOTCH=1
export OF_STATUS_INDENT_LEFT=48
export OF_STATUS_INDENT_RIGHT=48
export OF_SCREEN_H=2160
export OF_FBE_METADATA_MOUNT_IGNORE=1
export OF_CHECK_OVERWRITE_ATTEMPTS=1

clear
echo "_________________________________________________________________________________________"

echo " Lets Lunch it all together 😉😋 "
lunch omni_$code

echo "_________________________________________________________________________________________"

echo " Lets Start Building "
mka recoveryimage

echo "_________________________________________________________________________________________"

echo " Thankyou for using my Script " 
echo " Do follow my Github Account for more scripts : https://github.com/Sammy970 "
echo " Would love to help you "
