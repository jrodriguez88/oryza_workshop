# Script Practica 1.1 -  Estimacion de la radiacion solar
# Source of Weather data: IDEAM - Col
# Author: Rodriguez-Espinoza J.



## 1. Cargar paquetes
library(tidyverse)
library(lubridate)
library(data.table)
library(skimr)
library(sirad)

## Definir nombre y ubicacion de la estacion
localidad <- "test"
lat <- 3.5
lon <- -75.5
alt <- 250


### Leer datos minimos  (date, tmax, tmin, rain)

data <- read_csv("practica_1/data/SDTO_wth_test_minimo.csv") %>% 
  mutate(date = mdy(date))

## Grafica los datos climaticos
data %>%  
  group_by(year = year(date), month = month(date)) %>%
  summarise(rain = sum(rain), 
            tmin = mean(tmin), 
            tmax = mean(tmax)) %>% 
  ungroup() %>% gather(var, value, -c(year, month)) %>%
  ggplot(aes(factor(month), value)) + 
  geom_boxplot() + 
  facet_wrap(~var, scales = "free") + 
  labs(x = "mes", title = paste("promedios mesuales de", localidad)) +
  theme_bw()


## Funcion para calcular radiacion

# data must have "date" and 'sbright' (or 'tmax' and 'tmin') variable,
## A & B parameters from FAO, 
#Frère M, Popov GF. 1979. Agrometeorological crop monitoring and forecasting. Plant
#Production Protection Paper 17. Rome: Food and Agricultural Organization.
#64 p.
# kRs adjustment coefficient (0.16.. 0.19) -- for interior (kRs = 0.16) and coastal (kRs = 0.19) regions

get_srad_mindata <- function(data, lat, lon, alt, A = 0.29, B = 0.45, kRs = 0.175){
  
  stopifnot(require(sirad))
  
  if(!"sbright" %in% colnames(data))
  {
    data <- mutate(data, sbright = NA_real_)   #Aqui crea la variable brillo por si no existe
  }
  
  step1 <- data %>% 
    mutate(
      extraT = extrat(lubridate::yday(date), radians(lat))$ExtraTerrestrialSolarRadiationDaily, # Calcula la radiacion extraterrestre
      srad = ap(date, lat = lat, lon = lon,    # aqui aplica Angstrom-Prescott
                extraT, A, B, sbright),
      srad = if_else(is.na(srad), kRs*sqrt(tmax - tmin)*extraT, srad))  # Aqui aplica Hargreaves
  
  max_srad <- mean(step1$extraT)*0.80     # calcula el maximo teorico de radiacion
  
  step2 <- step1 %>%  
    mutate(
      srad = if_else(srad>max_srad|srad<0|is.na(srad),  median(step1$srad, na.rm = T), srad)) %>%
    dplyr::pull(srad)
  
  return(step2)   # retorna la fuckin radiacion en MJ/m2*dia
  
  
}


# calcula la radiacion para la serie historica
data_sim <- data %>% mutate(srad = get_srad_mindata(data, lat, lon, alt, kRs = 0.16))

### carga datos observados
data_obs <- read_csv("practica_1/data/SDTO_wth.csv")


### Compara resultados
data_obs %>% select(-rhum) %>% mutate(data =  "obs") %>% 
  bind_rows(data_sim %>% mutate(data =  "sim")) %>%  
  group_by(year = year(date), month = month(date), data) %>%
  summarise(srad = mean(srad)) %>% 
  ungroup() %>% gather(var, value, -c(data, year, month)) %>%
  ggplot(aes(factor(month), value)) + 
  geom_boxplot(aes(fill= data)) +
  labs(x = "mes", title = paste("comparacion de promedios mesuales de radiacion - ", localidad)) +
  theme_bw() 











