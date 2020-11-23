# Script Practica 1 -  Analisis y creacion de datos climaticos
# Source of Weather data: IDEAM - Col
# Author: Rodriguez-Espinoza J.


## 1. Cargar paquetes
library(tidyverse)
library(lubridate)
library(data.table)
library(skimr)


## 2. leer datos

data <- read_csv("practica_1/data/SDTO_wth.csv")    # SDTO
#data <- read_csv("practica_1/data/VVME_wth.csv")    # VVME
metadata <- read_tsv("practica_1/data/info.txt")
localidad <- "XXXX"

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

# filtrar para un año . Ejemplo = 2016
data_2016 <- data %>% filter(year(date) == 2016) 

# Organizar datos en orden
data_2016_oryza <- data_2016 %>%
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
write_csv(data_2016_oryza, "practica_1/output/data_2016.csv")

## ---> Trabajar en editor de texto


## Funcion para crear multiples archivos ORYZA-WTH  --> https://github.com/jrodriguez88/csmt 

make_wth_oryza <- function(data, path, local, lat, lon, alt, stn=1) {
  
  stopifnot(require(tidyverse)==T)
  stopifnot(require(lubridate)==T)
  
  DATA <- data %>%
    mutate(DATE = date,
           Station_number = stn,
           Year = year(DATE),
           Day = yday(DATE),
           SRAD = round(srad*1000, 2),
           TMAX = round(tmax, 2),
           TMIN = round(tmin, 2),
           RAIN = round(rain, 2),
           VPD = -99, 
           WS = -99) %>%
    select(Station_number, Year, Day, SRAD, TMIN, TMAX, VPD, WS, RAIN)
  
  
  
  dir.create(paste0(path,"/WTH"), showWarnings = FALSE)
  set_head <- paste(lon, lat, alt, 0, 0, sep = ",")    
  #DATA=read.table(file, head=T)  
  data_list <- split(DATA, DATA$Year)
  lapply(data_list, function(x){
    fname <- paste(path,"/WTH/" ,local, stn,".", str_sub(unique(x$Year), 2), sep = "")
    sink(file=fname)
    cat(set_head)
    cat("\n")
    write.table(x ,sep=",",row.names=F,col.names=F)
    sink()})
  
}


## Ejecutar la funcion

## Para un solo año
make_wth_oryza(data_2016, "practica_1/output/", localidad, 3.91, -75.0, 415, stn = 1)

## Para una serie historica
make_wth_oryza(data, "practica_1/output/", localidad , 3.91, -75.0, 415, stn = 1)
  

