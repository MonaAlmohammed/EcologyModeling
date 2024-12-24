library(dplyr)
library(sf)
library(ggplot2)
greendb = read.csv("greendb.csv")
spec = greendb$species_ru
genus = stringr::str_split(spec, pattern = " ", simplify = T)[,1]
greendb$Genus=spec

map = sf::read_sf("moscow.geojson")

#постройте картосхему максимальных диаметров стволов 
#деревьев родов Тополь и Боярышник 

data  = greendb %>% group_by(Genus,adm_region) %>%
  summarise(maxd= max(d_trunk_m,na.rm =T)) %>%
  filter(Genus %in% c("Тополь", "Боярышник" ))


map = map %>% mutate (adm_region = NAME)
map = left_join(map, data, by="adm_region")


ggplot(map)+
  geom_sf(aes(fill=maxd))+
  theme()+
  facet_wrap(~Genus)

