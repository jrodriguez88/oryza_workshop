# Script Practica 1 -  Analisis y creacion de datos climaticos
# Source of Weather data: IDEAM - Col
# Author: Rodriguez-Espinoza J.


## 1. Cargar paquetes
library(tidyverse)
library(lubridate)
library(data.table)
library(skimr)
source("https://raw.githubusercontent.com/jrodriguez88/csmt/master/write_files/write_wth_oryza.R", encoding = "UTF-8")



## 2. leer datos

data <- read_csv("practica_1/data/TEST_wth.csv")    # SDTO
metadata <- read_tsv("practica_1/data/info.txt")
localidad <- "TEST"

## 3. Analizar datos

#Graficar clima

data %>%  
  group_by(year = year(date), month = month(date)) %>%
  summarise(rain = sum(rain), 
            tmin = mean(tmin), 
            tmax = mean(tmax), 
            srad = mean(srad), 
            rhum = mean(rhum)) %>% 
  ungroup() %>% gather(var, value, -c(year, month)) %>%
  ggplot(aes(factor(month), value)) + 
  geom_boxplot() + 
  facet_wrap(~var, scales = "free") + 
  labs(x = "mes", title = paste("promedios mesuales de", localidad)) +
  theme_bw()

skimr::skim(data)


## 4. Crear ORYZA WTH file para un solo año o periodo

### ORYZA weather file, include:

#  Column    Daily Value                                                                         
#     1      Station number                                                                       
#     2      Year                                                                           
#     3      Day                                                                    
#     4      irradiance         KJ m-2 d-1                                            
#     5      min temperature            oC                                                        
#     6      max temperature            oC                                                        
#     7      vapor pressure            kPa                                                        
#     8      mean wind speed         m s-1                                                        
#     9      precipitation          mm d-1

# filtrar para un año . Ejemplo = 2015
data_2015 <- data %>% filter(year(date) == 2015) 

# Organizar datos en orden
data_2015_oryza <- data_2015 %>%
  mutate(stn = 1, 
         Year = year(date),
         Day = yday(date), 
         irrad = round(srad*1000, 2),
         tmin = round(tmin, 2),
         tmax = round(tmax, 2),
         vpd = -99,
         wsp = -99,
         rain = round(rain, 2)) %>% 
  select(stn, Year, Day, irrad, tmin, tmax, vpd, wsp, rain)

# Guardar como csv
write_csv(data_2015_oryza, "practica_1/output/data_2016.csv")

## ---> Trabajar en editor de texto


## Funcion para crear multiples archivos ORYZA-WTH  --> https://github.com/jrodriguez88/csmt 


## Ejecutar la funcion

## Para un solo año
write_wth_oryza(data_2015, "practica_1/output/", localidad, 3.91, -75.0, 415, stn = 1)

## Para una serie historica
write_wth_oryza(data, "practica_1/output/", localidad , 3.91, -75.0, 415, stn = 1)
  


