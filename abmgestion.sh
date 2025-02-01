#!/bin/bash

##########################################################################################
#                                                                                        #
#  Owner: Lucas González                                                                 #
#  Date: 30/01/25                                                                        #
#  Objetive: Gestión de Usuarios, Grupos y Permisos en Linux                             #
#  Tasks:                                                                                #
#       + Crear un script para la gestión de usuarios en Linux.                          #
#       + Permitir la creación, modificación y eliminación de usuarios.                  #
#       + Administrar permisos y grupos de usuarios.                                     #
#                                                                                        #
#  Requirements:                                                                         #
#       + El script debe permitir agregar usuarios con su respectiva passwd              #
#       + Debe permitir modificar usuarios existentes (cambiar grupo, contraseña, etc).  #
#       + Debe permitir eliminar usuarios con opción de eliminar su directorio home      #
#       + Debe gestionar permisos en archivos y directorios.                             #
#       + Debe propocionar una interfaz de línea de comandos amigable con menús.         #
#                                                                                        #
##########################################################################################

# The user must have sudo privileges

clear

while true;
do
clear

echo ""
echo " ###############################################################"
echo " #                                                             #"
echo " #        Menú de gestión de Usuarios y Grupos en Linux        #"
echo " #  Hora: $(date +%H:%M)                                           #"
echo " #  Usuario: $(whoami)                                             #"
echo " #                                                             #"
echo " ###############################################################"
echo " "
echo " "
echo " 1) Crear usuario nuevo"
echo " 2) Modificar permisos de usuario sobre archivos y directorios"
echo " 3) Modificar password de un usuario"
echo " 4) Modificar grupo de un usuario"
echo " 5) Eliminar un usuario"


read -p "Ingrese la opción [de 1 a 5] o [S|s] para salir: " opcion


        case $opcion in
                1) # add user
                        read -p "Ingresar el nombre del nuevo usuario: " new_user

                        if [ -z "$new_user" ]; then
                                echo "Debe ingresar un nombre para generar un usuario."
                                sleep 2
                                continue
                        else
                                sudo useradd "$new_user"
                                sleep 2
                                echo "Se ha creado con éxito el usuario $new_user"
                                sleep 2
                                sudo passwd -e "$new_user" > /dev/null 2>&1
                                echo "El usuario deberá ingresar una clave en su primer ingreso"
                                sleep 2

                        fi
                        ;;
                5) # del user
                        read -p "Ingresar el nombre de usuario a eliminar: " del_user

                        if [ -z "$del_user" ]; then
                                echo "Debe ingresar un usuario para eliminar."
                                sleep 2
                                continue
                        elif  id "$del_user" ; then
                                sleep 2
                                read -p "¿Está seguro que desea eliminar el usuario '"$del_user"' ? [y/n]" answer

                                if [ "$answer" = "n" ] || [ "$answer" = "N" ] ; then
                                        sleep 1
                                        echo "No se realizó ninguna modificación en el usuario '$del_user'"
                                        continue

                                elif [ "$answer" = "y" ] || [ "$answer" = "Y" ] ; then
                                        sudo userdel "$del_user"
                                        sleep 2
                                        echo "Se ha eliminado con éxito el usuario '$del_user'"
                                        sleep 1
                                else
                                        sleep 1
                                        echo "Opción no válida, intenta nuevamente."
                                        sleep 1
                                        continue
                                fi
                        else
                                sleep 2
                                echo "El usuario '$del_user' no existe."
                        fi
                        ;;

                S|s)
                        clear
                        exit
                        ;;
                *)
                        echo "Opción inválida"
                        ;;
        esac
done
