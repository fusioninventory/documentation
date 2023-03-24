# Security

## Security concerns

The following presents multiple security-related topics.

### Agent authentication on server side

The server automatically trust any received message, using the identifier found
in the message (unfortunatly called DEVICEID) to identify the sending agent. An
attacker may then inject data, either to masquerade legitimate data, or just to
fill GLPI database and trigger a denial of service.

In order to protect against this threat, access to the actual fusioninventory
plugin URL should be protected, using any access control mechanism from the web
server. For instance, source address restriction on an Apache server 2.4.x:

``` apacheconf
<Location /plugins/fusioninventory>
# only accept requests from trusted network
Require ip 192.168.0.0/24
</Location>
```

Unfortunatly, there is no way to safely distinguish an HTTP request from a
regular user accessing plugin content through a browser, such as images or
javascript, from a fusioninventory agent retrieving its tasks list or posting a
task execution result. Using HTTP User Agent will only protect against errors,
as its value is set by the client:

``` apacheconf
<Location /plugins/fusioninventory>
<If "%{HTTP_USER_AGENT} =~ /^FusionInventory-Agent_v/">
    # only accept agent requests from trusted network
    Require ip 192.168.0.0/24
</If>
</Location>
```

Until an actual solution is implemented, the best workaround currently
is to restrict access for POST queries only, as this will prevent
data injection, without affecting regular usage:

``` apacheconf
<Location /plugins/fusioninventory>
<Limit POST>
    # only accept agent execution results from trusted network
    Require ip 192.168.0.0/24
</Limit>
</Location>
```

### Arbitrary command execution on agent side

Some tasks are explicitely designed to make the agent execute arbitrary
commands on its host. For instance, the Deploy task is used to install
software on agent side.

If you don't have any interest for those tasks, for instance because you're
only using local inventory, you'd rather run the agent in a mode where the
server doesn't control what tasks the agent executes, as detailed on [usage
page](agent/usage). Or even better, only install the tasks you are interested
in, and not the other, which is highly dependant on your installation method.

And if you have an interest for this kind of tasks, you should use TLS to
ensure proper server authentication, unless agent-server communication only
occurs on a trusted network where host spoofing is considered impossible,

### Agent-server exchange confidentiality

Some messages between agent and server may contain sensible informations. The
agent may use a password to authenticate on the server, for instance. Or the
server may send SNMP credentials to the agent in order to perform a remote inventory.

Unless agent-server communication only occurs on a trusted network where traffic eavesdropping
is considered impossible, you should use TLS to protect exchange
confidentiality.

## TLS usage

### Server setup

TLS support on server side is done by the web server, typically using Apache
mod_ssl module.

If you can't get trusted TLS certificates from regular Certification Authority,
the following command generates a key and a self-signed certificate, valid for
two years:

``` shell
$> openssl req -new -newkey rsa:2048 -days 730 -nodes -x509 -keyout server.key -out server.crt -subj "/CN=glpi.mycompany.com"
Generating a 1024 bit RSA private key
......++++++
...............++++++
writing new private key to 'server.key'
-----
```

!!! warning
    You have to ensure the exact host name in your server URL matches the certificate Common Name attribute. For instance, if your server URL is http(s)://glpi.mycompany.com/, the common name should be 'glpi.mycompany.com'.


The key, in server.key file, is the private part allowing the server to prove
its identity. It should not be distributed, and be correctly protected. The
certificate, in server.crt file, is the public part allowing other piece of
software to check the server identity, and can be freely distributed.

Both files have to be installed on the server host, and the web server should
be configured to use them. For instance, on Apache with mod_ssl:

``` apacheconf
SSLEngineOn
SSLCertificateFile /etc/pki/tls/certs/server.crt
SSLCertificateKeyFile /etc/pki/tls/private/server.key
```

The certificate file also has to be installed on each agent host, and the agent
should be configured to use it as the Certification Authority certificate.

### Agent setup

TLS support on agent side relies on LWP (also known as libwww-perl), the
standard Perl library for HTTP communication. This library is able to use
either Crypt::SSLeay or IO::Socket::SSL perl modules transparently for HTTPS
support. However, only the second one is able to perform server certificate
validation. As a consequence, the agent will refuse to use HTTPS, and exit
immediatly if IO::Socket::SSL is not available, unless certificate checking has
been explicitely disabled, through *no-ssl-check* [configuration parameter](FusionInventory_agent/configuration/configuration.md) (or alternatively, *--no-ssl-check* [command line option](FusionInventory_agent/manpage/agent.cfg.md)).

The Certification Authority (CA) certificate of the webserver is to be used.
The CA certificate must be installed on each agent host.
The agent should be configured to use it as certification authority, with
*ca-cert-file* [configuration parameter](FusionInventory_agent/configuration/configuration.md) (or alternatively,
*--ca-cert-dir* [command line option](FusionInventory_agent/manpage/agent.cfg.md)).

It is recommended to use *ca-cert-file* for using a Certification Authority certificate. The
certificate should be stored as a \*.pem file.

In the case you use a certificate chain with more than one CA. You have to keep the chain in one \*.pem file.

    --- BEGIN Certificate ---
    (Your Sub-CA-Certificate as base64 encrypted)
    --- END Certificate ---
    --- BEGIN Certificate ---
    (Your Root-CA-Certificate as base64 encrypted)
    --- END Certificate ---" %}

