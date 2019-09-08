#!/bin/bash
#
# David Canadillas - dcanadillas@cloudbees.com
#
# Script that downloads and install Jenkins X CLI depending on the version selected:
#   ./install-jx.sh [-c] [-v <version>]
# - The option -c installs the latest CloudBees Jenkins X Distribution
# - The option -v installs the specific OSS version specified (without -c option)
# - If no option is defined it installs the latest OSS version
# - It also checks for a current jx installation in $JX_PATH and asks you to confirm you want to replace it
# - It should work on Linux based and MacOS operating systems

# NOTE: MacOS installation is not using brew

JX_PATH="/usr/local/bin" # Change if you want to use a different directoy for jx to be installed


function usage {
    echo -e "\nThis script installs Jenkins X CLI (OSS or CloudBees Distribution): \n
    \t Usage: ./install-jx.sh [-v <version>] [-c] \n
    \t Optional parameters:\n
    \t  -c :           If you want to install CloudBees Jenkins X Distribution. It installs just the last CJXD version, ignoring any version selected.\n
    \t  -v <version> : Installs the OSS specific version of Jenkins X\n
    \t Print this help: ./install-jx.sh -h\n"
}
# Let's use a function to decide if using sudo or not to install the jx binary depending on permissions in directory
function jxinstall {
    if [[ "$(id -u)" -ne 0 ]] && [[ ! -w $1 ]];then
        echo -e "\nInstalling Jenkins X cli in $1"
        sudo mv jx-download/jx $1
    else
        mv jx-download/jx $1
    fi
    $1/jx version -n
    echo -e "\n\tJenkins X cli is already installed in \"$(which jx)\"\n"
    if ! [[ $PATH == *"$1"* ]]; then 
        echo -e "Please, don't forget adding $1 to your PATH environment variable"
    fi
    jx profile $JXDIST
}
# This function downloads the JX cli depending on MacOS or Linux platform
function downloadcli {
    if [[ "$OSTYPE" =~ "darwin" ]]; then
        echo -e "You are installing Jenkins X in: \n"
        sw_vers
        echo -e "Downloading and installing binary...\n"
        curl -L "${VERSION_PATH}"/jx-darwin-amd64.tar.gz | tar xzv -C jx-download
    elif [[ "$OSTYPE" =~ "linux" ]]; then
        echo -e "You are installing Jenkins X in: \n"
        uname -ar
        curl -L "${VERSION_PATH}"/jx-linux-amd64.tar.gz | tar xzv -C jx-download
    fi
}

# If we want to use a specific version then we do "./install-jx -v <jx_version_number>"
while getopts "cv:h" opt; do
    case ${opt} in
        c )
            echo -e "Installing latest CloudBees Jenkins X Distribution...\n"
            VERSION_PATH="https://storage.googleapis.com/artifacts.jenkinsxio.appspot.com/binaries/cjxd/latest"
            JXDIST="cloudbees"
            # shift
            #break
            ;;
        v )
            # Let's check that the argument is not a following parameter
            if [[ "$OPTARG" =~ ^-. || -z "$OPTARG" ]]; then
                echo "No version specified. Ignoring and using latest"
                VERSION_PATH="https://github.com/jenkins-x/jx/releases/latest/download"
                JXDIST="oss"
                ((OPTIND--))
            # else
            #     echo "Hello"
            #     VERSION_PATH="https://github.com/jenkins-x/jx/releases/download/v$2"
            #     JXDIST="oss"
            fi
            if [ "$JXDIST" != "cloudbees" ];then
                echo -e "Installing Jenkins X OSS version $OPTARG.\n"
                VERSION_PATH="https://github.com/jenkins-x/jx/releases/download/v$OPTARG"
                JXDIST="oss"
            fi
            ;;
        h )
            usage
            exit 0
            ;;
        * )
            echo "Invalid option: $OPTARG" 1>&2
            usage
            exit 0
            ;;
        : ) 
            VERSION_PATH="https://github.com/jenkins-x/jx/releases/latest/download"
            echo "$OPTARG argument not set. Let's use latest version of Jenkins X CLI" 1>&2
            ;;
    esac
done
shift $((OPTIND-1))

# If no options we assume that latest OSS version is going to be downloaded and installed
if [ $OPTIND -eq 1 ]; then
    echo -e "No options were passed. Let's use latest version of Jenkins X CLI\n"
    VERSION_PATH="https://github.com/jenkins-x/jx/releases/latest/download"
    JXDIST="oss"
fi



echo -e "Using version $VERSION_PATH \n\n ------ "
ls "$JX_PATH"/jx
echo $JXDIST

shift "$((OPTIND-1))"

if [ -f "$JX_PATH/jx" ]; then
    echo -e "\nThere is already a Jenkins X CLI installed on your system. This script will replace jx binary in $JX_PATH."
    read -p "Do you want to continue? (y/N): " CONFIRM
    case $CONFIRM in
        [yY]|[Yy][eE][sS] )
            echo -e "You are installing the jx binary with $JXDIST Jenkins X distribution. \n"
            if [ $(which jx) != "$JX_PATH/jx" ]; then
                echo -e "Your current default jx cli command is in a different location than $JX_PATH\n"
                echo -e "Please, be aware of using the right order in your \$PATH environment variable"
            fi
            ;;
        [nN]|[nN][oO] | "" )
            echo -e "Exiting the installer... Here is your current Jenkins X installation: \n"
            /usr/local/bin/jx version
            echo -e "You can upgrade your CLI executing the following command:\n
                \t jx profile $JXDIST && jx upgrade cli "
            exit 0
            ;;
        * )
            echo -e "\nNot a valid option. Exiting...\n"
            usage
            exit 0
            ;;
    esac
fi

if [ ! -d "./jx-download" ]; then
    mkdir -p ./jx-download
fi

downloadcli
jxinstall ${JX_PATH}


