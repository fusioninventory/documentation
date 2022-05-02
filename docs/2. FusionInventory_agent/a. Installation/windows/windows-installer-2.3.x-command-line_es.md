---
layout: single
title: Windows installer 2.3.x command-line
---

[[!template id=info text="La siguiente información ha sido obtenida de *fusioninventory-agent\_windows-x64\_2.3.2.exe*, el instalador para arquitecturas x64, pero es además válida para *fusioninventory-agent\_windows-x86\_2.3.2.exe*, el instalador para architecturas x86.."]]

**NOMBRE**

**fusioninventory-agent\_windows-x64\_2.3.2.exe** -- FusionInventory
Agent 2.3.2 (x64 edition) Setup

**SINOPSIS**

**fusioninventory-agent\_windows-x64\_2.3.2.exe** [*/Opción*[ */Opción*[
...]]]

**DESCRIPCIÓN**

**fusioninventory-agent\_windows-x64\_2.3.2.exe** instala
FusionInventory Agent 2.3.2 en su sistema operativo Microsoft Windows.

**fusioninventory-agent\_windows-x64\_2.3.2.exe** dispone de dos tipos
de instalación; el tipo **from-scratch**, que permite realizar una
instalación de FusionInventory Agent desde cero, basada en los valores
por defecto de las opciones (ver abajo), y el tipo
**from-current-config**, que permite realizar una instalación basada en
el valor de las opciones del FusionInventory Agent previamente instalado
en el sistema, si existe (ver **/installtype**). (Tenga en cuenta que,
con independencia del tipo de instalación que elija, cualquier versión
existente de FusionInventory Agent será desinstalada automáticamente
inmediatamente antes de instalar FusionInventory Agent 2.3.2)

**fusioninventory-agent\_windows-x64\_2.3.2.exe** dispone también de dos
modos de instalación; el *modo silencioso* (ver **/S**), que permite
realizar la instalación de FusionInventory Agent de un modo
no-interactivo o desatendido, y el *modo visual*, que permite realizar
la instalación de FusionInventory Agent de un modo gráfico e
interactivo.

**fusioninventory-agent\_windows-x64\_2.3.2.exe** cuenta con una serie
de opciones (ver abajo) que permite adaptar la instalación a
prácticamente cualquier entorno o necesidad. Para emplear estas opciones
adecuadamente es esencial conocer el orden en que los valores son
tomados en cuenta. Ese orden es el siguiente (a mayor número, mayor
prioridad).

0. Valores por defecto

1. Valores del actual FusionInventory Agent (solo en instalaciones de
tipo **from-current-config**)

2. Valores de la línea de comandos

3. Valores de la interfaz gráfica de usuario (solo en instalaciones en
*modo gráfico*)

Debería tener en cuenta lo siguiente cuando use la línea de comandos:

* Existen dos tipos de opciones; aquellas que actuan como un conmutador
(*/opción*), y aquellas que tienen un valor (*/opción=valor*).

* El nombre de las opciones es sensible a mayúsculas y minúsculas
(*/html* no es lo mismo que */HTML*).

* El valor de las opciones, a menos que se indique lo contrario, no es
sensible a mayúsculas y minúsculas (*/local=C:\\Temp* es lo mismo que
*/local=c:\\temp*).

* En las opciones que tienen un valor,

  - no debería haber ninguna separación alrededor del signo igual (*/local
= c:\\temp* es incorrecto).

  - si el valor contiene un espacio o el carácter (/), debería ir entre
comillas simples (') o dobles (") (*/local='C:\\FusionInventory
Agent'*).

  - si quiere establecer un valor vacío, debe indicar una cadena vacía
(*/local=''*).

Estas son las opciones disponibles de la línea de comandos:

**/acceptlicense**

Acepta y reconoce que ha leído y entendido los términos y condiciones de
la licencia de FusionInventory Agent 2.3.2. (Por defecto: No)

Debe usar esta opción si realiza la instalación en modo silencioso (ver
**/S**).

Si indica esta opción en la línea de comandos, pero no la opción **/S**,
la instalación en *modo visual* omitirá cualquier pregunta acerca de la
licencia.

**/add-firewall-exception**

Añade FusionInventory Agent a la lista de excepciones del *Firewall* de
Windows. (Por defecto: No)

Por hacer

**/backend-collect-timeout**=*timeout*

Tiempo límite para la ejecución de los módulos de la tarea
**Inventory**. (Por defecto: 180 segundos)

**/ca-cert-dir**=*pathname*

Ruta absoluta del directorio de certificados estándar de autoridades de
certificación (CA). (Por defecto: "")

El uso de esta opción es incompatible con el uso de la opción
**/ca-cert-file**. Las opciones **/ca-cert-dir** y **/ca-cert-file** son
mutuamente excluyentes.

Un *directorio de certificados estándar* debe contener los ficheros
correspondientes a los certificados de las distintas autoridades de
certificación en formato *Privacy Enhanced Mail* (PEM), y sus nombres
deben corresponder al valor *hash* del campo *subject* del certificado,
con extensión *\*.0*.

Por ejemplo, si desea incluir el fichero de certificado
*FICert\_Class1.crt* en el directorio *pathname*, debe calcular el valor
*hash* del campo *subject* del certificado haciendo uso de, por ejemplo,
OpenSSL

    C:\OpenSSL> openssl.exe x509 -in C:\FICert_Class1.crt -subject_hash -noout
    b760f1ce

y después, mover o copiar el fichero de certificado al directorio
*pathname* con el nombre *b760f1ce.0*.

    C:\OpenSSL> move.exe C:\FICert_Class1.crt *pathname*\b760f1ce.0

**/ca-cert-file**=*filename*

Ruta completa al fichero de certificados de autoridades de certificación
(CA). (Por defecto: "")

El uso de esta opción es incompatible con el uso de la opción
**/ca-cert-dir**. Las opciones **/ca-cert-dir** y **/ca-cert-file** son
mutuamente excluyentes.

*filename* debe tener extensión *\*.pem* (Privacy Enhanced Mail) y puede
contener uno o varios certificados de autoridades de certificación. Para
concatener varios ficheros de certificado en un solo fichero puede hacer
uso, por ejemplo, del comando *copy*.

    C:\> copy.exe FICert_Class1.crt+FICert_Class2.crt FICerts.pem

**/ca-cert-uri**=*URI*

*URI* de donde obtener el archivo o archivos de autoridades de
certificación (CA). (Por defecto: "")

El uso de esta opción requiere del uso conjunto de las opciones
**/ca-cert-dir** o **/ca-cert-file**, pero no de ambas.

Por hacer

**/debug**=*level*

Establece el nivel de depuración del agente. (Por defecto: 0)

*level* puede ser cualquiera de los siguientes valores:

* **0**: Sin depuración

* **1**: Depuración normal

* **2**: Depuración completa

**/delaytime**=*limit*

Establece una demora inicial antes de primer contacto con un destino
remoto (ver **/server**). Esta demora se calcula al azar entre *limit/2*
y *limit* segundos. (Por defecto: 3600 segundos)

Esta opción se omite para los destinos remotos después del primer
contacto con cada uno, en favor del parámetro específico del servidor
(PROLOG\_FREQ).

La opción **/delaytime** entra en juego únicamente si FusionInventory
Agent se ejecuta en *modo servidor* (ver **/execmode**).

**/dumphelp**

Ver **/help**.

**/execmode**=*mode*

Establece el modo de ejecución del agente. (Por defecto: **Current**)

*mode* puede ser cualquiera de los siguientes valores:

* **Service**: El agente se ejecuta como un Servicio Windows (siempre en
ejecución)

* **Task**: El agente se ejecuta como una Tarea Windows (ejecución a
intervalos)

* **Manual**: El agente no se ejecuta automáticamente (ni **Service**, ni
**Task**)

* **Current**: El agente se ejecuta del mismo modo que se ejecuta el
agente ya instalado

El modo **Service** es conocido también como *modo servidor*.

El modo **Task** solo está disponible en sistemas operativos Windows XP
(o superior) y Windows Server 2003 (o superior).

En el caso de una instalación **from-scratch** (ver **/installtype**),
el modo **Current** es un sinónimo de **Service**.

**/help**

Esta ayuda. Si la opción **/help** está presente, muestra la ayuda y
aborta la instalación.

Podría preferir hacer uso de la opción **/dumphelp** en su lugar de la
opción **/help** para obtener información. La opción **/dumphelp** crea
un archivo RTF con esta ayuda y aborta la instalación.

**/html**

Graba el inventario como HTML en lugar de XML. (Por defecto: No)

La opción **/html** entra en juego únicamente si se ha indicado también
un valor para la opción **/local**.

**/httpd**

Esta opción es la opuesta a **/no-httpd**. Ver **/no-httpd** para más
información.

**/httpd-ip**=*ip*

Dirección IP por la que el servidor web integrado debería escuchar. (Por
defecto: 0.0.0.0)

**/httpd-port**=*port*

Puerto IP por el que el servidor web integrado debería escuchar. (Por
defecto: 62354)

**/httpd-trust**={*ip*|*range*|*hostname*}[,{*ip*|*range*|*hostname*}[...]]

Direcciones IP de confianza que no requieren distintivo de autenticación
por el servidor web integrado. (Por defecto: 127.0.0.1/32)

*ip* es una dirección IP en notación decimal con puntos (ej.
"127.0.0.1") o en notación CIDR (ej. "127.0.0.1/32")

*range* es un rango de direcciones IP en notación decimal con puntos
(ej. "192.168.0.0 - 192.168.0.255" o "192.168.0.0 + 255") o en notación
CIDR (ej. "192.168.0.0/24")

*hostname* es el nombre de un *host* (ej. "itms.acme.org")

Tenga en cuenta que **/httpd-trust** no tiene que incluir la parte
*hostname* de aquellas URI que están establecidas en **/server** porque
están tácitamente incluidas. Lo siguiente es un ejemplo; ambas
configuraciones son iguales.

    /httpd-trust="127.0.0.1/32,itms.acme.org"
    /server="http://itms.acme.org/glpi/plugins/fusioninventory/"
    
    ----
    
    /httpd-trust="127.0.0.1/32"
    /server="http://itms.acme.org/glpi/plugins/fusioninventory/"

**/installdir**=*pathname*

Establece el directorio base de instalación del agente. (Por defecto:
C:\\Program Files\\FusionInventory-Agent)

*pathname* debe ser una ruta absoluta.

Por hacer

**/installtasks**={*task*[,*task*[...]]|*macro*}

Selecciona las tareas a instalar. (Por defecto: **Default**)

*task* puede ser cualquiera de los siguientes valores:

* **Deploy**: Tarea Deploy

* **ESX**: Tarea ESX

* **Inventory**: Tarea Inventory

* **NetDiscovery**: Tarea NetDiscovery

* **NetInventory**: Tarea NetInventory

* **WakeOnLan**: Tarea WakeOnLan

Existen tres macros definidas para simplificar el cometido, son las
siguientes:

* **Minimal**: **Inventory**

* **Default**: **Inventory**

* **Full**:
**Deploy**,**ESX**,**Inventory**,**NetDiscovery**,**NetInventory**,**WakeOnLan**

Es necesario notar que la tarea **Inventory será siempre instalada y que
las tareas NetDiscovery y NetInventory son interdependientes. A día de
hoy Minimal** y **Default** son la misma configuración.

**/installtype**={**from-scratch**|**from-current-config**}

Selecciona entre una instalación desde cero (**from-scratch**) o, si el
sistema tiene un agente previamente instalado, una instalación basada en
la configuración actual (**from-current-config**). (Por defecto:
**from-current-config**)

El instalador cambia automáticamente de **from-current-config** a
**from-scratch** si no es capaz de detectar un agente instalado
previamente en el sistema. Este comportamiento hace innecesario tener
que indicar **/installtype**=**from-scratch** para realizar una
instalación de FusionInventory Agent en aquellos sistemas en los que no
existe con anterioridad y, al mismo tiempo, facilita la actualización de
FusionInventory Agent en aquellos sistemas en los que existe.

**/local**=*pathname*

Escribe los resultados de la ejecución de las tareas en el directorio
indicado. (Por defecto: "")

Debe indicar un nombre de ruta absoluta o una cadena vacia (""). Si
indica una cadena vacía, los resultados de la ejecución de las tareas no
se escribirán localmente.

Puede emplear las opciones **/local** y **/server** simultáneamente.

**/logfile**=*filename*

Escribe los mensajes de registro en el archivo *filename*. (Por defecto:
C:\\Program Files\\FusionInventory-Agent\\fusioninventory-agent.log)

Debe indicar una ruta completa en *filename*. The opción **/local**
entra en juego únicamente si ha indicado también **File** como un valor
de la opción **/logger**.

**/logfile-maxsize**=*size*

Establece el tamaño máximo del fichero de registro (ver **/logfile**) a
*size* .  (Por defecto: 16 MBytes)

**/logger**=*backend*[,*backend*]

Establece los almacenes de los registros. (Por defecto: File)

*backend* puede ser cualquiera de los siguientes valores:

* **File**: Envía los mensajes de registro a un fichero (ver **/logfile**)

* **Stderr**: Envía los mensajes de registro a la consola

**/no-category**=*category*[,*category*[...]]

No realizar inventario de las categorías de elementos indicadas. (Por
defecto: "")

*category* puede ser cualquiera de los siguientes valores:

* **Environment**: Variables de entorno

* **Printer**: Impresoras

* **Process**: Procesos del sistema (no tiene efecto en sistemas Microsoft
Windows)

* **Software**: *Software*

* **User**: Usuarios

Si indica una cadena vacía (""), todas las categorías de elementos serán
inventariadas.

**/no-html**

Esta opción es la opuesta a **/html**. Ver **/html** para más
información.

**/no-httpd**

Desactiva el servidor web integrado. (Por defecto: No)

**/no-p2p**

No emplear *peer to peer* para descargar archivos. (Por defecto: No)

**/no-scan-homedirs**

Esta opción es la opuesta a **/scan-homedirs**. Ver **/scan-homedirs**
para más información.

**/no-ssl-check**

No comprobar el certificado del servidor. (Por defecto: No)

**/no-start-menu**

No crear la carpeta *FusionInventory Agent* en el Menú de Inicio. (Por
defecto: No)

La carpeta *FusionInventory Agent*, si es creada, lo es para todos los
usuarios.

**/no-task**=*task*[,*task*[...]]

Desactiva las tareas indicadas. (Por defecto: "")

*task* puede ser cualquiera de los siguientes valores:

* **Deploy**: Tarea Deploy

* **ESX**: Tarea ESX

* **Inventory**: Tarea Inventory

* **NetDiscovery**: Tarea NetDiscovery

* **NetInventory**: Tarea NetInventory

* **WakeOnLan**: Tarea WakeOnLan

Si indica una cadena vacía (""), todas las tareas serán ejecutadas.

**/p2p**

Esta opción es la opuesta a **/no-p2p**. Ver **/no-p2p** para más
información.

**/password**=*password*

Emplea *password* como palabra de paso en la autenticación con el
servidor. (Por defecto: "")

La opción **/password** entra en juego únicamente si se ha indicado
también un valor para la opción **/server**.

**/proxy**=*URI*

Emplea *URI* como servidor *proxy* HTTP/S. (Por defecto: "")

**/runnow**

Lanza el agente inmediatamente después de su instalación. (Por defecto:
No)

**/S**

Instalación silenciosa. (Por defecto: No)

Debe aceptar la licencia de modo explícito (ver **/acceptlicense**) si
realiza la instalación en modo silencioso.

**/scan-homedirs**

Permite al agente buscar máquinas virtuales en los directorios *home*.
(Por defecto: No)

**/server**=*URI*[,*URI*[...]]

Envia los resultados de la ejecución de las tareas a los servidores
indicados. (Por defecto: "")

Si indica una cadena vacía (""), los resultados de la ejecución de las
tareas no se escribirán remotamente.

Puede emplear las opciones **/server** y **/local** simultáneamente.

**/ssl-check**

Esta opción es la opuesta a **/no-ssl-check**. Ver **/no-ssl-check**
para más información.

**/start-menu**

Esta opción es la opuesta a **/no-start-menu**. Ver **/no-start-menu**
para más información.

**/tag**=*tag*

Marca el ordenador con la etiqueta *tag* . (Por defecto: "")

**/task-daily-modifier**=*modifier*

Modificador de planificador de tareas diario. (Por defecto: 1 día)

*modifier* puede tomar valores entre 1 y 30, ambos incluidos.

La opción **/task-daily-modifier** entra en juego únicamente si ha
indicado también **Daily** como valor de la opción **/task-frequency**.

**/task-frequency**=*frequency*

Frecuencia para el planificador de tareas. (Por defecto: **Hourly**)

*frequency* puede ser cualquiera de los siguientes valores:

* **Minute**: En intervalos de minuto (ver opción
**/task-minute-modifier**)

* **Hourly**: En intervalos de hora (ver opción **/task-hourly-modifier**)

* **Daily**: En intervalos de día (ver opción **/task-daily-modifier**)

**/task-hourly-modifier**=*modifier*

Modificador de planificador de tareas horario. (Por defecto: 1 hora)

*modifier* puede tomar valores entre 1 y 23, ambos incluidos.

La opción **/task-hourly-modifier** entra en juego únicamente si ha
indicado también **Hourly** como valor de la opción **/task-frequency**.

**/task-minute-modifier**=*modifier*

Modificador de planificador de tareas por minutos. (Por defecto: 15
minutos)

*modifier* puede tomar los siguientes valores: 15, 20 ó 30.

La opción **/task-minute-modifier** entra en juego únicamente si ha
indicado también **Minute** como valor de la opción **/task-frequency**.

**/timeout**=*timeout*

Establece el tiempo límite (en segundos) para conectar con el servidor.
(Por defecto: 180 segundos)

La opción **/timeout** entra en juego únicamente si se ha indicado
también un valor para la opción **/server**.

**/user**=*user*

Emplea *user* como usuario en la autenticación con el servidor. (Por
defecto: "")

La opción **/user** entra en juego únicamente si se ha indicado también
un valor para la opción **/server**.

**EJEMPLOS**

Por hacer

**VERSIÓN**

Esta ayuda está actualizada para la versión 2.2.9903 del instalador para
Microsoft Windows de FusionInventory Agent

**INFORME DE ERRORES**

Lista de Correo de Usuarios

* http://lists.alioth.debian.org/mailman/listinfo/fusioninventory-user

Lista de Correo de Desarrollo

* http://lists.alioth.debian.org/mailman/listinfo/fusioninventory-devel

Gestor del Proyecto

* http://forge.fusioninventory.org/projects/fusioninventory-agent-windows-installer

**COPYRIGHT**

Copyright 2012-2013 FusionInventory Team. GNU GPL versión 2 o (en su
opinión) cualquier versión posterior
\<http://www.gnu.org/licenses/old-licenses/gpl-2.0-standalone.html\>.
Esto es *software* libre, es libre de cambiarlo y distribuirlo. Este
programa se ofrece SIN GARANTÍA ALGUNA.

**VER ADEMÁS**

Sitio Web de FusionInventory

* http://www.fusioninventory.org/

**AUTOR**

Tomás Abad \<tabadgp@gmail.com\>

----

[[!template id=info text="""Puede descargar la versión PDF de este documento [aquí](http://forge.fusioninventory.org/projects/fusioninventory-agent-windows-installer/files "http://forge.fusioninventory.org/projects/fusioninventory-agent-windows-installer/files")."""]]
