#PAQUETES-----------------------------------------------------------------------------
library(pacman)
p_load(ggplot2, lubridate, dplyr, foreign, ggthemes)




#LEYENDO EL ARCHIVO DE DATOS ---------------------------------------------------------
datos = read.spss("Riesgo_morosidad.sav", use.value.labels = T,to.data.frame = TRUE)
attr(datos, "variable.labels") <- NULL

datos |> filter(dpto == "Lima") |> count()




#PRIMEROS PASOS CON GGPLOT2-----------------------------------------------------------

#Código base-inicial para una gráfica de barras de la variable dpto:
ggplot(datos) + aes(x = dpto) + geom_bar(stat = "count")

#Haciendo la misma gráfica pero de forma horizontal: coord_flip()
ggplot(datos) + aes(x = dpto) + geom_bar(stat = "count") + coord_flip()



# Añadiendo temas de fondo: 

# Relación de temas
browseURL("https://ggplot2.tidyverse.org/reference/ggtheme.html")

# Componentes de los temas, para hacer tu propio tema:
browseURL("https://ggplot2.tidyverse.org/reference/theme.html")

# Temas: theme_bw()      theme_classic()   theme_dark()
#        theme_get()     theme_gray()      theme_grey()
#        theme_light()   theme_linedraw()  theme_minimal()
#        theme_replace() theme_set()       theme_update()
#        theme_void()

ggplot(datos) + aes(x = dpto) + geom_bar(stat = "count") + theme_gray()

# Añadiendo más temas
library(ggthemes)
library(tvthemes)



#Añadiendo títulos al gráfico con labs:

ggplot(datos) + aes(x = dpto) + 
  geom_bar(stat = "count") + 
  theme_gray() + 
    labs(title = "CANTIDAD DE PERSONAS POR DEPARTAMENTO",
         subtitle = "Cantidad de personas estudiadas en los 5 departamentos con una mayor cantidad de préstamos",
         caption = today(),
         #tag = "UNALM",
         x = "Departamentos",
         y = NULL)



#Especificando colores de la barra:

#color = color del borde
#fill = color de la barra

colors()

ggplot(datos) + aes(x = dpto) + 
  geom_bar(stat = "count", fill = "lightsalmon2") + 
  theme_gray() + 
  labs(title = "CANTIDAD DE PERSONAS POR DEPARTAMENTO",
       subtitle = "Cantidad de personas estudiadas en los 5 departamentos con una mayor cantidad de préstamos",
       caption = today(),
       #tag = "UNALM",
       x = "Departamentos",
       y = NULL)

#Usando los colores por defecto:

ggplot(datos) + aes(x = dpto, fill = dpto) + 
  geom_bar(stat = "count") + 
  theme_gray() + 
  labs(title = "CANTIDAD DE PERSONAS POR DEPARTAMENTO",
       subtitle = "Cantidad de personas estudiadas en los 5 departamentos con una mayor cantidad de préstamos",
       caption = today(),
       #tag = "UNALM",
       x = "Departamentos",
       y = NULL)

#Usando los colores según otra variable:

ggplot(datos) + aes(x = dpto, fill = sexo) + 
  geom_bar(stat = "count") + 
  theme_gray() + 
  labs(title = "CANTIDAD DE PERSONAS POR DEPARTAMENTO",
       subtitle = "Cantidad de personas estudiadas en los 5 departamentos con una mayor cantidad de préstamos",
       caption = today(),
       #tag = "UNALM",
       x = "Departamentos",
       y = NULL)

#Cambiando los colores por defecto y quitando la leyenda:

ggplot(datos) + aes(x = dpto, fill = sexo) + 
  geom_bar(stat = "count", show.legend = T) + 
  theme_gray() + 
  labs(title = "CANTIDAD DE PERSONAS POR DEPARTAMENTO",
       subtitle = "Cantidad de personas estudiadas en los 5 departamentos con una mayor cantidad de préstamos",
       caption = today(),
       #tag = "UNALM",
       x = "Departamentos",
       y = NULL) + 
  scale_fill_manual(values=c("darkgreen","orange"))


ggplot(datos) + aes(x = dpto, fill = sexo) + 
  geom_bar(stat = "count", show.legend = T) + 
  theme_gray() + 
  labs(title = "CANTIDAD DE PERSONAS POR DEPARTAMENTO",
       subtitle = "Cantidad de personas estudiadas en los 5 departamentos con una mayor cantidad de préstamos",
       caption = today(),
       #tag = "UNALM",
       x = "Departamentos",
       y = NULL) + 
  scale_fill_manual(values=c("Masculino" ="darkseagreen1", "Femenino" = "darkorchid3"))


#Usando colores de una imagen:

browseURL("https://imagecolorpicker.com/")

ggplot(datos) + aes(dpto) +
  geom_bar(fill=c("#3282d3","#eae543", "#468d6b",  
                  "#dc241c","#fff500", "#181412")) + theme_bw()

#Aplicando paletas de colores a partir de las funciones:
#rainbow(n), heat.colors(n), terrain.colors(n), 
#    topo.colors(n) y cm.colors(n)

ggplot(datos) + aes(dpto) + geom_bar(fill = topo.colors(6))

ggplot(datos) + aes(dpto, fill = morosidad) + geom_bar() + scale_fill_manual(values = topo.colors(2))

#Usando paletas de colores:

library(RColorBrewer)
display.brewer.all()

ggplot(datos) + aes(dpto, fill = morosidad) +
  geom_bar(show.legend = T) +
  theme_bw() +
  scale_fill_brewer(palette = "RdYlGn")



#Guardando el gráfico:

ggplot(datos) + aes(dpto, fill = dpto) + 
  geom_bar(show.legend = F) +
  theme_bw() + 
  labs(title = "Gráfico de Barras Vertical", 
       x= "Departamentos", 
       y= "Frecuencia") + 
  scale_fill_brewer(palette = "RdYlGn")

ggsave("dpto1.png", height = 5, width = 6)

#Guardando el gráfico en diferentes formatos:
#opciones: bmp(), jpeg(), tiff(), pdf(), ps(), svg()

pdf("dptos3.pdf") #siempre inicia con esto

ggplot(datos) + aes(dpto, fill = dpto) + 
  geom_bar(show.legend = F) +
  theme_bw() + 
  labs(title = "Gráfico de Barras Vertical", 
       x= "Departamentos", 
       y= "Frecuencia") + 
  scale_fill_brewer(palette = "RdYlGn")

dev.off() #Siempre termina con esto



# Insertar una imagen en un gráfico:

library(png)
library(ggpubr) #background_image

img = readPNG("logo.png")

ggplot(datos) + aes(dpto, fill = dpto) + 
  background_image(img) + 
  geom_bar(show.legend = F) +
  theme_bw() + 
  labs(title = "Gráfico de Barras Vertical", 
       x= "Departamentos", 
       y= "Frecuencia") + 
  scale_fill_brewer(palette = "RdYlGn")



# Gráfico interactivo con el paquete plotly:

library(plotly)

ggplot(datos) + aes(dpto, fill = dpto) + 
  geom_bar(show.legend = F) +
  theme_bw() + 
  labs(title = "Gráfico de Barras Vertical", 
       x= "Departamentos", 
       y= "Frecuencia") + 
  scale_fill_brewer(palette = "RdYlGn")
ggplotly()


ggplot(datos) + aes(dpto, fill = morosidad) + 
  geom_bar(show.legend = T) +
  theme_bw() + 
  labs(title = "Gráfico de Barras Vertical", 
       x= "Departamentos", 
       y= "Frecuencia") + 
  scale_fill_brewer(palette = "RdYlGn")
ggplotly()



# Gráficos animados con gganimate:

library(gganimate)
library(gifski)
library(png)

# gifski permite renderizar la animación como un formato de
#        archivo GIF (GIF es un formato de imagen popular para
#        imágenes animadas).

ggplot(datos) + aes(dpto, fill = dpto) + 
  geom_bar(show.legend = F) + 
  scale_fill_brewer(palette = "RdYlGn") +
  transition_states(dpto) + #super necesario
  enter_fade() +
  exit_fade()

ggplot(datos) + aes(dpto, fill = dpto) + 
  geom_bar(show.legend = F) + 
  scale_fill_brewer(palette = "RdYlGn") +
  transition_states(dpto) + #super necesario
  enter_grow() +
  exit_fade()


ggplot(datos) + aes(dpto, fill = dpto) + 
  geom_bar(show.legend = F) + 
  scale_fill_brewer(palette = "RdYlGn") +
  transition_states(dpto,
                    transition_length = 2,
                    state_length = 1) +
  enter_fade() + 
  exit_shrink()  +
  ease_aes('sine-in-out')


ggplot(datos) + aes(dpto, fill = dpto) + 
  geom_bar(show.legend = F) + 
  scale_fill_brewer(palette = "RdYlGn") +
  transition_states(dpto) + #super necesario
  enter_grow() +
  shadow_mark() # para que no desaparezca la barra



#Reordenando las barras con el paquete forcats:
library(forcats)

levels(datos$dpto)

fct_infreq(datos$dpto) #Ascendemte

fct_rev(fct_infreq(datos$dpto)) #Descemdemte

#Ascendente:

a = ggplot(datos) + aes(x=fct_infreq(datos$dpto), fill = dpto) + 
  geom_bar() + 
  theme_light() + 
  labs(title = "Gráfico de Barras Vertical", 
       x= "Departamento", 
       y= "Frecuencia") + 
  scale_fill_brewer(palette = "RdYlGn")


#Descendente:

b = ggplot(datos) + aes(x=fct_rev(fct_infreq(datos$dpto)), fill = dpto) + 
  geom_bar() + 
  theme_light() + 
  labs(title = "Gráfico de Barras Vertical", 
       x= "Departamento", 
       y= "Frecuencia") + 
    scale_fill_brewer(palette = "RdYlGn")



# Mostrando varias gráficas en una sola pantalla:

library(patchwork)

a + b + a 
a + b + a + plot_layout(ncol=1)
(a + b)/(a + plot_spacer()) 

library(cowplot)
plot_grid(a,b,a, ncol = 2)
plot_grid(a,b,b, nrow = 3)



#Gráfico Circular (Pie Chart)---------------------------------------------------------

table(datos$dpto)

pie(table(datos$dpto))

prop.table(table(datos$dpto))*100 #Muestra la tabla en porcentaje

round(prop.table(table(datos$dpto))*100,1) #Redondea la tabla de en porcentaje

etiqueta1 = c("Lima","Trujillo","Arequipa","Cusco","Ica","Piura")  
etiqueta2 = paste(etiqueta1, "", round(prop.table(table(datos$dpto))*100,1), "%")

pie(round(prop.table(table(datos$dpto))*100,1), 
    labels= etiqueta2,
    col=rainbow(length(etiqueta2)),
    main="Gráfico circular con porcentajes")


pie(round(prop.table(table(datos$dpto))*100,1), 
    labels = paste(etiqueta1, "\n", table(datos$dpto)),
    col=rainbow(length(etiqueta2)),
    main = "Gráfico circular con porcentajes")



#Gráfico circular en 3d:

library(plotrix)

pie3D(table(datos$dpto), 
      labels = etiqueta1, 
      main = "Gráfico Circular en 3D",
      explode = 0.05,
      labelcex = 1)



#Gráfico de hélice:

fan.plot(table(datos$dpto), 
         labels = etiqueta1, 
         main ="Fan Plot por Departamento")

fan.plot(table(datos$dpto), 
         labels=etiqueta2, 
         main="Fan Plot por departamento",
         col = topo.colors(length(etiqueta1)))



#Gráfico de barras apiladas (Stacked) en valor absoluto:

table(datos$tiporenta,datos$morosidad)

ggplot(datos) + aes(tiporenta) + geom_bar()

ggplot(datos) + aes(tiporenta,fill=morosidad) + geom_bar()


ggplot(datos) + aes(x=tiporenta,fill=morosidad) +
  geom_bar(position= position_stack()) + #position_stack() viene por defecto
  theme_bw() +
  labs(title = "Situación de la Morosidad según el Tipo de Renta", 
       x= "Tipo de Renta",
       y= "Frecuencia",
       fill = "Situación")  +
  scale_fill_manual(values=c("darkolivegreen3", "firebrick2"))

#Gráfico de barras apiladas (Stacked) en proporción:

ggplot(datos) + aes(x=tiporenta,fill=morosidad) +
  geom_bar(position=position_fill()) + #Para usarlo en proporción
  theme_bw() +
  labs(title = "Situación de la Morosidad según el Tipo de Renta", 
       x = "Tipo de Renta",
       y = "Proporción") + 
  scale_fill_manual(values=c("darkolivegreen3", "firebrick2")) 

ggplotly()


table(datos$tiporenta,datos$morosidad)
addmargins(table(datos$tiporenta,datos$morosidad))
round(prop.table(table(datos$tiporenta,datos$morosidad))*100,1)



#Gráfico de barras agrupadas:  position=position_dodge

ggplot(datos) + aes(x=tiporenta,fill=morosidad) +
geom_bar(position=position_dodge()) +
  theme_bw() +
  labs(title = "Situación de la Morosidad según el Tipo de Renta", 
       x= "Tipo de Renta",
       y= "Frecuencia")  +
  scale_fill_manual(values=c("darkolivegreen3", "firebrick2")) 

# Realizando más cambios a la leyenda

ggplot(datos) + aes(x=tiporenta,fill=morosidad) +
  geom_bar(position=position_dodge()) +
  theme_bw() +
  labs(title = "Situación de la Morosidad según el Tipo de Renta", 
       x= "Tipo de Renta",
       y= "Frecuencia")  +
  scale_fill_manual("Situación",
                    values=c("darkolivegreen3", "firebrick2"),
                    labels = c("No Deudor","Deudor")) 



#Gráfico de barras para una variable cualitativa y una cuantitativa:

ggplot(datos) + aes(x=morosidad, y=antiguedad, fill=morosidad) +
  stat_summary(geom="bar", fun = mean) +
  theme_bw()  +
  labs(title="Antiguedad promedio según la Morosidad", 
       x="Morosidad", 
       y="Antiguedad Promedio") 


tapply(datos$antiguedad,datos$morosidad,mean)


ggplot(datos) + aes(x=reorder(morosidad,antiguedad), #Reorder del paquete forcats
                    y=antiguedad, fill=morosidad) +
  stat_summary(geom="bar", fun = mean) +
  theme_bw()  +
  labs(title="Antiguedad promedio según la Morosidad", 
       x="Morosidad", 
       y="Antiguedad Promedio")  



#GRÁFICOS PARA UNA VARIABLE CONTINUA: ------------------------------------------------

#Histogramas:

ggplot(datos) + aes(edad) + geom_histogram()

ggplot(datos) +aes(edad) + geom_histogram(stat="bin") # Intervalos

ggplot(datos) + aes(edad) + geom_histogram(color="white")

ggplot(datos) + aes(edad) + geom_histogram(color = "white", binwidth = 10)

ggplot(datos, aes(edad)) + geom_histogram(color="white",bins =10)

ggplot(datos) + aes(edad) + geom_histogram(color="white",fill="deepskyblue3", bins = 15) + 
  labs(title = "Histograma de la Edad", 
       x="Edad", 
       y="Frecuencia") +
  theme_bw() 

ggplotly()



# Cambiando la posición de la leyenda con legend.position()

ggplot(datos) + aes(x=edad, color=morosidad, fill=morosidad) +
  geom_histogram(alpha=0.5, bins = 15) + 
  theme(legend.position="bottom")

# legend.position="right"
# legend.position="left"
# legend.position="top"
# legend.position="bottom"
# legend.position="none"

# Cambiando los colores de los grupos con scale_fill_manual()

ggplot(datos) + aes(x=edad,fill=morosidad) +
  geom_histogram(alpha=0.5, color="azure4") + 
  theme(legend.position="bottom") +
  scale_fill_manual(values=c("darkgreen", "white")) +
  scale_color_manual(values=c("darkgreen", "white")) 

# Cambiando el título de la leyenda con legend.position()

ggplot(datos) + aes(x=edad,color=morosidad,fill=morosidad) +
  geom_histogram(alpha=0.5) + 
  theme(legend.position="bottom") +
  labs(color="Situación crediticia",
       fill="Situación crediticia")

# Por departamento
ggplot(datos) + aes(x= edad, color = dpto, fill = dpto) +
  geom_histogram(alpha = 0.7)+
  theme(legend.position = "bottom")+
  labs(color = "Departamento",
       fill = "Departamento")



# Histograma por grupo usando facets()

ggplot(datos) + aes(edad, fill=morosidad) + 
  geom_histogram(alpha=0.5,color="azure4") +
  facet_grid(morosidad~.)  +   # filas ~ columnas
  theme(legend.position="none")


ggplot(datos) + aes(edad, fill=morosidad) + 
  geom_histogram(alpha=0.5,color="azure4") +
  facet_grid(.~morosidad)  + 
  theme(legend.position="none")



# Para departamento

ggplot(datos) + aes(edad, fill=dpto) + 
  geom_histogram(alpha=0.5,color="azure4") +
  facet_grid(dpto~.)  + 
  theme(legend.position="none")


ggplot(datos) + aes(edad, fill=dpto) + 
  geom_histogram(alpha=0.5,color="azure4") +
  facet_grid(.~dpto)  + 
  theme(legend.position="none")


ggplot(datos) + aes(edad, fill=dpto) + 
  geom_histogram(alpha=0.5,color="azure4") +
  facet_wrap(~dpto,nrow=2)  + 
  theme(legend.position="none")



# Combinando más de una variable

ggplot(datos) + aes(edad, fill=morosidad) + 
  geom_histogram(alpha=0.5,color="azure4") +
  facet_grid(sexo ~ morosidad,scales = "free")  + 
  theme(legend.position="none")



#Gráfica de Puntos (DotPlot)

stripchart(datos$antiguedad, 
           method="overplot",    # es recomendable usar jitter
           pch=20, 
           main="Gráfica de puntos", 
           xlab="Antigüedad")

stripchart(datos$antiguedad, 
           method="jitter", 
           pch=20, 
           main="Gráfica de puntos", 
           ylab="Antigüedad",
           vertical= F, 
           xlim=c(0,80))



# 3.4 Mapa de Calor para una variable continua #

ggplot(datos) + aes(x= edad, y= "") +
  geom_bin2d() + labs(fill="Escala")

ggplot(datos) + aes(x= edad, y= "")  +
  geom_bin2d(  ) +
  scale_fill_gradient(low="steelblue", high="black")

ggplot(datos) + aes(x= edad, y= "")  +
  geom_bin2d(breaks= seq(20,80,20) ) +
  scale_fill_gradient(low="steelblue",high="black",name="Escala") +
  scale_x_continuous(breaks=seq(20,80,20)) 



#GRÁFICO PARA UNA VARIABLE DISCRETA---------------------------------------------------

ggplot(datos) + aes(nrodepen) + 
  geom_bar(width=0, color="black")+
  theme_light() + 
  labs(title = "Gráfico de Varas Vertical", 
       x= "Número de dependientes", 
       y= "Frecuencia")

#GRÁFICO PARA UNA VARIABLE CATEGÓRICA Y UNA NUMÉRICA----------------------------------

ggplot(datos) + 
  aes(x=reorder(morosidad,antiguedad),
      y=antiguedad,
      fill=morosidad)   + # aes(morosidad,fill=morosidad) + geom_bar() +
  # theme(legend.position = "none") +
  stat_summary(geom="bar", fun =  mean) +
  theme_linedraw() +
  labs(title="Antiguedad promedio según la Morosidad", 
       x="Morosidad", 
       y="Antiguedad Promedio")  +
  theme(legend.position = "none") 


#Gráficos para dos variables cuantitativas--------------------------------------------

ggplot(datos) + aes(x=antiguedad,y=edad) + 
  geom_point(stat="identity")

ggplot(datos) + aes(x=antiguedad,y=edad) + 
  geom_point()


#RESUMEN CONLCUIDO