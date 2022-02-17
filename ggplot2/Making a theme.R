
#EDITANDO TEMA PROPIO

# Relación de temas
browseURL("https://ggplot2.tidyverse.org/reference/ggtheme.html")

# Componentes de los temas, para hacer tu propio tema:
browseURL("https://ggplot2.tidyverse.org/reference/theme.html")

# Temas: theme_bw()      theme_classic()   theme_dark()
#        theme_get()     theme_gray()      theme_grey()
#        theme_light()   theme_linedraw()  theme_minimal()
#        theme_replace() theme_set()       theme_update()
#        theme_void()



theme_1 = function(){
  theme(
    plot.title        = element_text(size = 20,
                                     color = "#E6E0DF",
                                     hjust = 0, 
                                     vjust = 0.1,
                                     face = "bold"), 
    plot.subtitle     = element_text(color = "white",
                                     size = 11),
    
    plot.caption      = element_text(face = "bold", color = "#E6E0DF"),
    
    axis.title.x      = element_text(size = 10, color = "#E6E0DF", face = "bold"),
    axis.text.x       = element_text(color = "#E6E0DF", size = 8, face = "bold"),
    axis.title.y      = element_text(size = 10, color = "#E6E0DF", face = "bold" ),
    axis.text.y       = element_text(color = "#E6E0DF", size = 8, face = "bold"),
    
    axis.ticks        = element_line(color = "white"),
    
    panel.border      = element_rect(color = "#37424F", fill = NA, size = 1,linetype = 1),
    
    panel.background  = element_rect(fill = "#E6E0DF"),
    
    plot.background   = element_rect(fill = "#292828"),
    
    panel.grid        = element_line(color = "#37424F", linetype = 1, size = 0.1),
    
    legend.background = element_rect(color = "black", fill = "#3D3C3B", linetype = 0.5),
    legend.title      = element_text(face = "bold", color = "white", size = 11),
    legend.text       = element_text(face = "bold", color = "white", size = 9),
    legend.position   = "right"
  )
}
