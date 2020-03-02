# Introduction
These scripts were put together to make building and installing a specific Atari Jaguar development environment more conveinient. They were also created as way of retracing my steps in the future in case I need to build/install a specific tool or application included in these scripts.

There are no guarantees provided when you use this script.  These scripts will probably break and cease to work as packages update or disappear from the Ubuntu repositories over time.  Or build processes and source files for tools/applications change.

The only updates you can expect from me for these scripts are if and when I feel that I need to update them, but feel free to leave an issue in the tracker. I will do my best to help. Or, feel free to alter the script for your own needs.

# RMAC/RLN/JLIBC/RMVLIB Installer Script
(rmvlib_install.sh &  rmvlib_uninstall.sh)

## About
This script will install a working Atari Jaguar development environment, based on JLIBC and the Remover's Library, on a linux machine with access to the Ubuntu repositories.

________________

## Installed Development Tools
The following tools will be built and installed to **<user's home folder>/Jaguar/**.

### GCC M68000 Cross Compiler
Cross Motorola 68000 C cross compiler.

source: http://vincent.riviere.free.fr/soft/m68k-atari-mint

### RMAC
A modern version of Atari's old Madmac assembler. Created by Reboot.

source: http://shamusworld.gotdns.org/git/rmac

### RLN
A modern version of Atari's old ALN linker. Created by Reboot.

source: http://shamusworld.gotdns.org/git/rln

### JLIBC
The Remover's standard C library.

source: https://github.com/sbriais/jlibc

### RMVLIB
The Remover's C library for C functions specific to Atari Jaguar developement.

source: https://github.com/sbriais/rmvlib

________________

## Requirements
Linux with an internet connection and access to the Ubuntu repositories using apt/apt-get. This script has only been tested on Kubuntu 19.10 (2/26/2020).  Again, if you have access to the Ubuntu repositores there shouldn't be any issues accessing the packages needed (barring any future updates to necessary packages that could potential break this script).

If you are on another non-buntu distribution, you can attempt to manually installing the needed packages. Open up the *rmvlib_installer.sh* script in a text editor and refer to any lines that invoke *apt-get*.

________________

## Installing
Execute the install script, in a linux terminal, from wherever you have placed the script and the other contents of the archive. With the following command:

    sh ./rmvlib_install.sh

The script will ask for root permissions to install neccessary repositories and packages.

After the script finishes, and before you can build the example program, ***reboot your system or logout of your user and log back in***.  This will ensure that the new $JAGPATH environment variable is loaded from /etc/environment, allowing the current Makefile.config file to properly build the example program.  After logout/reboot, navigate to the following location in your home folder and run the make command.

    cd ~/Jaguar/example_programs/generic_example
    make
    
If you don't get any errors while compiling and linking the example program, everything should be built/installed correctly for the Jaguar development environment.

## Uninstall
If you make changes to the script, and/or you have run this installer script before, **you should run the uninstall script** before re-running the installer script. Navigate to the location of the uninstall script and run the following command:

    sh ./rmvlib_uninstall.sh
    
**IMPORTANT**

Because the uninstall script completely erases the Jaguar folder in your home folder, **do not start new projects inside the ~/Jaguar folder**. Any code/assets will be erased if your projects are in this folder.  The way the development environment is isntall allows the user to build from anywhere on their system. Pick another location other than the ~/Jaguar to do your development in to avoid losing your work.
    
### Debugging Scripts
If you run into problems running the script, use the following command instead to dump the output of the script as it runs.  You can then review the log to see where it is getting stuck.  **Be sure to run the uninstaller script before running the following command**.

    sh ./rmvlib_install.sh 2>&1 build.log
________________
## Notes
If you examine the install script, you will see some slight modifications to specific source files in the Remover's Libaray (RMVLIB). These small alterations are needed to get RMAC to properly compile these specific files in RMVLIB. These modifications are a good first place to check if the script breaks in the future.
________________
________________

# Additional Jaguar Development Binaries Linux Installer
(additional_tools_install.sh)

## About
This script installs additional binaries to accomadate Atari Jaguar development on Linux.  **This script is meant to be run after the rmac/jlinker/jlibc/rmvlib installation script and will fail otherwise**.
________________
## Included Applications
The following apps will be built and installed to **<user's home folder>/Jaguar/bin/** directory in the current user's Home folder.

### virutaljaugar
Atari Jaguar emulator for running programs from your computer. 

source: https://github.com/mirror/virtualjaguar

### jcp
Used to control a Skunkboard cart. With a Skunkboard and jcp you can easily send your .cof or .rom files to your Jaguar to test on real hardware.

source: http://www.harmlesslion.com/zips/SKUNKBOARD_FULL_RELEASE.zip

### lz77
A packing routine for data used in your programs.  Spefically, data packed with lz77 can be unpacked in your C code with the lz77_unpack() function. See Remover's Library documentation/source files for more details.

source: http://s390174849.online.de/ray.tscc.de/files/lz77_v13.zip

### jag-image-converter
Used to convert tga,png,gif,etc... formats to formats compatible with the Remover's library and the Jaguar.

source: https://github.com/sbriais/jconverter
________________
## Installing
To run this script, open up a terminal, navigate to the location of the script, and then run the script with the following command:

    sh ./additional_tools_install.sh
    
### Debugging Script
If you run into a problems, use the following command instead to dump the output of the script as it runs.  You can then review the log to see where it is getting stuck.

    sh ./additional_tools_install.sh 2>&1 build.log
    
________________
## Invoking Applications From Terminal
After installation, you may want to invoke these programs by name from the terminal in order to run them.  Two scripts have been added to **<user's home folder>/Jaguar/bin/** .  Navigate to **<user's home folder>/Jaguar/bin/**, and run the following commands to link or unlink the binaries from /usr/bin/:

    sh ./link_binaries.sh
    sh ./unlink_binaries.sh
    
________________
## Notes
Seb's image coverter (jcoverter) is the only application not built from source.  Instead a linux binary is pulled from source git repository.
