#!/bin/bash
echo "tested with debian 13 and Ubuntu 24.04"
echo "From the GeoGebra portable Linux file"
echo "We install openjdk-25-jre and wget"
echo "it will be the java used"
echo "The downloaded version number is temporarily named ggbNew.txt in $HOME"
echo "The source folder is placed in the user's folder $HOME"
echo "et conservé pour les mises à jour futures"
echo "It must be kept for installing to build the package and for the updates."
echo "A debian's package ggb54<num sans.> is created in $HOME"
echo "The application is named ggb54"
echo "This is an amateurish piece of work by "
echo "Michel Iroir"
echo "With, no doubt, some flaws"
echo "The email is not good, go to reddit.com/r/geogebra to tell me what you think about this job." 
echo "You are asked for your debian user password to install : "
############# install java out of the ggb package and wget to load files
sudo apt install openjdk-25-jre
sudo apt install wget
########## last
cd $HOME 
wget -nv -q -N https://download.geogebra.org/installers/5.4/version.txt -O ggbNew.txt ;
n0=$(cat ggbNew.txt) ;
ap=${n0:4:3} ;
app=${n0:8:1};
##### create a temporary repertory in /home/<user> 'ggb54'$ap to create after the deb package
cd $HOME
mkdir 'ggb54'$ap$app ####
cd 'ggb54'$ap$app ###
mkdir usr
mkdir DEBIAN
cd usr
mkdir bin
mkdir share
cd share
mkdir ggb54
mkdir applications
cd ggb54
mkdir icons

#create a (bad) icon in usr/share/ggb54/icons !
cd icons  #####
cat << EOF > icon.tmp
iVBORw0KGgoAAAANSUhEUgAAABYAAAAWCAYAAADEtGw7AAAAAXNSR0IArs4c6QAAAAZiS0dEAP8A/wD/oL2nkwAAA5NJREFUOMu1lV1Mm1UYx//P26+Nj8JcC+UFS9ou1CDy4SSQWIvZlhASTJZdbCPLYIlNa0aIoZmJhmmCN4szu1xKG1mjETU1LHrjsjBRMKvbBOeiKy0fZRCpECcdIrSFvn28AYTgtrJkJzk5F+ec3/Nxnv9ziJnxNIaQziGlMqM2N7fwLSIypE1m5kfOgoLn2xsb373vdPZzTU3TTFlZ9ZG2tjbV4+7Ro1Jhs9meGRwMjJw5488DgGRyBRcvWmGxVKQAhABcFgThI5fLdS+tVDidzt0Oh6NDJpNNKRSUt248FluAJEmTAHwAGEBHKpUK2O3294iINjO2eWyz2YplMtnXACoAhMbG7l2em+Njev2L6tHRH2bCYX8DM/8BAHa7vVoQBBcz7w8GR6/eujX8eTy+6GPm2AaYiBRNTU2m7Ozs7wFoAbwfjUbP+Xy+FSLKBmAEEGDm1c2OOByOjKGh0YnS0qO6zMx87uv78HY4fMNKzIyiohfeycrSOlQqRYFWq5SbTOJxt9v9ZTqPT0RGq9Xx44kTXXkAEAj0sdd7sl0goufM5oNvOp39xa2tV5VEpiWPx/PbDkp2OZH4ZyOKWOxBknn1bzkAoyiW5q5viGK5ai3skTTLdVav3/9xT4+tVa3OzwkGr91ZXJz/RADw3dDQp7ORyF1EIndx/Xp3CED/TlQ2PT3coVbPfaBUBnHgQGUHM0sCM8eqqoq+unKlFZcuHf1sYsL/KjPHdiphURS1Go0GAIIbdaxWq3MqK81oaLCcZub5nUI7OzvlAA4D+MXtdk9vgJn5r7U1/0kaTiQSOQ3AAKB7i/KIyL+2vpYubM+eZ+t0OvM1g6GiN5lMngMQjEajni3gRCLxDYA5AG/X19cbiKiRiPY9DJqZqakuL2/84uzZ2wdbWnqODA+P7xIEocXn861sAXu93jiAtuXlZc3sbGqkubm712p9Y7CwsLz1/8A5OZq2Q4fadUplBkSxDApF/nxXV9f4Q3uF2fzSz6dO9Vbt3VsMALhw4ZWIxVJSrVKpYpIk7WLmSiI6HA7/flKvP7a7pqYZqZSE8+dfDk1O3ixl5tQ6S77ZysLCYhBA1X8NXi7K5fIZSZLW5QsAMBqLfvX7PfcHBtyG1dX44tLSg9c3Q7d5TES6kpK6b2trm/dNTf20EI+PDVRUmP4EoAAQB3BHEIQbLpfrsZLf1jaJKAtAHYAQM48/6Z9HT+sz/RezLqw4O6RYdgAAAABJRU5ErkJggg==
EOF
base64 -d icon.tmp >geogebra.png 
rm icon.tmp

#create the files in DEBIAN, of course, the Maintener does not (yet) exist !
cd $HOME'/ggb54'$ap$app'/DEBIAN'  #####
cat << EOF > preinst
#!/bin/bash
echo "bonjour !"
echo "non official ggb5.4.$ap.$app b"
echo "not updated"
echo "for debian 64 bits"
echo "without java in the package"
echo "tried with java 25.0.1-64 bit"
echo " from openjdk-25-jre"
EOF
chmod 0755 preinst
cat << EOF > control
Package: ggb54$ap$app
Version: 5.4.$ap.$app
Section: base
Priority: optional
Architecture: all
Depends: bash
Maintainer: dev <a@nobody.fr>
Description: GeoGebra 5.4.$ap.$app not official  
Homepage: https://www.geogebra.org 
EOF
chmod 0750 control
#create the files in usr/bin !
cd $HOME/'ggb54'$ap$app/usr/bin  #####
cat << EOF > ggb54
#!/bin/bash
#---------------------------------------------
# Script to start GeoGebra
#---------------------------------------------

#---------------------------------------------
# Export name of this script

export GG_SCRIPTNAME="geogebra"


#---------------------------------------------
# Export Java Command

ARCH=`uname -m`
export JAVACMD="/bin/java"

#---------------------------------------------
# Export path of directory containing .$GG_SCRIPTNAME/geogebra.conf

export GG_CONFIG_PATH="/home/$USER"

#---------------------------------------------
# Run
GG_XMS='32m'
GG_XMX='1024m'

GG_SHOWSPLASH='false'
exec "/usr/share/ggb54/geogebra/geogebra" --settingsfile="/home/$USER/.config/geogebra/geogebra.properties" "$@"

EOF
chmod +x ggb54

#create the files in usr/share/application
cd $HOME'/ggb54'$ap$app'/usr/share/applications'  #####
cat << EOF > ggb54.desktop
[Desktop Entry]
Encoding=UTF-8
Version=5.4.$ap.$app
Type=Application
Name=ggb54
Icon=/usr/share/ggb54/icons/geogebra.png
Exec=/usr/share/ggb54/geogebra/geogebra
StartupNotify=true
X-UnityGenerated=true
Comment=GeoGebra54
Categories=Development;Education;
Terminal=true
Hidden=false
EOF

#creer les fichiers dans usr/share/ggb54 !
cd $HOME'/ggb54'$ap$app'/usr/share/ggb54'  #####
cat << EOF > readme.txt
To start GeoGebra, run ggb54.
EOF

cat << EOF > LICENSE.txt
https://www.geogebra.org/license
EOF

################# i load the portable version to copy the files from the repertory geogebra
################# i don't use the java from zulu...
function majggb54  {
# in the download repertory, I load the portable version linux 
tel=$(xdg-user-dir DOWNLOAD)  #repertoire telechargement 
wget 'https://download.geogebra.org/installers/5.4/GeoGebra-Linux-Portable-5-4-'$ap'-'$app'.tar.bz2' -P $tel
cd $tel
tar -jxvf 'GeoGebra-Linux-Portable-5-4-'$ap'-'$app'.tar.bz2'
#rm -r -f 'GeoGebra-Linux-Portable-5-4-'$ap'-'$app'/zulu11.62.17-ca-jre11.0.18-linux_x64'
rm  'GeoGebra-Linux-Portable-5-4-'$ap'-'$app'.tar.bz2'
# in /home/<user> i copy the ggb files
cp  -r  $tel'/GeoGebra-Linux-Portable-5-4-'$ap'-'$app'/geogebra'  $HOME'/ggb54'$ap$app'/usr/share/ggb54/'
chmod +x $HOME'/ggb54'$ap$app'/usr/share/ggb54/geogebra/geogebra'
rm -r -f 'GeoGebra-Linux-Portable-5-4-'$ap'-'$app
# install 
cd $HOME
dpkg-deb --build --root-owner-group 'ggb54'$ap$app
sudo dpkg -i 'ggb54'$ap$app'.deb'
##--force-overwrite 'ggb54'$ap$app'.deb'
#rm -r -f 'ggb54'$ap$app
rm ggbNew.txt
}
majggb54
$SHELL
