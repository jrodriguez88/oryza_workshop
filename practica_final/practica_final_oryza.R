## Practica final curso ORYZA - Crear ambientes y Experimentos
# Author: Rodriguez-Espinoza J.
# 2020


## 1. Cargar herramientas

source("https://raw.githubusercontent.com/jrodriguez88/csmt/master/utils/utils_crop_model.R", encoding = "UTF-8")
source("https://raw.githubusercontent.com/jrodriguez88/csmt/master/write_files/write_wth_oryza.R", encoding = "UTF-8")
source("https://raw.githubusercontent.com/jrodriguez88/csmt/master/write_files/write_soil_oryza.R", encoding = "UTF-8")
source("https://raw.githubusercontent.com/jrodriguez88/csmt/master/write_files/write_exp_oryza.R", encoding = "UTF-8")
source("https://raw.githubusercontent.com/jrodriguez88/csmt/master/run_tools/run_drates_param.R", encoding = "UTF-8")
source("https://raw.githubusercontent.com/jrodriguez88/csmt/master/run_tools/extract_drates_param.R", encoding = "UTF-8")

## Cargar e instalar paquetes
## Load Package
inpack(c("tidyverse", "data.table", "lubridate", "plotly", "soiltexture", "Hmisc", "sirad"))
setwd(dir = 'practica_final/')
download_ORYZA_Tools()

########### Dirigirse a Session --> Set Working Directory --- > To Project Directory

# Read data
data <- read_INPUT_data("practica_final/data/F2000.xlsx")
loc <- data$AGRO_man %>% select(LOC_ID, LAT, LONG, ALT) %>% distinct() %>% rename(loc_id = LOC_ID)
cultivar <- "F2000"

# subset wth data
wth_data <- data$WTH_obs %>% set_names(tolower(colnames(.))) %>% 
  mutate(date = as.Date(date)) %>% nest(-loc_id) #group_split(id) %>% set_names(c("CONO", "VACA", "VAIR"))


##Crear Archivos climaticos
left_join(loc, wth_data) %>% mutate(path = "practica_final/", stn = 1) %>%
  rename(lat = LAT, lon =  LONG, alt = ALT, id = loc_id) %>%
  select(data, path, id, lat, lon, alt, stn) %>%
  mutate(pwalk(., write_wth_oryza))


# subset soil data 
soil_data <- data$SOIL_obs

## Crear archivos de suelo
map(split(soil_data, soil_data$ID), ~write_soil_oryza(., "practica_final/", SATAV = 25))

## Crear experimentales
dir.create("practica_final/EXP/", showWarnings = FALSE)
write_exp_oryza(data, "practica_final/EXP/")
exp_files <- str_subset(list.files("practica_final/EXP", pattern = "\\.exp$"), cultivar)


### split data into calibration set (cal_set) and evaluation set (eval_set), proportion=0.7
set.seed(1234)
cal_set <- sample(exp_files, length(exp_files)*0.60)    
eval_set <- setdiff(exp_files, cal_set)

setwd(dir = 'practica_final/')
run_drates_param(cal_set)
extract_drates_param(cal_set)




