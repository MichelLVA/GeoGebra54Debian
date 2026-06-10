#!/bin/sh
####### get the string text (with 3 characters eg 868) yet installed : av and, new : ap 
function testSiMajggb54  {
	cd $HOME ;
	wget -nv -q -N https://download.geogebra.org/installers/5.4/version.txt -O ggbNew.txt ;
	n0=$(cat ggbNew.txt) ;
	ap=${n0:4:3} ;
	app=${n0:8:1} ;
	n1=$(cat /usr/share/ggb54/geogebra/version.txt) ;
	av=${n1:4:3};
	avv=${n1:8:1};
	}
testSiMajggb54 
###################### upgrade from av to ap
function majggb54  {
# in the download repertory 
tel=$(xdg-user-dir DOWNLOAD)  
wget 'https://download.geogebra.org/installers/5.4/GeoGebra-Linux-Portable-5-4-'$ap'-'$app'.tar.bz2' -P $tel
cd $tel
tar -jxvf 'GeoGebra-Linux-Portable-5-4-'$ap'-'$app$'.tar.bz2'
rm  'GeoGebra-Linux-Portable-5-4-'$ap'-'$app$'.tar.bz2'
# in /home/<user>
cd $HOME
cp -r -f  'ggb54'$av$avv 'ggb54'$ap$app #   recupere ancien répertoire
cd 'ggb54'$ap$app'/DEBIAN' 
# change les num dans control et preinst
sed -i 's/5.4.'$av'.'$avv'/5.4.'$ap'.'$app'/' control
sed -i 's/ggb54'$av$avv'/ggb54'$ap$app'/' control
sed -i 's/5.4.'$av'.'$avv'/5.4.'$ap'.'$app'/'  preinst
cd $HOME'/ggb54'$ap$app'/usr/share/applications'
# change les num dans ggb54.desktop
sed -i 's/'$av'.'$avv'/'$ap'.'$app'/'  ggb54.desktop
cd $HOME'/ggb54'$ap$app'/usr/share/ggb54'
#efface ancien répertoire geogebra dans ggb54
rm -r geogebra
# copie le nouveau répertoire geogebra
cp  -r  $tel'/GeoGebra-Linux-Portable-5-4-'$ap'-'$app'/geogebra'  $HOME'/ggb54'$ap$app'/usr/share/ggb54/'
chmod +x $HOME'/ggb54'$ap$app'/usr/share/ggb54/geogebra/geogebra'
# upgrade the package, install it and remove the past version 
cd $HOME
# efface ancienne application ggb54
sudo apt-get remove 'ggb54'$av$avv 
# construit et installe le package deb
dpkg-deb --build --root-owner-group 'ggb54'$ap$app
sudo dpkg -i 'ggb54'$ap$app'.deb'
# efface ancien répertoire et package deb dans home et téléchargements
rm -rf $HOME'/ggb54'$av$avv
rm  $HOME'/ggb54'$av$avv'.deb'
cd $tel
rm -rf 'GeoGebra-Linux-Portable-5-4-'$ap'-'$app

cd $HOME

}
####
############################
if [ "$ap$app" \> "$av$avv" ]; then 
	majggb54;
	else echo "Pas de mise à jour de ggb 54";
	echo ""; 	

fi
# efface la réf au nouveau
rm ggbNew.txt 
$SHELL

