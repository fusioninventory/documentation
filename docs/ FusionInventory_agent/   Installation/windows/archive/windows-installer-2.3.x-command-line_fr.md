---
layout: single
title: Windows installer 2.3.x command-line (fr)
---

[[!template id=info text="The following information has been obtained from *fusioninventory-agent\_windows-x64\_2.3.2.exe*, the installer for x64 architectures, but it's also valid for *fusioninventory-agent\_windows-x86\_2.3.2.exe*, the installer for x86 architectures."]]

**NOM**

**fusioninventory-agent\_windows-x64\_2.3.2.exe** -- FusionInventory
Agent 2.3.2 (x64 edition) Setup

**SYNOPSIS**

**fusioninventory-agent\_windows-x64\_2.3.2.exe** [*/Option*[ */Option*[
...]]]

**DESCRIPTION**

**fusioninventory-agent\_windows-x64\_2.3.2.exe** installe
FusionInventory Agent 2.3.2 sur votre système d'exploitation Microsoft
Windows.

**fusioninventory-agent\_windows-x64\_2.3.2.exe** a deux type
d'installation; le type **from-scratch**, Cela permet une installation
de FusionInventory Agent à partir de zéro, avec des options fixées par
défaut (voir ci-dessous), et le type **from-current-config**, qui fera
une installation avec les options paramétrées suivant les valeurs
actuellement utilisées par le FusionInventory Agent précédemment
installé sur le système (voir **/installtype**). (Gardez à l'esprit que
quelque soit le type d'installation choisi, toute ancienne version de
FusionInventory Agent sera désinstallée automatiquement juste après
l'installation de FusionInventory Agent 2.3.2)

**fusioninventory-agent\_windows-x64\_2.3.2.exe** a aussi deux modes
d'installation; Le *mode silencieux * (voir **/S**), qui lancera
l'installation de FusionInventory Agent sans interaction ou en mode
autonome,  et le *mode visuel*, qui permet de faire une installation de
FusionInventory Agent via une interface graphique et interactive.

**fusioninventory-agent\_windows-x64\_2.3.2.exe** est fourni avec une
série d'option (voir ci-dessous) d'installation qui répondent à
pratiquement tous les besoins ou tous les environnements. Pour utiliser
correctement ces options, il est essentiel de connaître l'ordre dans
lequel elles sont prises en compte. Cet ordre est comme suis (un nombre
élevé, une priorité importante).

0. Valeurs par défaut

1. Valeurs depuis la configuration de FusionInventory Agent (pour
Installation type **from-current-config**)

2. Valeurs depuis la ligne de commande

3. Valeurs depuis l'interface graphique (pour installation type *graphic
mode*)

Garder à l'esprit les éléments suivants lorsque vous utilisez la ligne
de commande:

* Il y a deux types d'options; celle qui active une option (*/option*),
et celle fixe une valeur à une option (*/option=valeur*).

* Le nom de ces options est sensible à la casse (*/html* n'est pas
identique à */HTML*).

* La valeur de ces options, sauf indication contraire, n'est pas
sensible à la casse (*/local=C:\\Temp* est identique à
*/local=c:\\temp*).

* Pour les options avec valeur,

  - Il ne faut pas d'espace autour du signe égal (*/local = c:\\temp* est
incorrect).

  - Si la valeur contient un espace ou le caractère (/), elle doit être
entre simple (') or double (") quotes (*/local='C:\\FusionInventory
Agent'*).

  - Si vous voulez mettre une valeur nulle, vous devez la positionner
entre deux quotes (*/local=''*).

Voici les options en ligne de commande disponibles:

**/acceptlicense**

Vous acceptez, et reconnaissez avoir lu et compris, les termes et
conditions de la licence pour FusionInventory Agent 2.3.2. (Par défaut:
Non)

 Vous devez utiliser cette option si vous voulez une installation en
mode silencieux (voir **/S**).

Si vous utilisez cette option en ligne de commande, mais pas l'option
**/S**, le  *mode visuel* d'installation se lancera sans demander la
licence.

**/add-firewall-exception**

Ajoute FusionInventory Agent dans la liste des exceptions du Firewall
Windows. (Par défaut: Non)

À faire

**/backend-collect-timeout**=*timeout*

Temps maximum pour exécuter les modules de la tâche  **Inventory**. (Par
défaut: 180 secondes)

**/ca-cert-dir**=*pathname*

Chemin absolu pour le dossier contenant les certificats standards
autorisés (CA). (Par défaut: "")

L'utilisation de cette option est incompatible avec l'utilisation de
l'option **/ca-cert-file**. Les options **/ca-cert-dir** et
**/ca-cert-file** s'excluent mutuellement.

le *dossier standard de certification* doit contenir les certificats
correspondants aux différentes autorités dans le format Privacy Enhanced
Mail (PEM), et leurs noms doivent correspondre aux valeurs de hachages
du champ *subject* du certificat, avec l'extension *\*.0*.

Par exemple, si vous voulez inclure le fichier du certificat
*FICert\_Class1.crt* dans le dossier *pathname*, vous devez calculer la
valeur de hachage pour le champ *subject* du certificat utilisé, par
exemple, avec OpenSSL

    C:\OpenSSL> openssl.exe x509 -in C:\FICert_Class1.crt -subject_hash -noout
    b760f1ce

et d'après le résultat, déplacez ou copiez le fichier du certificat dans
le dossier *pathname* ayant comme nom *b760f1ce.0*.

    C:\OpenSSL> move.exe C:\FICert_Class1.crt *pathname*\b760f1ce.0

**/ca-cert-file**=*filename*

Chemin complet des certificats de l'autorité de certification (CA). (Par
défaut: "")

L'utilisation de cette option est incompatible avec l'utilisation de
l'option **/ca-cert-dir**. Les options **/ca-cert-dir** et
**/ca-cert-file** s'excluent mutuellement.

*filename* doit avoir comme extension *\*.pem* (Privacy Enhanced Mail)
et peut contenir un ou plusieurs certificats de l'autorité de
certification. Pour concaténer plusieurs fichiers de certification dans
un seul fichier vous pouvez utiliser, par exemple, cette commande :
*copy*.

    C:\> copy.exe FICert_Class1.crt+FICert_Class2.crt FICerts.pem

**/ca-cert-uri**=*URI*

*URI* permettant d'obtenir le ou les fichiers de certificats de
l'autorité (CA). (Par défaut: "")

Pour utiliser cette option vous devez fournir une de ces deux options
**/ca-cert-dir** ou **/ca-cert-file**, mais pas les deux.

À faire

**/debug**=*level*

Fixe le niveau de debug de l'agent. (Par défaut: 0)

*level* peut avoir une des valeurs suivantes:

* **0**: Pas de Debug

* **1**: Debug normal

* **2**: Debug complet

**/delaytime**=*limit*

Paramètre le délai pour lancer le premier contact avec le serveur (voir
**/server**). Ce délai est calculé aléatoirement entre *limit/2* et
*limit* secondes. (Défaut: 3600 secondes)

Cette option est ignorée pour contacter le serveur après le premier
contact selon, pour chaque serveur, leur paramètre spécifique
(PROLOG\_FREQ).

L'option **/delaytime** est utilisée seulement si  FusionInventory Agent
est lancé en *mode serveur* (voir **/execmode**).

**/dumphelp**

Voir **/help**.

**/execmode**=*mode*

Définit le mode d'exécution de l'agent. (Par défaut: **Current**)

*mode* peut avoir une des valeurs suivantes:

* **Service**: L'agent est lancé comme un Service Windows (toujours actif)

* **Task**: L'agent est lancé par le gestionnaire de Tâche Windows (actif
par intervalle)

* **Manual**: L'agent n'est pas lancé automatiquement (pas de **Service**,
pas de **Task**)

* **Current**: L'agent est lancé suivant la même règle que l'agent
actuellement installé

Le mode **Service** est aussi connu comme *mode serveur*.

Le mode **Task** est seulement disponible pour Windows XP (ou supérieur)
et Windows Server 2003 (ou supérieur) .

Dans le cas d'une installation **from-scratch** (voir **/installtype**),
le mode **Current** est synonyme de **Service**.

**/help**

Cette aide. Si l'option **/help** est présente, l'aide est montrée et
l'installation interrompue.

Vous pourriez préférer faire usage de l'option **/dumphelp** au lieu de
l'option **/help** pour avoir toutes les informations. L'option
**/dumphelp** crée un fichier RTF contenant l'aide, et arrête
l'installation.

**/html**

Sauvegarde l'inventaire en HTML au lieu du XML. (Par défaut: Non)

L'option **/html** est utilisée seulement si vous avez aussi indiqué une
valeur pour l'option /local.

**/httpd**

Cette option est l'opposée de **/no-httpd**. Voir **/no-httpd** pour
plus d'information.

**/httpd-ip**=*ip*

Adresse IP que le serveur web intégré utilisera. (Par défaut: 0.0.0.0)

**/httpd-port**=*port*

Port IP que le serveur web intégré utilisera. (Par défaut: 62354)

**/httpd-trust**={*ip*|*range*|*hostname*}[,{*ip*|*range*|*hostname*}[...]]

Adresses IP de confiance qui ne nécessite pas de jeton
d'authentification par le serveur web intégré. (Par défaut:
127.0.0.1/32)

*ip* est une adresse IP en notation décimale (ex. "127.0.0.1") ou en
notation CIDR (ex. "127.0.0.1/32")

*range* est une plage d'adresses IP en notation décimale (ex.
"192.168.0.0 - 192.168.0.255" ou "192.168.0.0 + 255") ou en notation
CIDR (ex. "192.168.0.0/24")

*hostname* est le nom de l'hôte (ex. "itms.acme.org")

Sachez que **/httpd-trust** ne doit pas forcément inclure le nom de
l'hôte que vous aurez paramétré dans l'URIs de l'option **/server**
parce qu'il est tacitement inclus. Regardez l'exemple suivant; Les deux
configurations sont équivalentes.

    /httpd-trust="127.0.0.1/32,itms.acme.org"
    /server="http://itms.acme.org/glpi/plugins/fusioninventory/"
    
    ----
    
    /httpd-trust="127.0.0.1/32"
    /server="http://itms.acme.org/glpi/plugins/fusioninventory/"

**/installdir**=*pathname*

Définit le dossier de base pour l'installation de l'agent. (Par défaut:
C:\\Program Files\\FusionInventory-Agent)

*pathname* doit être un chemin absolu.

À faire

**/installtasks**={*task*[,*task*[...]]|*macro*}

Sélectionne des tâches à installer. (Par défaut: **Default**)

*task* peut avoir une des valeurs suivantes:

* **Deploy**: Tâche de Déploiement

* **ESX**: Tâche ESX

* **Inventory**: Tâche Inventaire

* **NetDiscovery**: Tâche NetDiscovery

* **NetInventory**: Tâche NetInventory

* **WakeOnLan**: Tâche WakeOnLan

Il y a trois macros pré-définies pour simplifier l'installation :

* **Minimal**: **Inventory**

* **Default**: **Inventory**

* **Full**:
**Deploy**,**ESX**,**Inventory**,**NetDiscovery**,**NetInventory**,**WakeOnLan**

Il convient de noter que la tâche **Inventory** sera toujours installé
et que les tâches **NetDiscovery** et **NetInventory** sont
inter-dépendantes. Actuellement, **Minimal** et **Default** sont
identiques.

**/installtype**={**from-scratch**|**from-current-config**}

Sélectionne entre une installation à partir de zéro (**from-scratch**)
ou, une configuration de l'agent suivant l'installation précédente sur
votre système (**from-current-config**). (Par défaut:
**from-current-config**)

L'installation commutera automatiquement de **from-current-config** à
**from-scratch** si la détection, sur votre système, d'une version
précédente de FusionInventory Agent échoue. Ce test rend inutile de
préciser **/installtype**=**from-scratch** pour installer
FusionInventory Agent sur des systèmes n'ayant pas d'agent installé,
tout en facilitant la mise à jour de système ayant déjà FusionInventory
Agent d'installé avec une seule procédure commune.

**/local**=*pathname*

Écrit les résultats de l'exécution des tâches dans le dossier donné.
(Par défaut: "")

Vous devez donner un chemin absolu ou une chaîne vide (""). Si vous
utilisez une chaîne vide, le résultat de l'exécution de la tâche ne
pourra pas être écrit localement.

Vous pouvez utiliser les options **/local** et **/server**
simultanément.

**/logfile**=*filename*

Écrit les messages de log dans le fichier *filename*. (Par défaut:
C:\\Program Files\\FusionInventory-Agent\\fusioninventory-agent.log)

Vous devez indiquer le chemin complet dans *filename*. L'option
**/local** est utilisable seulement si vous donnez aussi la valeur
**File** à l'option **/logger**.

**/logfile-maxsize**=*size*

Définit la taille maximum du fichier de log (voir **/logfile**) a *size*
. (Par défaut: 16 MBytes)

**/logger**=*backend*[,*backend*]

Définit le type de sortie pour logger. (Par défaut: File)

*backend* peut avoir une des valeurs suivantes:

* **File**: Envoie les messages de log vers un fichier (voir **/logfile**)

* **Stderr**: Envoie les messages de log vers la console

**/no-category**=*category*[,*category*[...]]

Ne pas inventorier les éléments des catégories indiquées. (Par défaut:
"")

*category* peut avoir une des valeurs suivantes:

* **Environment**: variables d'Environnement

* **Printer**: Imprimante

* **Process**: Processus système (n'a aucun effet sur les systèmes
Microsoft Windows)

* **Software**: Logiciel

* **User**: Utilisateurs

Si vous indiquez une chaîne vide (""), toutes les éléments des
catégories seront inventoriés.

**/no-html**

Cette option est l'opposée de **/html**. Voir **/html** pour plus
d'information.

**/no-httpd**

Désactive le serveur web intégré . (Par défaut: Non)

**/no-p2p**

Ne pas utiliser le P2P pour télécharger les fichiers. (Par défaut: Non)

**/no-scan-homedirs**

Cette option est l'opposée de **/scan-homedirs**. Voir
**/scan-homedirs** pour plus d'information.

**/no-ssl-check**

Ne pas vérifier le certificat du serveur. (Par défaut: Non)

**/no-start-menu**

Ne pas créer le dossier *FusionInventory Agent* dans le Menu Démarrer.
(Par défaut: Non)

Le dossier *FusionInventory Agent* , s'il est créé, est pour tous les
utilisateurs.

**/no-task**=*task*[,*task*[...]]

Désactive les tâches indiquées. (Par défaut: "")

*task* peut avoir une des valeurs suivantes:

* **Deploy**: Tâche de Déploiement

* **ESX**: Tâche ESX

* **Inventory**: Tâche d'Inventaire

* **NetDiscovery**: Tâche NetDiscovery

* **NetInventory**: Tâche NetInventory

* **WakeOnLan**: Tâche WakeOnLan

Si vous indiquez une chaîne vide (""), toutes les tâches seront
exécutées.

**/p2p**

Cette option est l'opposée de **/no-p2p**. Voir **/no-p2p** pour plus
d'information.

**/password**=*password*

Utilise *password* comme mot de passe pour l'authentification serveur.
(Par défaut: "")

L'option **/password** est utilisée seulement si vous avez aussi donné
une valeur à l'option **/server** .

**/proxy**=*URI*

Utilise *URI* comme serveur proxy HTTP/S. (Par défaut: "")

**/runnow**

Lance l'agent immédiatement après l'installation. (Par défaut: Non)

**/S**

Installation silencieuse. (Par défaut: Non)

Vous devez accepter clairement la licence (voir **/acceptlicense**)  si
vous désirez installer en mode silencieux.

**/scan-homedirs**

Autorise l'agent à scanner les dossiers utilisateurs pour trouver les
machines virtuelles. (Par défaut: Non)

**/server**=*URI*[,*URI*[...]]

Envoie les résultats de l'exécution des tâches aux serveurs donnés. (Par
défaut: "")

Si vous indiquez une chaîne vide (""), le résultat de l'exécution des
tâches ne pourra pas être envoyé.

Vous pouvez utiliser les options **/server** et **/local**
simultanément.

**/ssl-check**

Cette option est l'opposée de **/no-ssl-check**. Voir **/no-ssl-check**
pour plus d'information.

**/start-menu**

Cette option est l'opposée de **/no-start-menu**. Voir
**/no-start-menu** pour plus d'information.

**/tag**=*tag*

Marque l'ordinateur avec le tag *tag* . (Par défaut: "")

**/task-daily-modifier**=*modifier*

Modification du cycle de tâche en jour. (Par défaut: 1 jour)

*modifier* peut prendre une valeur entre 1 et 30, elles-même incluses.

L'option **/task-daily-modifier** est utilisée seulement si vous avez
aussi donné  **Daily** comme valeur à l'option **/task-frequency**.

**/task-frequency**=*frequency*

Fréquence pour le gestionnaire de tâche. (Par défaut: **Hourly**)

*frequency* peut avoir une des valeurs suivantes:

* **Minute**: Intervalles en minute (Voir option
**/task-minute-modifier**)

* **Hourly**: Intervalles en heure (voir option **/task-hourly-modifier**)

* **Daily**: Intervalles en jour (voir option **/task-daily-modifier**)

**/task-hourly-modifier**=*modifier*

Modification du cycle de tâche en heure. (Par défaut: 1 heure)

*modifier* peut prendre une valeur entre 1 et 23, elles-mêmes incluses.

L'option **/task-hourly-modifier** est utilisée seulement si vous avez
aussi donné **Hourly** comme valeur à l'option **/task-frequency**.

**/task-minute-modifier**=*modifier*

Modification du cycle de tâche en minute. (Par défaut: 15 minutes)

*modifier* peut avoir comme valeur : 15, 20 ou 30.

L'option **/task-minute-modifier** est utilisée seulement si vous avez
aussi donné **Minute** comme valeur à l'option **/task-frequency** .

**/timeout**=*timeout*

Définit le temps limite (en seconde) de connexion avec le serveur. (Par
défaut: 180 secondes)

L'option **/timeout** est utilisée seulement si vous avez indiqué une
valeur à l'option **/server** .

**/user**=*user*

Utilise *user* comme utilisateur pour l'authentification avec le
serveur. (Par défaut: "")

L'option **/user** est utilisée seulement si vous avez indiqué une
valeur à l'option **/server** .

**EXEMPLES**

À faire

**VERSION**

Cette aide est pour la version 2.2.9903 de l'installeur  FusionInventory
Agent pour Microsoft Windows.

**REPORT DE BUGS**

Liste de diffusion des utilisateurs

* http://lists.alioth.debian.org/mailman/listinfo/fusioninventory-user

Liste de diffusion des développeurs

* http://lists.alioth.debian.org/mailman/listinfo/fusioninventory-devel

Gestion du Projet

* http://forge.fusioninventory.org/projects/fusioninventory-agent-windows-installer

**COPYRIGHT**

Copyright 2012-2013 FusionInventory Team. GNU GPL version 2 ou (suivant
votre option) toute version ultérieure
\<http://www.gnu.org/licenses/old-licenses/gpl-2.0-standalone.html\>.
Ceci est un logiciel libre: vous êtes libre de le modifier et le
redistribuer. Il n'y a AUCUNE GARANTIE dans la limite autorisée par la
loi.

**VOIR AUSSI**

Site Web FusionInventory 

* http://www.fusioninventory.org/

**AUTEUR**

Tomás Abad \<tabadgp@gmail.com\>

----

[[!template id=info text="""You can download the PDF version of this document [here](http://forge.fusioninventory.org/projects/fusioninventory-agent-windows-installer/files "http://forge.fusioninventory.org/projects/fusioninventory-agent-windows-installer/files")."""]]
