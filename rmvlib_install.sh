#!/bin/bash
 
RED='\033[0;31m'
NC='\033[0m' # No Color

sudo apt install -y git make build-essential

#add m68k-mint-atari cross compiler from ppa for Ubuntu installs
echo "\n${RED}Adding Repository For Cross Compiler Tools for Ubuntu Installation${NC}\n"
sudo add-apt-repository -y ppa:vriviere/ppa
sudo apt-get update -y
echo  "\n${RED}Installing Cross Compiler Tools & GIT${NC}\n"
sudo apt-get install -y gcc-m68k-atari-mint
sudo apt-get install -y cross-mint-essential

#setup our folders for our tools and build environment path
echo  "\n${RED}Adding Tools Directory${NC}\n"

mkdir -v $HOME/Jaguar
mkdir -v $HOME/Jaguar/example_programs
mkdir -v $HOME/Jaguar/lib
mkdir -v $HOME/Jaguar/lib/lib
mkdir -v $HOME/Jaguar/lib/include
mkdir -v $HOME/Jaguar/src

echo  "\n${RED}Copy Temporary Assets Directory${NC}\n"
cp -vr ./assets $HOME/Jaguar
cd $HOME/Jaguar/

echo  "\n${RED}Setting Environment Variable JAGPATH${NC}\n"
export JAGPATH=/home/$USER/Jaguar #export for the session the script is running so libraries install correctly
echo "export JAGPATH=/home/$USER/Jaguar" | sudo tee -a /etc/environment 

echo  "\n${RED}Downloading RMAC/RLN Source From GIT Repositories${NC}\n"
cd $HOME/Jaguar/src
git clone http://shamusworld.gotdns.org/git/rmac
git clone http://shamusworld.gotdns.org/git/rln
echo  "\n${RED}Downloading jlibc/rmvlib Libraries From GIT Repositories${NC}\n"
git clone https://github.com/sbriais/jlibc.git
git clone https://github.com/sbriais/rmvlib.git

echo "${RED}\nRun any patches in temp assets direction on sources.\n${NC}"

#Patch rmac
cd rmac
patch -p1 -i $HOME/Jaguar/assets/patch_files/9-2-2020_rmac.patch
cd $HOME/Jaguar/src

echo "${RED}\n\nBegin Building sources\n\n${NC}"

#modify and build rmac 2.0.0
echo  "\n${RED}Building RMAC${NC}\n"
cd rmac
make
cd $HOME/Jaguar/src

#patching and building rln
echo  "\n${RED}Building RLN${NC}\n"
cd rln
make
cd $HOME/Jaguar/src

#modify and build jlibc
echo  "\n${RED}Building JLIBC${NC}\n"
cd jlibc
sed -i '/MADMAC=/c\MADMAC=$(JAGPATH)/src/rmac/rmac' Makefile.config #change makefile.config to point to our new rmac
sed -i '/OSUBDIRS=/c\OSUBDIRS=ctype' Makefile #don't build documentation
make
make install
cd $HOME/Jaguar/src

#modify and build rmvlib
echo  "\n${RED}Building RMVLIB${NC}\n"
cd rmvlib
#change makefiles
sed -i '/MADMAC=/c\MADMAC=$(JAGPATH)/src/rmac/rmac' Makefile.config #change makefile.config to point to our new rmac
sed -i '/OSUBDIRS=/c\OSUBDIRS=' Makefile #don't build documentation
make
make install
cd $HOME/Jaguar/src 

#copy libgcc.a from m68k-mint-atari tools
echo  "\n${RED}copy libgcc.a from m68k-mint-atari tools into lib folder${NC}\n"
cd $HOME/Jaguar/lib/lib
cp -v /usr/lib/gcc/m68k-atari-mint/4.6.4/libgcc.a ./
cd $HOME/Jaguar

echo  "\n${RED}copy example program${NC}\n"
mv -v ./assets/generic_example ./example_programs/
rm -rv ./assets

echo  "\n${RED}Finished installing Removers Library${NC}\n"
echo  "\n\n${RED}Logout/Restart Computer So New Environment Variable Can Take Effect${NC}\n\n"

