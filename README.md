# ubuntu_dev - Vagrant development boxes
files related to building TI-MSP430 software, including Vagrantfiles and other scripts

## basic
Vagrantfile to build Linux 14.04 cloud-server box image with common development libraries

## msp430
Vagrantfile to build linux box with TI MSP430 development tools, based on ubuntu_dev/basic

## common
Scripts and other supporting files

## mammap
Vagrantfile to test mammal tagging application

# ubuntu_dev/basic
Vagrantfile to build vagrant box based on Linux 14.04 cloud-server box image with common development libraries


#######################################################################################################
##
## Managing VAGRANT BOXES
##
## COMMAND to install a previously built and published box

curl -O -L "https://www.dropbox.com/s/xvi8x8g9ga8nryb/ubuntu_dev-basic_2015-10-22.box"
vagrant box add ubuntu_dev/basic ubuntu_dev-basic_2015-10-22.box --force

# bug in dropbox, not working: vagrant box add /Users/dmaltbie/Dropbox/mammal-tag/ubuntu_dev/basic/basic.json


## INSTRUCTIONS to make the Vagrant box. 
##  Other Vagrantfiles can use resulting box as their starting point.

## variables for boxing ubuntu_dev-basic
export INAME=basic
export ILIST='Vagrantfile,README.md'

## variables for boxing ubuntu_dev-msp430
export INAME=msp430
export ILIST='Vagrantfile'

## General boxing rules using variables for specific box definition
##  package new box and add it to local repo. Also, save copy of box in dropbox to share.
export BASE_NAME=ubuntu_dev-$INAME
export TARGET=~/Dropbox/mammal-tag/Vagrant_boxes/
export IMAGE_NAME=$BASE_NAME.`date +%Y-%m-%d`
export OBOX=$TARGET/$IMAGE_NAME.box
export OSUMS=$TARGET/$IMAGE_NAME.sha256

rm -f {$OBOX,$OSUMS}
vagrant destroy -f
vagrant up --provider=virtualbox
vagrant package --output $OBOX --include $ILIST
export CHECKSUM=`shasum -a 256 $OBOX`
vagrant box add ubuntu_dev/$IBOX --force --name $IBOX.json  --checksum-type sha256 --checksum $CHECKSUM
echo $CHECKSUM >> $OSUMS
echo $CHECKSUM

scp -P 23456 $TARGET/$IMAGE_NAME.* danome@tinyprod.net:/var/www/boxes/

http://tinyprod.net/boxes


## UPDATE the basic.json file with the new version, BOX name and CHECKSUM produced by steps above (example below)
{
    "name": “ubuntu-dev-basic",
    "description": "This box contains Ubuntu 14.04 32-bit Vagrant server with development basics",
    "versions": [{
        "version": "0.1.1",
        "providers": [{
                "name": "virtualbox",
                "url": <dropbox URL>
                "checksum_type": "sha256",
                "checksum": $CHECKSUM
        }]
    },{
        "version": "0.1.0",
        "providers": [{
                "name": "virtualbox",
                "url": "https://www.dropbox.com/s/15q9uf88l2n6j7q/ubbuntu_dev_basic_2015-10-21.box"
                "checksum_type": "sha256",
                "checksum": "116beb6c899a0476d3de00a63598fe27a0c339ab536beea70e89dfa5e1320a6f"
        }]
    }]
}
