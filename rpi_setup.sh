#!/bin/bash
# bash script to setup Raspberry Pi
#
# run using
#     sudo bash [bash_options] rpi_setup.sh [install_options]
#
# It takes me a while to run through my setup for a Raspberry Pi. So, the goal
# of this script is to setup a raspberry pi with minimal  human interaction.
#
# raspi-config cannot be automated because of the localisation steps.

############################# <- 80 Characters -> ##############################
#
# This style of commenting is called a garden bed and it is frowned upon by
# those who know better. But, I like it. I use a garden bed at the top to track
# my to do list as I work on the code, and then mark the completed To Dos.
#
# Within the code, To Dos include a comment with ???, which makes it easy to
# find
#
# Once the To Do list is more-or-less complete, I move the completed items into
# comments, docstrings or help within the code. Next, I remove the completed
# items.
#
# To Do List:
#   a) follow my raspberry project setup instructions and automate all of them
#   ********************* STOPPPED HERE ************************
#      a.1) imrpove security
#   b) script may need to run multiple timess. Add file to track where setup
#      stopped
#   c) move functions to an import file
#
#
#   w) test from scratch that it works
#   x) run shell check
#   y) add rpi_setuprpi_setup.sh and rpi_setup.cfg to github
#   z) add to raspberry pi projects
#
# Do later or not at all:
#
# References:
#   Non-Interactive Mode of raspi-config
#     https://loganmarchione.com/2021/07/raspi-configs-mostly-undocumented-non-interactive-mode/
#   To find raspi-config "do" commands, go to link below and search for: nonint do
#     https://github.com/raspberrypi-ui/rc_gui/blob/master/src/rc_gui.c
#   or nano /usr/bin/raspi-config, which should be current code
#
# Naming conventions
#   - lowercase or camelCase for local variable and function names
#   - first uppercase or CamelCase for global variables
#   - all uppercase for ENV variables
#
############################# <- 80 Characters -> ##############################

############################### Global Variables ###############################
Version="01.01"

RebootRequired=false
StateFilename=".rpi_setup.state"
StartMessageCount=0
Result=false

# Options
OptionDisableIPv6=true
OptionRemoveCamera=true
OptionClear=true
OptionHeadless=true
OptionUpdate=true

Bold=$(tput bold)
Normal=$(tput sgr0)
Red=$(tput setaf 1)
Green=$(tput setaf 2)
Blue=$(tput setaf 4)
Black=$(tput sgr0)

# from /usr/bin/raspi-config
INTERACTIVE=False

################################## Functions ###################################
function echoStartingScript {
    if [ "$StartMessageCount" -eq 0 ]
    then
        echo -e "\n${Bold}${Blue}Starting Raspberry Pi Setup Script $Version ${Black}${Normal}"
        StartMessageCount=1
    fi
}

function echoExitingScript {
    if [ -z ${1+x} ]
    then
        declared=false
    else
        declared=true
    fi

    echo -e "\n${Bold}${Blue}Exiting Raspberry Pi Setup Script ${Black}${Normal}"

    if [ "$RebootRequired" = true ]
    then
        if [ "$declared" = true ]
        then
            echo -e "\n ${Bold}${Red} $1 ${Black}${Normal}"
        fi
        echo -e "\n ${Bold}${Blue} Rebooting Raspberry Pi in 10s (<CTRL>-C to stop) ${Black}${Normal}"
        sleep 10s
        sudo reboot
    fi

    exit
}

function echoHelp {
    echo -e "\n$Help"
    exit
}

# ??? need to only write one entry to file, if entry exists then replace it with sed command
function writeToSetup {
    if [ "$WriteSetupState" = "append" ]
    then
        echo "$1=$2" >> "$StateFilename"
    else # "$WriteSetupState = "create"
        WriteSetupState="append"
        echo "$1=$2" > "$StateFilename"
    fi
}

# As the script progresses, it sets variables indicating certain steps are
# complete. And these variables are saved off to .rpi_setup.state. On the
# next run, these variables are read in. Prior to executing those steps, the
# variables are not even defined. So, this function checks if a variable is
# declared, and if set then check its state the purpose is to return false if
# not set, or if set and the value is not true return false. Otherwise, return
# true.
#
# So, for example, if a new hostname is set, then don't set it again
function checkVar {
    declare -p "$1" &>/dev/null # var has been declared (any type)
    declared=$?
    if [ $declared = 1 ]
    then
        # variable is not set
        Result=true
    else
        name=$1
        value="${!name}"
        if [ "$value" = true ]
        then
            Result=false
        else
            Result=true
        fi
    fi
}


################################ Starting Script ###############################
echoStartingScript

# Import file containing steps that have been completed
if [ -f "$StateFilename" ]
then
    echo -e "\n ${Bold}${Blue} setup.state file exists ${Black}${Normal}"
    . $StateFilename
    WriteSetupState="append"
else
    echo -e "\n ${Bold}${Blue} setup.state file does not exist ${Black}${Normal}"
    WriteSetupState="create"
fi


# Import configuration file for this script
# The config file contains all the apps to install, all the modules to pip3,
# all the files to get, the final path for each, and any permissions required.
# It is basically just a collection of global variables telling the script what
# to do.
if [ -f rpi_setup.cfg ]
then
        . rpi_setup.cfg
else
        echo -e "\n  ERROR: Setup script requires rpi_setup.cfg"
        echo -e "\n    Please wget rpi_setup.cfg from github or create one."
        echoExitingScript
fi

# Process command line options
# All options must be listed in order following the : between the quotes on the
# following line:
while getopts ":6cChHuv" option
do
    case $option in
        6) # do not disable IPv6
            OptionDisableIPv6=False
            ;;
        c) # disable clear after update and upgrade
            OptionClear=false
            ;;
        C) # keep camers
            OptionRemoveCamera=false
            ;;
        h) # display Help
            echoHelp
            exit;;
        H) # do not remove packages not needed in headless operation
            OptionHeadless=false
            ;;
        u) # skip update and upgrade steps
            OptionUpdate=false
            ;;
        v) # show version number
            echo -e "\n  ${Bold}${Blue} Version = $Version ${Black}${Normal}"
            exit
            ;;
        *) # handle invalid options
            echo -e "\n  ${Bold}${Red} ERROR: Invalid option ${Black}${Normal}"
            echo -e "\n  ${Bold}${Blue} To see valid options, run using: ${Black}${Normal}"
            echo -e "\n    \$ sudo bash ${0##*/} -h ${Black}"
            echoExitingScript
    esac
done


# Exit if running as sudo or root
if [ "$EUID" -ne 0 ]
then
    echo -e "\n  ${Bold}${Red}ERROR: Must run as root or sudo ${Black}${Normal}"
    echo -e "\n    ${Bold}${Red}\$ sudo bash ${0##*/} ${Black}${Normal}"
    echoExitingScript
fi


# pip3_install fails if errexit is enabled, not sure why
# exit on error
# set -o errexit


# exit if variable is used but not set
set -u
# set -o nounset


checkVar "StateNotSuccess"
if [ $Result != true ]
then
    echo -e "\n ${Bold}${Blue} All done. Setup is a Success ! ${Black}${Normal}"
    echoExitingScript
fi

# update and uphrade packages
if [ "$OptionUpdate" = true ]
then

    echo "  ${Bold}${Blue}updating ${Black}${Normal}"
    sudo apt update -y
    echo -e "\n  ${Bold}${Blue}upgrading ${Black}${Normal}"
    sudo apt upgrade -y
    echo -e "\n  ${Bold}${Blue}removing trash ${Black}${Normal}"
    sudo apt autoremove -y

    # the above generates a lot of things that may not be relevant to the install of
    # this application. So, clear the screen and then put Starting message here.
    if [ "$OptionClear" = true ]
    then
        clear
        StartMessageCount=0
        echoStartingScript
    fi
else
    echo -e " ${Bold}${Blue}   Skipping update, upgrade and auto-remove [option] ${Black}${Normal}"
fi


# Disable IPv6
if [ "$OptionDisableIPv6" = true ]
then
    checkVar "StateDisableIPv6"
    if [ $Result = true ]
    then
        echo -e "\n ${Bold}${Blue}   Disable IPv6 ${Black}${Normal}"

        echo "# disable IPv6" | tee -a /etc/sysctl.conf
        echo "net.ipv6.conf.all.disable_ipv6=1" | tee -a /etc/sysctl.conf
        echo "net.ipv6.conf.default.disable_ipv6=1" | tee -a /etc/sysctl.conf
        echo "net.ipv6.conf.lo.disable_ipv6=1" | tee -a /etc/sysctl.conf
        echo "net.ipv6.conf.eth0.disable_ipv6 = 1" | tee -a /etc/sysctl.conf

        sed -i $'s/exit 0/service procps reload\\\nexit 0/g' /etc/rc.local

        writeToSetup "StateDisableIPv6" "true"
        RebootRequired=true
        echoExitingScript "After reboot, please rerun this script"
    else
        echo -e " ${Bold}${Blue}   IPv6 already disabled [state] ${Black}${Normal}"
    fi
else
    echo -e " ${Bold}${Blue}   Skipping the disabling IPv6 [option] ${Black}${Normal}"
fi

# Running Headless
if [ "$OptionHeadless" = true ]
then

    checkVar "StateHeadless"
    if [ $Result = true ]
    then
        # remove unused packages when running headless
        checkVar "StateRemoveUnusedPackages"
        if [ $Result = true ]
        then
            echo -e "\n ${Bold}${Blue}   Remove Unused Packages ${Black}${Normal}"

            rm unused_rpi.sh
            wget "https://raw.githubusercontent.com/dumbo25/unsed_rpi/main/unused_rpi.sh"
            chmod +x unused_rpi.sh

            echo -e "\n ${Bold}${Blue}     Running unused_rpi.sh ${Black}${Normal}"
            bash unused_rpi.sh

            writeToSetup "StateRemoveUnusedPackages" "true"
            RebootRequired=true
        else
            echo -e " ${Bold}${Blue}   Skipping removal of unused packages [state] ${Black}${Normal}"
        fi

        echo -e "\n ${Bold}${Blue}   Remove dessktop packages not used in headless mode ${Black}${Normal}"

        rm desktop.sh
        wget "https://raw.githubusercontent.com/dumbo25/unsed_rpi/main/desktop.sh"
        chmod +x desktop.sh

        echo -e "\n ${Bold}${Blue}     Running desktop.sh ${Black}${Normal}"
        bash desktop.sh

        writeToSetup "StateHeadless" "true"
        RebootRequired=true
    else
        echo -e " ${Bold}${Blue}   Desktop packages already removed [state] ${Black}${Normal}"
    fi
else
    echo -e " ${Bold}${Blue}   Skipping removal of desktop packages [option] ${Black}${Normal}"
fi

# Remove Camera
if [ "$OptionRemoveCamera" = true ]
then
    checkVar "StateRemoveCamera"
    if [ $Result = true ]
    then
        echo -e "\n ${Bold}${Blue}   Remove camera ${Black}${Normal}"
        apt purge vlc* -y
        apt autoremove -y

        writeToSetup "StateRemoveCamera" "true"
        RebootRequired=true
    else
        echo -e " ${Bold}${Blue}   Camera already removed [state] ${Black}${Normal}"
    fi
else
    echo -e " ${Bold}${Blue}   Skipping camera removal [option] ${Black}${Normal}"
fi

if [ $RebootRequired = true ]
then
    echoExitingScript "After reboot, please rerun this script"
else
    writeToSetup "StateNotSuccess" "true"
    echoExitingScript
fi
