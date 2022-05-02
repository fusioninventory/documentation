---
layout: single
title: Mini code camp (2014-03-14)
---

# Attendees

* Gonéri Le Bouder
* David Durieux
* Guillaume Rousse
* Kevin Roy

# Discussion topics

## Network discovery and inventory

The agent is now able to use its own database for device identification in a
reliable matter, using SysObjectID, and to retrieve most information from
device out of the box, using default values and various heuristics.

There is still room for improvements:

* parameters setting on server side (timeout, credentials, etc...)
* SNMP models and dictionary deprecation
* hardware support database

## Rest API : Communication Mayhem

Actually, the API is a place with 6 participants talking a different
language and communicating with the server in so different ways:

* Deploy : complete communication steps but a little messy which
  require a lot of customized parsing.
* ESX : one getJobs at the beginning and one setLog at the end
* Collect : no setLog at all and a setAnswer which is not commonly
  used by the other modules.

## Rest API : Definition of task, job

A task does not share the same meaning between the plugin and the agent.

A job does not seem to have the same definition across every modules.
Especially when it’s about unique id (UUID) of a Task(agent).

* a deploy task has a unique id per jobs.
* a netdiscovery task has one unique id and the jobs share those
  unique id.

It’s more a specification understanding issue on the server side but i’m
not sure the agent is affected too.

If we should migrate the others XML talking tasks, we first need to tidy
up the basic way every modules should communicate with the server.

## FusionInventory Plugin : Continuous Integration

* Plugin unit tests have been slightly rewritten to use a shared
  initialization class.
* Travis is up now (with failures instead of initialization errors).

## FusionInventory Server : Standard Inventory Server

* PythonEve (RestAPI for lazy people)
* ElasticSearch (scalable nosql database)
* Flask

## Avahi/MDNS/ZeroConf

## Releases & Roadmaps

* FusionInventory Agent 2.4.x
* FusionInventory GLPI Plugin 0.85+1.0
* FusionInventory Server (if acknowledged)




# Debriefing

===== modéles SNMP =====

Modifier page pour création des modeles pour dire envoyer snmpwalk sur une
adresse mail (genre walk@fusioninventory.org) et expliquant qu'on ne publie
que les résultat et pas les donnnées des walks.
Indiquer le niveau de support.

===== identification des matériels  =====

On utilise le sysobjectid.
Le dictionnaire devient souvent obsolète dans le serveur, donc a voir comment on continu avec ça.

===== modeles et disctionnaire =====
Distribuer les données (fichiers ids pour les sysobjectid) séparement du code.
Mettre en place les données sur le serveur, et faire en sort que les agents se synchronisent automatiquement (il y a déjà un ticket a jour). Utiliser un numéro de version plutôt qu'un hash pour voir si l'agent et le serveur sont a jour avec les données.

===== Découverte =====

Utilisation désormais d'un champ `timeout`

===== authentitication =====

Ajouter dans les plage ip, la liste des authentification SNMP à utiliser (+ ordre)
C'est purement de l'optimisation

===== découverte réseau =====

Guillaume doit faire un ticket avec la liste des champs supplémentaires remontées.


===== matériel inconnu =====

Peut être renommé, en matériel `non intégré`

== Roadmap 2.4

1. Deploy

2. plus de tests d'utilisation et retours d'utilisateurs (phase beta test)

===== Communication REST =====

Uniformiser les méthodes REST (bordelique dans deploy, OK dans ESX).
Faire des specs. engeulade entre Goneri et Kiniou, (cette semaine c'était entre kiniou et david, ca change :p), ok kiniou WIN again!

===== Renommage =====

Au niveau de l'agent, renommer tache en module

Au niveau du serveur, renommer taches en jeu d'executions


