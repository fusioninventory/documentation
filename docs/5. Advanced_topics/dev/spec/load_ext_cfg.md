---
layout: single
title: Spec for load configuration from external place
---

# Load configuration from external place

## Backend specific keys in agent.cfg

    # LDAP information
    ldap_uri = ldap://mcmic:389
    ldap_base = dc=mcmic,dc=test
    ldap_bind_dn = cn=admin,dc=mcmic,dc=test
    ldap_bind_pwd = secret
    ldap_ip = 192.168.1.52

* Pros
    * ability to add new specific key easily
* Cons
    * Not generic at all

## Ext config in agent.cfg

Normalize config as : uri, login, password, and meta (which can be anything the backend needs)

As flat configuration keys

    ext_config = https://example.net/config.cfg
    ext_config_login = anonymous
    ext_config_password = anonymous
    ext_config_meta = something

As a INI configuration section

    [ext_config]
    uri = https://example.net/config.cfg
    login = anonymous
    password = anonymous
    meta = something

* Pros
    * We could add a section for each config backend and at the beginning add a config=backend which would allow to keep several configuration and switch between them.

## External configuration file

In this case we can use any var names in the external file

    ext_config=ldap
    ext_config_file=/etc/fusioninventory/ldap.cfg

* Pros
    * Different configurations are isolated in files
* Cons
    * Still introduce some new specific keys

Gonéri : Unrelated, but it may be interesting to introduce an `include=somefile.cfg` directive.

## Per conf backend (à la OTRS)

INI section are not used so far, we can introduce section name
based on a class name.

    [Config::LDAP-1]
    whatever=value
    keyFoo=bar

* Pros
    * Clean what so isolat specific values
* Cons
    * hardly compatible with CLI
