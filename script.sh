#!/bin/bash

# Creando carpetas para almacenar el grueso de archivos txt
mkdir -p plots
cd plots/
mkdir -p gifs orbitales pngs
cd ..
mkdir -p out

echo "Metodo de huckel y arreglo de archivos"

# Compilando Huckel
gfortran -ffree-form huckel.f -o huckel.out
./huckel.out
echo -e "\n\tArchivo de Salida: huckel_out.txt\n"

# Fraccionando archivo
awk -v RS= '{print > ("./out/out-" NR ".txt")}' salida.txt
awk '{print $2",\t"$3",\t"$4","}' c60_.xyz > c60.xyz

for ((c=1; c<=60; c+=1))
do
    awk '{if (NR!=1) {print $2","}}' ./out/out-${c}.txt > ./out/in-${c}.txt
    paste c60.xyz ./out/in-${c}.txt > ./plots/orbitales/${c}.txt
done

rm -r out
cp c60_.ini ./plots/c60.ini
cp c60_.pov ./plots/c60.pov

# Ciclo para observar variedad de estados
read -p "Determine el estado de energía del 1 al 60: " a
sed "s/AAA/${a}/g" c60_.pov > ./plots/c60.pov # Se escoge el archivo txt correspondiente al numero a
while [ $a -gt 0 -a $a -le 60 ]
do
    cd ./plots/
    povray c60.ini
    convert -delay 20 -loop 0 ./pngs/*.png ./gifs/$a.gif
    rm ./pngs/*.png
    eog ./gifs/$a.gif
    cd ..
    echo "! Para ya no continuar escriba un número fuera del rango !"
    read -p "   Determine el estado de energía del 1 al 60: " a
    sed "s/AAA/${a}/g" c60_.pov > ./plots/c60.pov
done


