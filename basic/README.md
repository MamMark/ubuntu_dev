# ubuntu_dev/basic
Vagrantfile to build vagrant box based on Linux 14.04 cloud-server box image with common development libraries

## COMMAND to install a previously built and published box

curl -O -L "https://www.dropbox.com/s/xvi8x8g9ga8nryb/ubuntu_dev-basic_2015-10-22.box"
vagrant box add ubuntu_dev/basic ubuntu_dev-basic_2015-10-22.box --force

# bug in dropbox, not working: vagrant box add /Users/dmaltbie/Dropbox/mammal-tag/ubuntu_dev/basic/basic.json



## INSTRUCTIONS to make the Vagrant box. 
##  Other Vagrantfiles can use resulting box as their starting point.

## variables for boxing ubuntu_dev-basic
export IBOX=basic
export ILIST='Vagrantfile,README.md'
#export EBOX=~/Dropbox/mammal-tag/Vagrant_boxes/ubuntu_dev-basic_`date +%Y-%m-%d`.box


## variables for boxing ubuntu_dev-msp430
export IBOX=msp430
export ILIST='Vagrantfile'


## General boxing rules using variables for specific box definition
##  package new box and add it. save copy of box in dropbox to share
export BNAME=ubuntu_dev-$IBOX
export EBOX=~/Dropbox/mammal-tag/Vagrant_boxes/$BNAME.`date +%Y-%m-%d`.box
export XSUMS=~/Dropbox/mammal-tag/Vagrant_boxes/SHA256SUMS_`date +%Y-%m-%d`
rm -f $EBOX
vagrant box remove $BNAME
vagrant destroy -f
vagrant up --provider=virtualbox
vagrant package --output $EBOX --include $ILIST
export CHECKSUM=`shasum -a 256 $EBOX`
vagrant box add ubuntu_dev/$IBOX --force --name $IBOX.json  --checksum-type sha256 --checksum $CHECKSUM
echo $CHECKSUM >> $XSUMS
echo $CHECKSUM 

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
