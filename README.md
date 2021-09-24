# RPKI Monitoring Platform

Autor: Carlos M. Martinez, 20210924

## ¿De que se trata?

Existen múltiples herramientas de validación de RPKI, y si bien los resultados que producen son muy similares es importante entender como y cuando pueden arrojar resultados diferentes.

Además de las diferentes herramientas, cada una de ellas además soporta el acceder al contenido de los repositorios tanto por rsync como por RRDP, introduciendo una variable adicional que es importante tener en cuenta a la hora de monitorear.

Este entorno virtualizado permite la ejecución de múltiples validadores en una misma máquina virtual utilizando Docker. Incluye también una base de datos de series temporales (InfluxDB) y una herramienta de visualización (Grafana)

## Instalación

### Vagrant

Vagrant es una herramienta que permite automatizar máquinas virtuales locales para testing. Es útil para probar el entorno.

Asumiendo que se tiene Vagrant y VirtualBox instalado, la instalación es muy simple:

```
cd dev
vagrant up
```

### VM 

Asumiendo que se cuenta con una VM con Ubuntu 20.04 instalado, el proceso para instalar la plataforma es similar.

```
apt install ansible
git clone https://github.com/carlosm3011/rpki-monitoring.git
cd rpki-monitoring.git/dev
sudo ansible-playbook -i hosts.local.txt site-dev.yml
```

## Uso

Al finalizar el proceso de instalación, tenemos un Grafana escuchando en el puerto 3000. Utilizando las credenciales por defecto (admin/admin) podemos ingresar por primera vez.



