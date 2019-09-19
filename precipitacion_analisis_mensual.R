library(zoo)

#lectura de datos

#                 estacion itapebi
p1257 = read.csv("./Datos/1257_Colonia_Itapebi.csv")
p1257$Fecha = as.Date(p1257$Fecha,"%Y-%m-%d")


#                 estacion Palomas
p1176 = read.csv("./Datos/1176-141.csv")
p1176$Fecha = as.Date(p1176$Fecha,"%Y-%m-%d")

#                 estacion Valentin p.bazzini
p1232 = read.csv("./Datos/1232-144.csv")
p1232$Fecha = as.Date(p1232$Fecha,"%Y-%m-%d")

#                 estacion Junco
pjunco = read.csv("./Datos/clima.csv")
pjunco$ï..FECHA = as.Date(pjunco$ï..FECHA, "%m/%d/%Y")

#                 estacion INIA
pINIA = read.table("./Datos/lluvia_INIA.txt",sep="\t", header=T)
pINIA$Fecha = as.Date(pINIA$Fecha,"%d/%m/%Y")



################conver zoo#################################

p1257_z = zoo(p1257$Precip, p1257$Fecha)
p1176_z = zoo(p1176$Precip, p1176$Fecha)
p1232_z = zoo(p1232$Precip, p1232$Fecha)
pjunco_z = zoo(pjunco$mm, pjunco$ï..FECHA)
pINIA_z = zoo(pINIA$PrecAcum, pINIA$Fecha)



#acotar el periodo 2005>2019
p1257_z = window(p1257_z, start="2005-12-09", end="2022-12-31")
p1176_z = window(p1176_z, start = "2005-12-09", end = "2022-12-31")
p1232_z = window(p1232_z, start = "2005-12-09", end = "2022-12-31")
pjunco_z = window(pjunco_z, start = "2005-12-09", end = "2022-12-31")
pINIA_z = window(pINIA_z, start = "2005-12-09", end = "2022-12-31")

#diario a mensual
p1257_m = aggregate(p1257_z, as.yearmon, sum)
p1176_m = aggregate(p1176_z, as.yearmon, sum)
p1232_m = aggregate(p1232_z, as.yearmon, sum)
pjunco_m = aggregate(pjunco_z, as.yearmon, sum )
pINIA_m = aggregate(pINIA_z, as.yearmon, sum)

