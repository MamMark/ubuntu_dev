# ubuntu_dev

*** Box releases:
basic:   0.2.0   updated to current VBox Guest additions
         0.3.0   update to Ubuntu 14.04.5, Vbox client 5.0.26
                 update packages for CCS dependencies
         0.3.1   add firefox for CCS
msp430:  0.2.0   includes flasher, TI toolchain 4.0.1.0
         0.3.0   on basic 0.3.0
         0.3.1   basic 0.3.1, add flasher 1.3.10 (MSPDEBUG 3.8.1.0)
arm_msp: 0.3.0   adds arm/msp432 toolchain and tools to msp430
         0.3.1   msp430 box 0.3.1, add CCS network installer

## basic
Files for building Linux 14.04 cloud-server box image with common development libraries

## msp430
Files for building TI-MSP430 software, including Vagrantfiles and other scripts

## arm_msp
Files for building TI-MSP432 (ARM Cortex-M4F) software.

## common
Common scripts and other shared files

## mammark
files for test mammal tagging (marking) application


#######################################################################################################
##
## Managing VAGRANT BOXES
##
## COMMAND to install a previously built and published box

curl -O -L "http://tinyprod.net/boxes/ubuntu_dev-basic_2016-08-30.box"
vagrant box add ubuntu_dev/basic ubuntu_dev-basic_2016-08-30.box --force


## INSTRUCTIONS to make the Vagrant box. 
##  Other Vagrantfiles can use resulting box as their starting point.

## variables for boxing ubuntu_dev-basic
export INAME=basic
export ILIST='Vagrantfile,../README.md'

## variables for boxing ubuntu_dev-msp430 or ubuntu_dev-arm_msp
export INAME=arm_msp
export INAME=msp430
export ILIST='Vagrantfile'

## General boxing rules using variables for specific box definition
###  package new box and add it to local repo. Also, save copy of box in dropbox to share.
export BASE_NAME=ubuntu_dev-$INAME
export TARGET=~/Downloads
export IMAGE_NAME=$BASE_NAME.`date +%Y-%m-%d`
export OBOX=$TARGET/$IMAGE_NAME.box
export OSUMS=$TARGET/$IMAGE_NAME.sha256

rm -f {$OBOX,$OSUMS}
vagrant destroy -f
vagrant up --provider=virtualbox
vagrant package --output $OBOX --include $ILIST
export CHECKSUM=`shasum -a 256 $OBOX`
echo $CHECKSUM >> $OSUMS
echo $CHECKSUM
<<fix up the json file, see below>>
scp -P 23456 {$BASE_NAME.json,$OSUMS,$OBOX} tinyprod.net:/var/www/boxes/
vagrant box add ubuntu_dev/$INAME $BASE_NAME.json --force

### command to retrieve a box from tinyprod
vagrant box add http://tinyprod.net/boxes/ubuntu_dev-msp430.json
or
wget --quiet http://tinyprod.net/boxes/ubuntu_dev-basic.2015-10-27.box
vagrant box add ubuntu-dev/basic ubuntu_dev-basic.2015-10-27.box

### add to Vagrantfile to load specific box version, and verify checksum
config.vm.box = "ubuntu_dev/basic"
config.vm.box_version='0.1.3'
config.vm.box_url = 'http://www.tinyprod.net/boxes/ubuntu_dev-basic.json'
config.vm.box_download_checksum = '7df73c367e56b083c51812afb6f62c7f117a5e2baf15d784ebb335a708a286eb'
config.vm.box_download_checksum_type = 'sha256'
config.vm.box_check_update = true


# EDIT the {basic,msp430}.json file with the new version, BOX name and CHECKSUM produced by steps above (example below)
{
	"name": "ubuntu_dev/basic",
	"description": "This box contains Ubuntu 14.04 32-bit Vagrant server with development basics",
	"short_description": "Trusty32 Development box",
	"versions": [{
		"version": "0.1.0",
		"status": "active",
		"providers": [{
				"name": "virtualbox",
				"description_html": "<p>Dev Environment</p>",
				"description_markdown": "Dev Environment",
				"url": "http://www.tinyprod.net/boxes/ubuntu_dev-basic.2015-10-28.box",
				"checksum_type": "sha256",
				"checksum": "5c9d399f2fe9694a398e121a77af5febc9c54626fec5c9fde35c29c82c88f606"
		},{
        "version": "0",
        "providers": [{
                "name": "virtualbox",
                "url": "https://www.dropbox.com/s/15q9uf88l2n6j7q/ubbuntu_dev_basic_2015-10-22.box"
                "checksum_type": "sha256",
                "checksum": "9d6684c82c1cfa8ba4304f428c4918f956869b1eca70f5b5b08ddd8cdb7c1499"
        }]
    }]
}


*** Make sure that VirtualBox Guest Additions are up to date.
    from: http://kvz.io/blog/2013/01/16/vagrant-tip-keep-virtualbox-guest-additions-in-sync/

same directory as basic/Vagrantfile:

$ vagrant plugin install vagrant-vbguest

then build basic.

$ vagrant up

will now check for correct VirtualBox Guest Additions and install if out of sync.
