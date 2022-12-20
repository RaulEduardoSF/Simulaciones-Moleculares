# Simulaciones-Moleculares C$_6$H$_6$ y C$_{60}$
DFT vs Metodo de Huckel para orbitales moleculares

## DFT
Mediante el software ORCA, puedes realizar calculos de primeros principios a casi cualquier tipo de molecula. En este caso replicamos para las moleculas C$_6$H$_6$ y C$_{60}$. Para ello obtuvimos primero sus posiciones e hicimos un relajamiento estructural para tener las posciónes adecuadas y poder calcular con mejor definición los orbitales moleculares. Para el C$_6$H$_6$, utilice el siguiente input

```ini
! RKS PBE def2-SVP OPT PDBFILE
* xyzfile 0 1 benzeno.xyz
```

![orbitales_C60](https://user-images.githubusercontent.com/74220104/208773414-5db1d478-34eb-454f-91f9-4f11a719e6b8.png)


