# GeoGebra54Debian
Bonjour, ces deux fichiers bash pour Debian (testé avec debian 13 sur AMD 64b)sont un bricolage non officiel d'un amateur, pour créer un paquet deb de GeoGebra 5.4 classique en utilisant le téléchargement de la version portable de linux sur le site de GeoGebra.
Il y a sans doute plus malin mais ça marche très bien chez moi.
Je n'utilise pas le java fourni avec le fichier GeoGebra mais openjdk-25-jre afin que le paquet deb soit de taille la plus petite possible.
Etape initiale : 
A) Première installation : Exécuter Ggb54lastForDebianWithoutJava20260207.sh 
	Installe open-jdk-25-jre et wget
	Télécharge la version portable.
	Construit dans $HOME , le répertoire nécessaire pour créer le paquet deb (conserver ce paquet pour les mises à jours suivantes)
	Installe le paquet debian créé.
	On peut alors lancer le dernier GeoGebra 5.4 à l'aide de la commande ggb54
B) Mises à jour : Exécuter Ggb54UpgradeForDebianWithoutJava20260204.sh
    Teste à l'aide du téléchargement de la version en cours s'il y a une mise à jour à faire. Un fichier temporaire est créé dans $HOME
    En cas de mise à jour :
     le téléchargement de la dernière version portable est fait et utilisé pour modifier le répertoire dans $HOME et changer son nom
	 l'ancien paquet deb est supprimé et le nouveau créé.
	 le nouveau paquet deb est installé remplçant le précédent et conservant ses propriétés.
NB : l'adresse mail est "bidon"
	 
