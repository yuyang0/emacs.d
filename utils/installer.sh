#!/bin/bash
# Time-stamp: <2013-12-08 10:15:24 Sunday by Yu Yang>
#===============================================================================
#      Filename:  installer.sh
#       Created:  2013-12-07 18:56:42
#
#   DESCRIPTION:  install my emacs configuration
#   Usage: curl -L http://dwz.cn/c8eBG | sh
#          wget --no-check-certificate http://dwz.cn/c8eBG -O - | sh
#
#        Author:  Yu Yang
#         Email:  yy2012cn@gmail.com
#===============================================================================
set -o nounset
function emacs_setting()
{
    # move emacsclient icon to system directory
    if [ ! ~/.emacs.d/utils/emacsclient.sh ]; then
        chmod u+x ~/.emacs.d/utils/emacsclient.sh
    fi
    echo $PASSWORD | sudo -S cp -f ~/.emacs.d/utils/emacsclient.desktop /usr/share/applications/
}

if [ -z "$PASSWORD" ];then
    read -s -p "Enter your root password:" PASSWORD
fi

# check the password
while true; do
    echo "$PASSWORD" | sudo -S echo "" && break
    echo
    read -s -p "incorrect password($PASSWORD), please try again: " PASSWORD
done

echo $PASSWORD | sudo -S add-apt-repository -y ppa:chris-lea/node.js
echo $PASSWORD | sudo -S apt-get -y update
echo $PASSWORD | sudo -S apt-get -y install nodejs python-pip git git-core

test -d ~/.emacs.d || git clone https://github.com/yuyang0/emacs.d.git ~/.emacs.d

# install third-pard command line tools
npm_packages="jslint csslint jsonlint js-beautify"
pip_packages="jedi rope ropemacs flake8"
system_packages="w3m sbcl racket clang php-cli aspell"
gem_packages="rubocop"

for package in $npm_packages; do
    echo $PASSWORD | sudo -S npm install -g $package
done
for package in $pip_packages; do
    echo $PASSWORD | sudo -S pip install $package
done
for package in $system_packages; do
    echo $PASSWORD | sudo -S apt-get -y install $package
done
for package in $gem_packages; do
    gem install $package
done

# install tidy-html5
echo $PASSWORD | sudo -S apt-get -y remove libtidy-0.99-0 tidy

git clone https://github.com/w3c/tidy-html5
cd tidy-html5
make -C build/gmake/
echo $PASSWORD | sudo -S make install -C build/gmake/

# install Pymacs
git clone git@github.com:pinard/Pymacs.git
cd Pymacs
make check
echo $PASSWORD | sudo -S make install
