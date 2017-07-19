# ubuntu_dev/ - Contains Vagrantfiles for building Linux VM machines for software development

# The following directories build machines

## basic/
### for building Linux from bento/ubuntu-16.04 64bit box image to include libraries needed
### for project (note: ubuntu/xenial64 and cloud-images.ubuntu.com/xenial images were not functional
### as of Dec 1st, 2016)

## msp430/
### for building TI-MSP430 software, including Vagrantfiles and other scripts

## arm_msp/
### for building TI-MSP432 (ARM Cortex-M4F) software.

## common/
### Common scripts and other shared files

## mammark/
### for test mammal tagging (marking) application


#######################################################################################################
#
# General Notes
#

## Add these Vagrant plugins

vagrant plugin install vagrant-vbguest


## Published vagrant boxes can be found on http://tinyprod.net/boxes/

## Example on how to install a previously built and published box

curl -O -L "http://tinyprod.net/boxes/ubuntu_dev-basic_2016-08-30.box"
vagrant box add ubuntu_dev/basic ubuntu_dev-basic_2016-08-30.box --force


## When using Apple MAC OSX for host machine, care needs to be taken with file names
## since MAC has case-insensitive naming but Linux is case-sensative

## user must have account on tinyprod.net that has permission to upload files

ssh danome@tinyprod.net -p 23456


## Global provisioning statements are added to your ~/.vagrant.d/Vagrantfile
##   see https://github.com/geerlingguy/drupal-vm/issues/681 for bogus tty error msg workaround

Vagrant.configure("2") do |config|
  config.vm.boot_timeout = 700
  # Fixes "stdin: is not a tty" and "mesg: ttyname failed : Inappropriate ioctl for device" messages --> mitchellh/vagrant#1673
  device.vm.provision :shell , inline: "(grep -q 'mesg n' /root/.profile && sed -i '/mesg n/d' /root/.profile && echo 'Ignore the previous error, fixing this now...') || exit 0;"
  # ... other stuff
end


## UTC is the default datetime for all boxes.
## User should explicitly set date time in their Vagrantfile like this:

$set_date = <<SCRIPT
  export area=America
  export zone=Los_Angeles
  export path=/usr/share/zoneinfo/$area/$zone
  echo $path
  echo "$area/$zone" > /tmp/timezone
  cp -f /tmp/timezone /etc/timezone
  cp -f $path /etc/localtime
SCRIPT
## and then add something like this:
  config.vm.provider "virtualbox" do |vb, override|
    override.vm.provision :shell, inline: $set_date
  end




#######################################################################################################
#
# Managing VAGRANT BOXES
#
## provides instructions on how to build and publish boxes for use by others.

## INSTRUCTIONS to make the Vagrant box. 
##  Other Vagrantfiles can use resulting box as their starting point.

## variables for boxing ubuntu_dev-basic
export INAME=basic
export ILIST='Vagrantfile,../README.md'

## variables for ubuntu_dev-msp430
export INAME=msp430
export ILIST='Vagrantfile'

## Variables for ubuntu_dev-arm_msp
export INAME=arm_msp
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
			"description_html": "<p>Dev Environment description</p>",
			"description_markdown": "Dev Environment description",
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

## replace this line to use local file

"url": "file:///Users/danome/Downloads/ubuntu_dev-basic.2017-01-04.box"



## then build and run basic.

$ vagrant up

## this will check for correct VirtualBox Guest Additions and install if out of sync.



*** Box releases:

basic:   0.2.0   updated to current VBox Guest additions
         0.3.0   update to Ubuntu 14.04.5, Vbox client 5.0.26
                 update packages for CCS dependencies
         0.3.1   add firefox for CCS
         0.4.0   update to 64 bit
         0.4.1   16.04 64bit using bento box

msp430:  0.2.0   includes flasher, TI toolchain 4.0.1.0
         0.3.0   on basic 0.3.0
         0.3.1   basic 0.3.1, add flasher 1.3.10 (MSPDEBUG 3.8.1.0)
         0.4.0   update to 64 bit

arm_msp: 0.3.0   adds arm/msp432 toolchain and tools to msp430
         0.3.1   msp430 box 0.3.1, add CCS network installer
         0.4.0   update to 64 bit
         0.4.1   add xds110/dfu vid/pid for usb for flashing xds110 pod
         0.4.2   cleaned up arm includes, add JLink, OpenOCD
