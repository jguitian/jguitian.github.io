---
title: "About"
output: html_document
---


Appointments 

•	2022 Postdoc Position.[Centro de Investigacións Mariñas (CIM-UVIGO)](https://cim.uvigo.gal/en/){target="_blank"}, GEOMA Group, __University of Vigo__ 

•	2021 Researcher. Department of Plant Biology and Soil Sciences. __University of Vigo__ 

•	2017-2020 Doctoral researcher. Climate Geology Group. Earth Sciences Department. __ETH Zürich__ 

•	2015-2016 Research Assistant. Department of Geology. __University of Oviedo__ 


Education

•	2017 – 2020, Ph.D. in Earth Sciences. __ETH Zurich__

• 2014 – 2015, M.Sc. in Oceanography. __University of Vigo__

•	2009 – 2014, Licentiate Degree in Geology. __University of Salamanca__
              4rd year BSc Geology. __University of Edinburgh__







```{r pressure, message=FALSE, echo=FALSE}
library(ggmap)
library(tidyverse)
library(sf)
library(ggspatial)
library(tmaptools)
library(leaflet)
library(sf)
library(readxl)
my_data <- read_excel("locations.xlsx")
locations <- data.frame(lon = my_data$x, lat = my_data$y, 
                        nombre = my_data$Name,
                        id = my_data$description, 
                        tipo = my_data$gid, 
                        link = my_data$link)

points_sf <- st_as_sf(locations, coords = c("lon", "lat"), crs = 4326)


my_data$gidLvl <- cut(my_data$gid, c(1,2,3,4,5),
                      labels = c('Work', 'Conference', 'Fieldtrip', 'Research Stay','Project Meeting'))
gidcol <- colorFactor(palette = 'RdYlGn', my_data$gidLvl)


?popupOptions()

n <- leaflet() %>%
  addTiles() %>%  
  addCircleMarkers(data = points_sf,  
                   color =  ~ifelse(tipo == "1", 'red', 'blue'),
                   radius = ~ifelse(tipo == "1", 20, 10),
                   fillOpacity = 0.5,
                   label = locations$id,
                                  clusterOptions = markerClusterOptions(showCoverageOnHover = TRUE,
                                  zoomToBoundsOnClick = TRUE,
                                   spiderfyOnMaxZoom = TRUE,
                                     removeOutsideVisibleBounds = TRUE,
                                         spiderLegPolylineOptions = list(weight = 1.5, color = "#222", opacity = 0.5),
                                           freezeAtZoom = FALSE))

                   



n %>% addProviderTiles("OpenTopoMap", group = "Topo") %>%
  addProviderTiles("Esri.WorldImagery", group = "Satelite") %>%
  addLayersControl(
    baseGroups = c("Satelite", "Topo", "OSM"),
    overlayGroups = c("Prados"),
    options = layersControlOptions(collapsed = FALSE)
  )









```

