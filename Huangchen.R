library(sf)
library(dplyr)
library(countrycode)
library(tidyverse)
library(here)
library(readr)
library(janitor)
library(tmap)
library(tmaptools)

gii <- read.csv("C:/Users/ASUS/OneDrive - University College London/桌面/lecture 1 GIS/wk4/home/GII.CSV")

Diff <- gii %>%
  mutate(Gii_Diff = gii_2019 - gii_2010)
print(Diff)

world_shp <- st_read("C:/Users/ASUS/OneDrive - University College London/桌面/lecture 1 GIS/wk4/home/World_Countries_(Generalized)_2402777631520798174/World_Countries_Generalized.shp")

names(world_shp)
names(Diff)
world_cleaned<- world_shp %>%
  janitor::clean_names(.)

World_Gii <- world_cleaned %>%
  dplyr::left_join(Diff, by = "country")
print(World_Gii)

tmap_mode("view")

tm_shape(World_Gii)+
  tm_polygons("Gii_Diff",
              style="jenks",
              palette="YlOrBr",
              midpoint=NA,
              title="GII_Diff",
              alpha =0.5)+
  tm_compass(position=c("left","bottom"),type = "arrow")+
  tm_scale_bar(position=c("left", "bottom"))+
  tm_layout(title = "GII Difference 2010-2019 Situation all over the world")
