
rm(list=ls())

library(zoo)

#lectura de datos

#                 estacion itapebi 1980-02-01 a 2017-07-02
p1257 = read.csv("./Datos/1257_Colonia_Itapebi.csv")
p1257$Fecha = as.Date(p1257$Fecha,"%Y-%m-%d")
summary(p1257$Fecha)

# estacion itapebi con datos del 2016-01-01 al 2019-02-28

p1257_02 = read.table("./Datos/Datos_procesados/ColoniaItapebi.txt",sep="\t", header=T)
p1257_02$Fecha = as.Date(p1257_02$Fecha,"%d/%m/%Y")
head(p1257_02)
p1257_02 <- p1257_02[ ,-c(1,2)]
names (p1257_02) = c("Fecha","Precip")
View(p1257_02)
summary(p1257_02$Fecha)
#############################################################################################


#                 estacion Palomas 1981-01-05 al 2011-12-31

p1176 = read.csv("./Datos/1176-141.csv")
p1176$Fecha = as.Date(p1176$Fecha,"%Y-%m-%d")
summary(p1176$Fecha)

#                 estacion Palomas con periodos del 2016-01-01 al 2019-02-28

p1176_02 = read.table("./Datos/Datos_procesados/Palomas.txt",sep="\t", header=T)
p1176_02$Fecha = as.Date(p1257_02$Fecha,"%d/%m/%Y")
head(p1176_02)
p1176_02 <- p1176_02[ ,-c(1,2)]
names (p1176_02) = c("Fecha","Precip")
summary(p1176_02)
#View(p1176_02)

#############################################################################################


#                 estacion Valentin p.bazzini 1981-01-02 al 2011-12-31

p1232 = read.csv("./Datos/1232-144.csv")
p1232$Fecha = as.Date(p1232$Fecha,"%Y-%m-%d")
summary(p1232$Fecha)

#                 estacion Biassini desde 2016-01-01 al 2019-02-28

p1232_02 = read.table("./Datos/Datos_procesados/Biassini.txt",sep="\t", header=T)
p1232_02$Fecha = as.Date(p1232_02$Fecha,"%m/%d/%Y")
head(p1232_02)
p1232_02 <- p1232_02[ ,-c(1,2)]
names (p1232_02) = c("Fecha","Precip")
summary(p1232_02)

#############################################################################################

#                 estacion Laureles  

#p1321 = read.table("./Datos/Datos_procesados/Laureles.txt",sep="\t", header=T)
#p1321$Fecha = as.Date(p1321$Fecha,"%d/%m/%Y")
#head(p1321)
#p1321 <- p1321[ ,-c(1,2)]
#names (p1321) = c("Fecha","Precip")
#View(p1321)

#############################################################################################


#                 estacion Junco
pjunco = read.csv("./Datos/clima.csv")
#pjunco$ï..FECHA = as.Date(pjunco$ï..FECHA, "%m/%d/%Y")
# se debe evitar el uso de caracteres raros porque genera problemas cuando el codigo se lee con otras funciones
colnames(pjunco)[1] = "Fecha"
pjunco$Fecha = as.Date(pjunco$Fecha, "%m/%d/%Y")

#                 estacion INIA
pINIA = read.table("./Datos/lluvia_INIA.txt",sep="\t", header=T)
pINIA$Fecha = as.Date(pINIA$Fecha,"%d/%m/%Y")

#############################################################################################

View(p1257)
View(p1176)
View(p1232)
View(pjunco)
View(pINIA)

##### Elimino columnas que no voy a utilizar y renombro ###### 

pjunco <- pjunco[ ,-c(2,3,4,5,6,8,9,10,11,12,13)]
names (pjunco) = c("Fecha","Precip")
View(pjunco)


pINIA <- pINIA[ ,-c(2)]
names(pINIA) = c("Fecha","Precip")
View(pINIA)


head(p1257)
head(p1176)
head(p1232)
head(pjunco)
head(pINIA)


################conver zoo#################################

p1257_z = zoo(p1257$Precip, p1257$Fecha)
p1257_z2 = zoo(p1257_02$Precip, p1257_02$Fecha)

#p1321_z = zoo(p1321$Precip, p1321$Fecha)

p1176_z = zoo(p1176$Precip, p1176$Fecha)
p1176_z2 = zoo(p1176_02$Precip, p1176_02$Fecha)



p1232_z = zoo(p1232$Precip, p1232$Fecha)
p1232_z2 = zoo(p1232_02$Precip, p1232_02$Fecha)


#pjunco_z = zoo(pjunco$mm, pjunco$ï..FECHA)


pjunco_z = zoo(pjunco$Precip, pjunco$Fecha)
pINIA_z = zoo(pINIA$Precip, pINIA$Fecha)



#acotar el periodo 2005>2019 de estaciones de periodos anteriores al 2016
p1257_z = window(p1257_z, start="2005-12-09", end="2022-12-31")
p1176_z = window(p1176_z, start = "2005-12-09", end = "2022-12-31")
p1232_z = window(p1232_z, start = "2005-12-09", end = "2022-12-31")
#p1321_z = window(p1321_z, start = "2005-12-09", end = "2022-12-31")


pjunco_z = window(pjunco_z, start = "2005-12-09", end = "2022-12-31")
pINIA_z = window(pINIA_z, start = "2005-12-09", end = "2022-12-31")

#acoto periodo en segundas estaciones para luego tener solo una serie para cada estacion 
p1257_z2 = window(p1257_z2, start="2017-07-03", end="2022-12-31")
p1176_z2 = window(p1176_z2, start = "2012-1-1", end = "2022-12-31")
p1232_z2 = window(p1232_z2, start = "2012-1-1", end = "2022-12-31")

# uno datos
p1257_z = rbind(p1257_z, p1257_z2)
p1176_z = rbind(p1176_z, p1176_z2)
p1232_z = rbind(p1232_z, p1232_z2)


#diario a mensual
p1257_m = aggregate(p1257_z, as.yearmon, sum)
p1176_m = aggregate(p1176_z, as.yearmon, sum)
p1232_m = aggregate(p1232_z, as.yearmon, sum)

#p1321_m = aggregate(p1321_z, as.yearmon, sum)
pjunco_m = aggregate(pjunco_z, as.yearmon, sum )
pINIA_m = aggregate(pINIA_z, as.yearmon, sum)

#View(p1257_m)
#View(p1176_m)
#View(p1232_m)
#View(pjunco_m)
#View(pINIA_m)
