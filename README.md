# Reverse-shell-generator

Esta es una herramienta programada en bash, con la finalidad de automatizar la creación de la reverse shell:
<ul>
  <li>Crea archivos para webshell</li>
  <li>Reverse shell de PHP</li>
  <li>Reverse shell de Python</li>
  <li>Reverse shell de Java</li>
  <li>Reverse shell de Bash</li>
  <li>Reverse shell de Ruby</li>
  <li>Reverse shell de Node</li>
</ul>

Instalación de la herramienta:
------------------------------

1. Primero clonaremos la herramienta.
```
git clone https://github.com/aitorseguramateos/Reverse-shell-generator.git
```

2. Nos ubicaremos en el directorio del repositorio.
```
cd Reverse-shell-generator
```

3. Seguidamente le daremos permisos de ejecución.
```
chmod +x reversgenerator.sh
```

¿Cómo usar la herramienta?

Para ver el menú de ayuda:
```
sudo ./reversgenerator.sh -h
```

Uso:
```
sudo ./reversgenerator.sh -s <IP_ATACANTE> [-p <PUERTO>] -f <FUNCION>
```
