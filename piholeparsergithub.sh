#!/bin/bash
## This will parse lists and upload to Github

## Dependency check
{ if
which p7zip >/dev/null;
then
:
else
sudo apt-get install -y p7zip-full
fi }

## Clean directories to avoid collisions
sudo rm /etc/piholeparser/lists/*.txt
sudo rm /etc/piholeparser/mirroredlists/*.txt
sudo rm /etc/piholeparser/parsed/*.txt
sudo rm /etc/piholeparser/compressedconvert/*.7z
sudo rm /etc/piholeparser/compressedconvert/*.txt

## Timestamp
timestamp=`date --rfc-3339=seconds`

## Make sure we are in the correct directory
cd /etc/piholeparser

## Pull new lists on github
sudo git pull

## Process lists that have to be extracted
sudo bash /etc/piholeparser/compressedconvert.sh

## Parse Lists
sudo bash /etc/piholeparser/advancedparser.sh

## Mirror Lists
#sudo bash /etc/piholeparser/mirrorlists.sh

## Cleanup
sudo rm -r /etc/piholeparser/lists/*.txt
sudo rm /etc/piholeparser/compressedconvert/*.7z
sudo rm /etc/piholeparser/compressedconvert/*.txt

## Push Changes up to Github
sudo git config --global user.name "Your Name"
sudo git config --global user.email you@example.com
sudo git remote set-url origin https://USERNAME:PASSWORD@github.com/deathbybandaid/piholeparser.git
sudo git add .
sudo git commit -m "Update lists $timestamp"
sudo git push -u origin master
