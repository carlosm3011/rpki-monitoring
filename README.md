# Plataforma de Monitoreo de RPKI

Autor: Carlos M. Martinez, 20210924

## ¿De que se trata?

Existen múltiples herramientas de validación de RPKI, y si bien los resultados que producen son muy similares es importante entender como y cuando pueden arrojar resultados diferentes.

Además de las diferentes herramientas, cada una de ellas además soporta el acceder al contenido de los repositorios tanto por rsync como por RRDP, introduciendo una variable adicional que es importante tener en cuenta a la hora de monitorear.

Este entorno virtualizado permite la ejecución de múltiples validadores en una misma máquina virtual utilizando Docker. Incluye también una base de datos de series temporales (InfluxDB) y una herramienta de visualización (Grafana)

## Instalación

### Vagrant

Vagrant es una herramienta que permite automatizar máquinas virtuales locales para testing. Es útil para probar el entorno.

Asumiendo que se tiene Vagrant y VirtualBox instalado, en un sistema operativo "unix-like" (Linux, macOS), la instalación es muy simple. :

```
git clone https://github.com/carlosm3011/rpki-monitoring.git
cd dev
vagrant up
```

Vagrant funciona perfectamente en Windows también, y el proceso es similar. Se necesita instalar git o bajar una copia del repositorio en un archivo zip para poder correr estos comandos desde un prompt de PowerShell.

### VM 

Asumiendo que se cuenta con una VM con Ubuntu 20.04 instalado, el proceso para instalar la plataforma es similar.

```
apt install ansible
git clone https://github.com/carlosm3011/rpki-monitoring.git
cd rpki-monitoring/dev
sudo ansible-playbook -i hosts.local.txt site-dev.yml
```

Para actualizar a una nueva versión de la configuración del monitoreo:

```
cd rpki-monitoring/dev
git pull
sudo sudo ansible-playbook -i hosts.local.txt -t rpki-monitoring site-dev.yml
```

Con el switch "-t rpki-monitoring" solamente se ejecutan las tareas que instalan y actualizan el propio monitoreo.

## Uso

Al finalizar el proceso de instalación, tenemos un Grafana escuchando en el puerto 3000. Utilizando las credenciales por defecto (admin/admin) podemos ingresar por primera vez.

Para el caso local usando Vagrant nos conectamos a [http://localhost:3000]. Si estamos usando una VM en otra dirección IP usamos [http://a.b.c.d:3000].


## Importar datos de otra instalación

La configuración de Telegraf incluida buscará un archivo "/tmp/metrics.in" cada 5 minutos y si lo encuentra, lo va a importar dentro del influx. De esta forma podemos migrar los datos de una instalación a otra.

El archivo metrics.in tiene que contener lineas en el formato que Influx conoce como "line protocol", algo como esto:

```
rpki,host=ubuntu-focal,mode=rrdp,repo=lacnic,validator=routinator vrp_count=16184 1632520324000000000
rpki,host=ubuntu-focal,mode=rrdp,repo=lacnic,validator=fort vrp_count=16185 1632520380000000000
rpki,host=ubuntu-focal,mode=rsync,repo=lacnic,validator=rpki-client vrp_count=16195 1632520380000000000
rpki,host=ubuntu-focal,mode=rrdp,repo=lacnic,validator=routinator vrp_count=16184 1632520384000000000
rpki,host=ubuntu-focal,mode=rsync,repo=lacnic,validator=rpki-client vrp_count=16195 1632520440000000000
rpki,host=ubuntu-focal,mode=rrdp,repo=lacnic,validator=fort vrp_count=16185 1632520440000000000
```

Para generar este archivo tenemos que seguir los siguietnes pasos:

1. Correr el query que nos devuelve la información que queremos mover de instancia:

```
influx -format column -database lacnic -execute "select repo,mode,validator,vrp_count from rpki" | tee result0.txt
```

2. filtrar este resultado con un script de awk similar al siguiente:

```
cat result0.txt | awk '{printf("rpki,host=localhost,mode=rrdp,repo=%s,validator=%s vrp_count=%s %s\n",$2,$3,$4,$1)}' | tee metrics.in
```

3. (Opcional) Si hace falta importar archivos grandes

Para esto se puede usar el API de Influx de la siguiente manera:

```
curl -i -XPOST 'http://localhost:8086/write?db=rpki' --data-binary @/root/metrics.in
```

Si el archivo es muy grande se puede usar el comando "split" para partirlo en bloques.

## FIN