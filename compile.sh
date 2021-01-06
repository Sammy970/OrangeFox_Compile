echo " Hello, Thankyou for using this script "
echo " You can easily build orange fox with this script for any device you like"
echo " First lets setup the environment "
read Ans
_________________________________________________________________________________________

cd
git clone https://github.com/akhilnarang/scripts
bash scripts/setup/android_build_env.sh
_________________________________________________________________________________________
echo " Now lets sync the Latest Orange Fox Sources [ Latest 9.0 ] "
read ans 
cd
cd scripts
mkdir Orangefox
cd Orangefox
repo init --depth=1 -q -u https://gitlab.com/OrangeFox/Manifest.git -b fox_9.0
repo sync -c -f -q --force-sync --no-clone-bundle --no-tags -j$(nproc --all)
_________________________________________________________________________________________
clear
_________________________________________________________________________________________
echo " Now give me what you want to export "
read 
