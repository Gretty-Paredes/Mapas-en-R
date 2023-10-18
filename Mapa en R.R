
library(leaflet)
library(leaflet.extras)
library(htmlwidgets)
library(sf)
library(tidyverse)
library(cptcity)


mapa1 <- read.table("https://raw.githubusercontent.com/Gretty-Paredes/Mapas-en-R/master/Mapas%20Interactivos/13-provincias.txt",header =TRUE,sep=",")

#Generando el mapa 
mapa1 %>%
leaflet() %>%
  addTiles() %>%
  addHeatmap(data= mapa1,lat=mapa1$Latitud,lng=mapa1$Altitud,radius=9)%>%
  addMiniMap()%>%
  addResetMapButton()
  

# Colores y nombres de etiqueta
colores <- c('#a6cee3', '#1f78b4', '#b2df8a', '#33a02c', '#fb9a99', '#e31a1c',
             '#fdbf6f', '#ff7f00', '#cab2d6', '#6a3d9a', '#ffff99', '#b15928')
provin <- levels(as.factor(mapa1$Provincia))

# Cambiando color
paleta <- colorFactor(palette = colores, domain = provin)

leaflet() %>% 
  addTiles() %>% 
  addCircleMarkers(data =mapa1, lat = ~Latitud, lng = ~Altitud,
                   color = ~paleta(Provincia), fill = 1,popup =~Provincia, label = ~Capital,group = "Provincias")%>%
  addMiniMap()%>%
  addResetMapButton()
#Leyenda
m <- leaflet() %>% 
  addTiles() %>% 
  addCircleMarkers(data =mapa1, lat = ~Latitud, lng =~Altitud,
                   color = ~paleta(Provincia), fill = 1,popup =paste(sep="<br>","<br><strong>Provincia:</strong>",mapa1$Provincia,
                                                                     "<br><strong>Capital:</strong>",mapa1$Capital,"<br><strong>Distritos:</strong>",mapa1$Distrito))%>%
  addMiniMap()%>%
  addResetMapButton()
m <- m %>% 
  addLegend(data = mapa1, position =  "bottomleft", pal = paleta,
            values = ~Provincia, title = "Provincias", opacity = 1,
            group = "Leyenda")
m
