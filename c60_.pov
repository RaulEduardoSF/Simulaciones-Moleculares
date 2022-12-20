#include "colors.inc"
#include "shapes.inc"
#include "math.inc"
#include "functions.inc"
#include "transforms.inc"

light_source {<1000,0,0> color White}
light_source {<0,1000,0> color White}
light_source {<0,5000,5000> color White}
//light_source {<-1000,0,0> color White}

camera {location <0,0,-12> look_at <0,0,0> rotate y*360*clock}
background{color White}
light_source{<1000,1000,-1000> color <0,0,0>}

#fopen Archivo "./orbitales/AAA.txt" read

#declare r = 5;
#declare ra = 0.15;
#declare pos = array[60];
#declare vec = <0,0,0>;
#declare i=0;
#declare c60 =
union{
#while (i<60)
    #read(Archivo, xx,yy,zz,ss)
    #declare pos[i] = <xx,yy,zz>;
    sphere{ pos[i], ra pigment{color rgb<1, 0.65, 0>} }
    
    #declare d = VDist(vec,pos[i]);
    #if (d < 1.46 & i > 0)
        cylinder{ vec, pos[i], ra texture{ pigment{ color White}
                   finish { reflection 0.1 phong 1}}}    	
    #end
    #declare vec = pos[i];
    
    // Cyan = Carga Negativa
    // Magenta = Carga Posistiva
    #if (ss<0)
        #declare d = VDist(0, pos[i]);
        sphere { 1.2*pos[i], abs(r*ss) texture{pigment{color Cyan filter 0.5} finish{diffuse 0.9 phong 0.5}}}
        sphere { 0.8*pos[i], abs(r*ss) texture{pigment{color Magenta filter 0.5} finish{diffuse 0.9 phong 0.5}}}        
    #else
        sphere { 1.2*pos[i], r*ss texture{pigment{color Cyan filter 0.8} finish{diffuse 0.9 phong 0.5}}}
        sphere { 0.8*pos[i], r*ss texture{pigment{color Magenta filter 0.8} finish{diffuse 0.9 phong 0.5}}}
    #end
    #declare i = i + 1;
#end
}

object{c60 rotate z}
