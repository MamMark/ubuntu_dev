# ubuntu_dev

## basic
Files for building Linux 14.04 cloud-server box image with common development libraries

## msp430
Files for building TI-MSP430 software, including Vagrantfiles and other scripts

## common
Common scripts and other shared files

## mammap
files for test mammal tagging application


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
###  package new box and add it to local repo. Also, save copy of box in dropbox to share.
export BASE_NAME=ubuntu_dev-$INAME
export TARGET=~/Dropbox/mammal-tag/Vagrant_boxes
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
scp -P 23456 {$BASE_NAME.json,$OBOX,$OSUMS} danome@tinyprod.net:/var/www/boxes/
vagrant box add ubuntu_dev/$IBOX --force --name $BASE_NAME.json  

### retrieve a box from tinyprod
box add http://tinyprod.net/boxes/ubuntu-dev-msp430.json
or
wget --quiet http://tinyprod.net/boxes/ubuntu_dev-basic.2015-10-27.box
vagrant box add ubuntu-dev/msp430 ubuntu_dev-basic.2015-10-27.box

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
