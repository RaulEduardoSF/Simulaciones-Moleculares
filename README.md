# Simulaciones-Moleculares 
DFT vs Metodo de Huckel para orbitales moleculares C6H6 y C60

## DFT
Mediante el software ORCA, puedes realizar calculos de primeros principios a casi cualquier tipo de molecula. En este caso replicamos para las moleculas C6H6 y C60. Para ello obtuvimos primero sus posiciones e hicimos un relajamiento estructural para tener las posciónes adecuadas y poder calcular con mejor definición los orbitales moleculares. Para el C6H6, utilice el siguiente input (benzene.inp).

```ini
! RKS PBE def2-SVP OPT PDBFILE
* xyzfile 0 1 benzeno.xyz
```

![orbitales_C60](https://user-images.githubusercontent.com/74220104/208773414-5db1d478-34eb-454f-91f9-4f11a719e6b8.png)

## Metodo de Huckel
Mediante el metodo númerico de Huckel, podemos establecer una buena aproximación respecto a los calculos de primeros principios (DFT). Se utiliza un script en bash para automatiza el proceso que va desde el programa `huckel.f` que requiere de `c60.pdb`, procesa los datos de salida `salida.txt` para separar todos los orbitales electronicos disponibles, finalizando en la renderización en formato `.gif` mediante un archivo de POV-Ray `c60_.ini` y `c60_.pov`.

```bash
#!/bin/bash

# Creando carpetas para almacenar el grueso de archivos txt
mkdir -p plots
mkdir -p ./plots/gifs
mkdir -p ./plots/orbitales
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

# Ciclo para observar variedad de estados
read -p "Determine el estado de energía del 1 al 60: " a
sed "s/AAA/${a}/g" c60_.pov > ./plots/c60.pov # Se escoge el archivo txt correspondiente >
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
```
![image](https://user-images.githubusercontent.com/74220104/208777714-217298f4-9c1a-4727-8e04-74f6ef572a95.png)

Todos los detalles se muestran en `Huckel2.pdf`.

