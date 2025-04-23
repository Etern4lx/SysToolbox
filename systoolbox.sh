#!/bin/bash 

# === Colores === 

blue='\e[34m'
red='\e[31m'
green='\e[32m'
NC='\e[0m' # sin color

detectar_sistema() {

	echo -e "${green} = Detectando información del sistema... = "

	sleep 1
 
	if [ -f /etc/os-release ]; then
	    . /etc/os-release
	    DISTRO=$ID
            DISCO=$(df -h | grep '^/' | awk 'NR==1 {print $4}')
            RAM=$(free -h | awk 'NR==2 {print $2}')
            procesador=$(lscpu | awk -F: '/Model name/ {print $2}' | sed 's/^[ \t]*//;s/[ ]*$//;s/@.*//')
	    echo -e "${green} === Distribución detectada: $NAME ($ID), versión: $VERSION_ID ===${NC} "
	    echo -e "${green} === Espacio en el disco duro principal: $DISCO === ${NC}" 
	    echo -e "${green} === La ram de la que dispone su equipo son: $RAM === ${NC}"
	    echo -e "${green} === Su procesador es: $procesador" 
	else 
            echo -e "${red} No se pudo detectar la distribuición.${NC}"
	    exit 1
	fi	
	echo

}

tarjeta_grafica(){
    if comando -v nvidia-smi &>/dev/null; then
	echo -e "${green} === Informacion de la tarjeta gráfica NVIDIA: === ${NC}"  
    else
	echo -e "${green} === información de la tarjeta gráfica: === ${NC}"
	grafica=$(lspci | grep -i vga)
	echo -e "${green} === $grafica ===${NF}"
    fi
}




menu() {
	while true; do 
	  echo -e "${green}"
	  echo -e "==== Elige la distro para actualizar el sistema ===="	
          echo -e "[+] 1) Actualizar Ubuntu "
          echo -e "[+] 2) Actualizar Kali-Linux"
	  echo -e "[+] 3) Actualizar Arch-Linux"
          echo -e "[+] 4) Actualizar Parrot-OS"
	  echo -e "[+] 5) Actualizar Linux-mint"
          echo -e "[+] 6) Actualizar Fedora"
	  echo -e "[-] 7) Salir"
	  echo -e "${NC}"
	  read -p "$(echo -e "${blue} Elige una opción: ${NC}")" opcion
  
          case $opcion in
            1) echo "Ejecutando actualización para Ubuntu..."; sudo apt update && sudo apt upgrade -y ;;
            2) echo "Ejecutando actualización para Kali..."; sudo apt update && sudo apt full-upgrade -y ;;
            3) echo "Ejecutando actualización para Arch..."; sudo pacman -Syu ;;
            4) echo "Ejecutando actualización para ParrotOS..."; sudo parrot-upgrade ;;
            5) echo "Ejecutando actualización para Linux Mint..."; sudo apt update && sudo apt upgrade -y ;;
            6) echo "Ejecutando actualización para Fedora..."; sudo dnf upgrade --refresh ;;
            7) echo "Saliendo..."; break ;;
            *) echo -e "${red}Opción no válida. Intenta otra vez.${NC}" ;;
          esac

echo -e "${blue}\nPresiona [Enter] para continuar...${NC}"
read
clear
    done
}

 





#  ====  llamada a la función ====


echo  -e "${green} ==== Bienvenido a systoolbox ===="
detectar_sistema
tarjeta_grafica
menu

