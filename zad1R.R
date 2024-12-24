# район Коньково - докажите что высота родов Тополь и Боярышник значимо отличаются.
greendb = read.csv("greendb.csv")

spec = greendb$species_ru
genus = stringr::str_split(spec, pattern = " ", simplify = T)[,1]

data  = greendb %>% mutate(Genus = genus) 
data = data %>% filter(Genus %in% c("Тополь","Боярышник")) %>%
  filter(adm_region=="район Коньково")

data.aov <- aov(height_m ~ Genus, data = data)

summary(data.aov)
TukeyHSD(data.aov)