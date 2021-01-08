#!/bin/bash
echo " Credits : gghhkm [ https://github.com/gghhkm ] , Ryukendo9
echo " Hello, Thankyou for using this script "
echo " You can easily build orange fox with this script for your Xiaomi and Oneplus Device "
echo " First lets setup the environment "
echo " Press Enter to Start "
read Ans1

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

echo " Now tell me your device codename "
read code 

echo "_________________________________________________________________________________________"

echo " So which device you have ? "
echo " Answer 1 = xiaomi and 2 = oneplus "
read Ans2

if [ $Ans2= 1 ]
then
echo " Give me your Xiaomi Device trees. "
read Xtree
cd
cd scripts/Orangefox/
git clone $Xtree device/xiaomi/$code

elif [ $Ans2 = 2 ]
then
echo " Give me your Oneplus Device trees. "
read Otree
cd
cd scripts/Orangefox/
git clone $Otree device/oneplus/$code
fi

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

echo " Now lets do some export things for your device "

echo " Have you already created a config file with the export settings for your device ? "
echo " Options "
echo " 1. You already have a config file created by this script "
echo " 2. You dont have a config file and now we will create it for you and will use it later when rebuilding Ofox "

echo "_________________________________________________________________________________________"

read Ans3

if [ $Ans3 = 1 ]
then
cd
ls scripts/Orangefox/configs/
echo ""
echo " Now write the name of config that you want to use "
read con
echo " Great then lets export your device settings "
echo " Press enter when ready "
read enter
cd
source ~/scripts/Orangefox/configs/$con
echo " Done exporting your Device Specific settings "

echo "_________________________________________________________________________________________"

elif [ $Ans3 = 2 ]
then
echo " Lets create a config for you to use for you device export settings "
cd
mkdir scripts/Orangefox/configs/
touch scripts/Orangefox/configs/$code

echo " Config file created "
echo ""
echo " Now i will open your config file and you just type the device specific export settings in it and save it "
echo " Press enter when ready "
read enter
cd
nano scripts/Orangefox/configs/$code
cd
echo " Now your config file is saved "
echo ""
echo " Great then lets export your device settings "
echo " Press enter when ready "
read enter
cd
source ~/scripts/Orangefox/configs/$code
echo " Done exporting your Device Specific settings "
fi

echo "_________________________________________________________________________________________"

export OF_MAINTAINER="$main"

# Universal variables for building
export ALLOW_MISSING_DEPENDENCIES=true
export TW_DEFAULT_LANGUAGE="en"
# To use ccache to speed up building
export USE_CCACHE="1"
# Enforced by R11 rules
export FOX_R11="1"
export FOX_ADVANCED_SECURITY="1"
export FOX_RESET_SETTINGS="1"
export FOX_VERSION="$ver"

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
