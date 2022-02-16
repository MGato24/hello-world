#--------------------------------------------------------------------------
#PRÁCTICA N° 2 - GRUPO 1 --------------------------------------------------
# -------------------------------------------------------------------------

# Para limpiar el workspace, por si hubiera algún dataset 
# o información cargada
rm(list = ls())

# Para limpiar el área de gráficos
graphics.off()

# Cambiar el directorio de trabajo
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
getwd()

# Otras opciones
options(scipen=999)    # Eliminar la notación científica
options(digits = 3)    # El número de decimales

# PAQUETES - (COLOCAR LOS PAQUETES QUE USAN EN SUS CÓDIGOS)
library(pacman)

p_load(tidyverse,
       tidytext,
       tm,
       wordcloud,
       wordcloud2,
       pdftools,
       patchwork,
       widyr,
       dplyr,
       magrittr,
       stringr,
       readxl,extrafont,remotes)

#Leyendo los themes grupales-------------------
theme_propio <- function(){
  theme(
    plot.title        = element_text(family = "Elephant",
                                     size = 13,
                                     color = "#504D3B",
                                     hjust = +1.5, vjust = 0), 
    plot.subtitle     = element_text(size = 11 , hjust = 1 , family = "Bodoni MT Condensed"),
    axis.title.x      = element_text(family = "Bahnschrift", size = 14 , hjust = 0.5),
    axis.text.x       = element_text(angle = 0, color = "#4E3F25", 
                                     size = 14, family ="Times New Roman" ),
    axis.title.y      = element_text(family = "Bahnschrift", 
                                     size = 12, angle = 90, hjust = 0.5 ),
    axis.text.y       = element_text(color = "#4E3F25", family = "Times New Roman", size= 14),
    axis.ticks        = element_line(color = "lightblue"),
    panel.border      = element_rect(color = "lightblue", 
                                     fill = NA),
    panel.background  = element_rect(fill = "#FCF3CF"),
    plot.background   = element_rect(fill = "#FAD7A0"),
    legend.background = element_blank(),
    legend.position   = "bottom",
    legend.text       = element_text( family = "Candara Light") ,
    legend.title      = element_text(family = "Berlin Sans FB", size = 12)
  )
}


# LEYENDO EL PDF - DISCURSO ALBERTO FUJIMORI - 1990 Y HACERLO TXT ---------

d_90_af =  pdf_text("mensaje-1990-af.pdf")

view(d_90_af)

d_90_af = paste(d_90_af, collapse = " ")



str_count(d_90_af, "MENSAJE DEL PRESIDENTE CONSTITUCIONAL DEL PERÚ")
str_count(d_90_af, "INGENIERO ALBERTO FUJIMORI FUJIMORI")
str_count(d_90_af, "ANTE EL CONGRESO NACIONAL")

d_90_af =  str_remove_all(d_90_af, "MENSAJE DEL PRESIDENTE CONSTITUCIONAL DEL PERÚ")
d_90_af =  str_remove_all(d_90_af, "INGENIERO ALBERTO FUJIMORI FUJIMORI")
d_90_af =  str_remove_all(d_90_af, "ANTE EL CONGRESO NACIONAL")


# Buscando los números de página 

str_count(d_90_af, "\n[:blank:]+[:digit:]+\n")

d_90_af = str_replace_all(d_90_af, "[:blank:]{2,}", " ")


# Símbolos de puntuación 

str_count(d_90_af, "[:punct:]")

d_90_af = str_remove_all(d_90_af, "[:punct:]")


# Buscando los números 

str_count(d_90_af, "[:digit:]")

d_90_af = str_remove_all(d_90_af, "[:digit:]")


# Guardando como un archivo de texto plano 

write_lines(d_90_af, "Discurso Presidencial A_Fujimori_90.txt")



# LEYENDO EL PDF - DISCURSO ALBERTO FUJIMORI - 1995 Y HACERLO TXT ---------

d_95_af =  pdf_text("mensaje-1995-af.pdf")

d_95_af = paste(d_95_af, collapse = " ")


str_count(d_95_af, "MENSAJE DEL PRESIDENTE CONSTITUCIONAL DEL PERÚ")
str_count(d_95_af, "INGENIERO ALBERTO FUJIMORI FUJIMORI")
str_count(d_95_af, "ANTE EL CONGRESO NACIONAL")
str_count(d_95_af, "INICIANDO UN NUEVO PERIODO")
str_count(d_95_af, "GUBERNAMENTAL")

str_count(d_95_af, "Señora Presidenta del Congreso de la República, doctora Martha Chávez
Cossio;
Señoras y señores Congresistas;
Excelentísimos señores jefes de Estado y de Gobierno;
Señoras y Señores representantes de países amigos;
Pueblo del Perú:
")

d_95_af =  str_remove_all(d_95_af, "MENSAJE DEL PRESIDENTE CONSTITUCIONAL DEL PERÚ")
d_95_af =  str_remove_all(d_95_af, "INGENIERO ALBERTO FUJIMORI FUJIMORI")
d_95_af =  str_remove_all(d_95_af, "ANTE EL CONGRESO NACIONAL")
d_95_af =  str_remove_all(d_95_af, "INICIANDO UN NUEVO PERIODO")
d_95_af =  str_remove_all(d_95_af, "GUBERNAMENTAL")

d_95_af =  str_remove_all(d_95_af, "Señora Presidenta del Congreso de la República, doctora Martha Chávez
Cossio;
Señoras y señores Congresistas;
Excelentísimos señores jefes de Estado y de Gobierno;
Señoras y Señores representantes de países amigos;
Pueblo del Perú:
")


# Buscando los números de página

str_count(d_95_af, "\n[:blank:]+[:digit:]+\n")

d_95_af = str_replace_all(d_95_af, "[:blank:]{2,}", " ")


# Símbolos de puntuación 

str_count(d_95_af, "[:punct:]")

d_95_af = str_remove_all(d_95_af, "[:punct:]")


# Buscando los números 

str_count(d_95_af, "[:digit:]")

d_95_af = str_remove_all(d_95_af, "[:digit:]")


# Guardando como un archivo de texto plano 

write_lines(d_95_af, "Discurso Presidencial A_Fujimori_95.txt")



# LEYENDO STOPWORDS -------------------------------------------------------

#stopwords 1
stopwords_es_1 = read_excel("CustomStopWords.xlsx")

names(stopwords_es_1) <- c("Token","Fuente")


#stopwords 2

stopwords_es_2 = tibble(Token= c("quiero","humanos","don","año","años"), Fuente="Mis StopWords")  #agregar palabras para no ser analizadas 


#Uniendo ambos stopwords

stopwords_es   <- rbind(stopwords_es_1, stopwords_es_2)
stopwords_es   <- stopwords_es[!duplicated(stopwords_es$Token),]





# LEYENDO DICCIONARIO DE SENTIMIENTOS -------------------------------------

sentimientos = read.delim("sentimientos_2.txt")

sentimientos = as_tibble(sentimientos)


# TRABAJANDO DISCURSO ALBERTO FUJIMORI - 1990 -------------------------------

discurso90 = scan("Discurso Presidencial A_Fujimori_90.txt",
                  encoding = "UTF-8", what = "char",
                  sep = "\n")


discurso90 = tibble(discurso90) |>
  unnest_tokens(Token, discurso90) |> 
  mutate(Token= removeNumbers(Token))


# REMOVIENDO PALABRAS INNCESESARIAS

discurso90 = discurso90 |> anti_join(stopwords_es)     

discurso90_f = discurso90 |> count(Token, sort = TRUE)   # contar y ordenar 

#Afinando con stringr 

discurso90_f |>  mutate( Token = str_replace(Token , 'perú', 'Perú'))  -> discurso90_f
discurso90_f |>  mutate( Token = str_replace(Token , 'derechos', 'derechos humanos'))  -> discurso90_f



# GRÁFICOS DISCURSO 1990 --------------------------------------------------

#GRÁFICO DE BARRAS

discurso90_f |>
  top_n(9) |> 
  ggplot() + aes(x = fct_reorder(Token, n), 
                 y = n,fill=Token) +
  geom_col() +
  labs(x = NULL, y = "Frecuencia", 
       title = "DISCURSO DEL EX-PRESIDENTE ALBERTO FUJIMORI FUJIMORI",
       subtitle = "28 DE JULIO DE 1990") +
  theme_propio() +
  theme(legend.position = "none") + 
  coord_flip()->P1


#GRÁFICO USANDO WORDCLOUD 2

letterCloud(discurso90_f, word = "K", color=rep_len(c("red","white"), nrow(discurso90_f)), backgroundColor="black", size = 0.5)

wordcloud2(discurso90_f, figPath = "A.F.png", size = 0.8, color=rep_len(c("red","white"), nrow(discurso90_f)), backgroundColor="black")

wordcloud2(discurso90_f, size = 0.7, minRotation = -pi/6, maxRotation = -pi/6, rotateRatio = 1, shape="diamond", color=rep_len(c("red","white"), nrow(discurso95_f)), backgroundColor="black")


#GRÁFICO DE SENTIMIENTOS


discurso90_sentimiento = discurso90_f |> 
  inner_join(sentimientos,by=c("Token"="palabra"))


discurso90_sentimiento |> count(sentimiento) |>
  ggplot() + aes(x=fct_reorder(sentimiento,n),
                 y=n,
                 fill=sentimiento) + 
  geom_col(show.legend = F) + coord_flip() +
  labs(title ="Análisis de sentimientos del discurso presidencial",
       subtitle = "1990 - Alberto Fujimori",
       caption = "Fuente: Presidencia de la República del Perú",
       x = "Sentimientos",
       y= "Frecuencia") +
  theme_propio()->S1


# TRABAJANDO DISCURSO ALBERTO FUJIMORI - 1995 -------------------------------

discurso95 = scan("Discurso Presidencial A_Fujimori_95.txt",
                  encoding = "UTF-8", what = "char",
                  sep = "\n")


discurso95 = tibble(discurso95) |> 
  unnest_tokens(Token, discurso95) |>
  mutate(Token= removeNumbers(Token))


# REMOVIENDO PALABRAS INNCESESARIAS

discurso95 = discurso95 |> anti_join(stopwords_es)

discurso95_f = discurso95 |> count(Token, sort = TRUE)

#Afinando con stringr 

discurso95_f |>  mutate( Token = str_replace(Token , 'perú', 'Perú'))  -> discurso95_f




# GRÁFICOS DISCURSO 1995 --------------------------------------------------

#GRÁFICO DE BARRAS

discurso95_f |>
  top_n(8) |> 
  ggplot() + aes(x = fct_reorder(Token, n), 
                 y = n,fill=Token) +
  geom_col() +
  labs(x = NULL, y = "Frecuencia", 
       title = "DISCURSO DEL EX-PRESIDENTE ALBERTO FUJIMORI FUJIMORI",
       subtitle = "28 DE JULIO DE 1995") +
  theme_propio() +
  theme(legend.position = "none") + 
  coord_flip()->P2

#GRÁFICO USANDO WORDCLOUD 2

letterCloud(discurso95_f, word = "K", color=rep_len(c("red","white"), nrow(discurso95_f)), backgroundColor="black", size = 0.5)

wordcloud2(discurso95_f, figPath = "mapa.png", size = 0.5, color=rep_len(c("red","white"), nrow(discurso95_f)), backgroundColor="black")

wordcloud2(discurso95_f, size = 0.9, minRotation = -pi/6, maxRotation = -pi/6, rotateRatio = 1, shape="diamond", color=rep_len(c("red","white"), nrow(discurso95_f)), backgroundColor="black")


#GRÁFICO DE SENTIMIENTOS


discurso95_sentimiento = discurso95_f |> 
  inner_join(sentimientos,by=c("Token"="palabra"))


discurso95_sentimiento |> count(sentimiento) |>
  ggplot() + aes(x=fct_reorder(sentimiento,n),
                 y=n,
                 fill=sentimiento) + 
  geom_col(show.legend = F) + coord_flip() +
  labs(title ="Análisis de sentimientos del discurso presidencial",
       subtitle = "1995 - Alberto Fujimori",
       caption = "Fuente: Presidencia de la República del Perú",
       x = "Sentimientos",
       y= "Frecuencia") +
  theme_propio() ->S2


# GRÁFICOS DE COMPARACIÓN DE DISCURSOS DEL 90 y 95 ------------------------

#COMPARACIÓN DE PALABRAS
P1  + labs( title = NULL)->p1
P2  + labs( title = NULL)->p2

p1 + p2


#COMPARACIÓN DE SENTIMIENTOS
S1  + labs( title = NULL)->s1
S2  + labs( title = NULL)->s2

s1 + s2





