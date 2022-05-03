# Standalone server

Standalone server


** Specs server fusioninventory standalone **

 * API REST renvoyant un tableau au format json
   # Exemple de requete API REST :
     + toutes les VM
     + tous les ordinateurs du lieu xxxxyy
     + toutes les adresses MAC
     + l'ordinateur zzz (il renvoi toutes les infos)
     + l'ordinateur zzz avec les champs nom, serial number, uuid
   Donc si on ne précise pas les infos à ramener, il renvoi toutes les infos, sinon il renvoi les champs spécifiés

 * Pouvoir utiliser elasticsearch via l'API REST



* Mise à jour inventaire ordinateur

Agent ---XML----> Server ---convert in JSON ----> (storage + elasticsearch) OR (only elasticsearch)

Agent ---JSON---> Server ---------------------------^


* API REST


Request --------> convert into elasticsearch query ---> get values ---> return JSON

ou alors

Request elasticsearch -> return JSON
 

* Inventaire réseau

Query API REST sur tel ou tel switch (ou via une restriction telle que ip commence par), l'agent qui doit faire l'inventaire
 ou alors un API REST qui va créer une tache.

* storage

Si on utilise un storage, quoi choisir

  * base de donnée NoSQL

Pour :

Contre :


  * base de donnée type GRAPH. 

Pour :
 * Les données sont liées les unes aux autres, donc ça ne parait pas trop bête

Contre :
