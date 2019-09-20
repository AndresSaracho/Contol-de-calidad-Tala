source("precipitacion_analisis_mensual.R")
library(hydroTSM)


hydroplot(p1176_z, var.type="Precipitation", main="Palomas",
          pfreq = "dm", from="2005-12-09")


hydroplot(p1257_z, var.type="Precipitation", main="Itapebi",
          pfreq = "dm", from="2005-12-09")

hydroplot(p1232_z, var.type="Precipitation", main="Valentin",
          pfreq = "dm", from="2005-12-09")

hydroplot(pjunco_z, var.type="Precipitation", main="Junco",
          pfreq = "dm", from="2005-12-09")

hydroplot(pINIA_z, var.type="Precipitation", main="INIA",
          pfreq = "dm", from="2005-12-09")

# Cantidad de datos por años de cada estacion

datos_Palomas = dwi(p1176_z)
datos_Itapebi = dwi(p1257_z)
datos_Valentin = dwi(p1232_z)
datos_junco = dwi(pjunco_z)
datos_INIA = dwi(pINIA_z)

# Cantidad de datos por mes de cada año
dwi(pINIA_z, out.unit="mpy")
View(pINIA_z)
( m <- daily2monthly(pINIA_z, FUN=sum) )

dates <- time(pINIA_z)

( nyears <- yip(from=start(pINIA_z), to=end(pINIA_z), out.type="nmbr" ) )
smry(pINIA_z)
# Daily zoo to monthly zoo
m <- daily2monthly(pINIA_z, FUN=sum, na.rm=TRUE)
# Creating a matrix with monthly values per year in each column
M <- matrix(pINIA_m, ncol=12, byrow=TRUE)
colnames(M) <- c("")
rownames(M) <- c("2005","2006","2007","2008","2009","2010","2011","2012","2013","2014","2015","2016","2017","2018")
require(lattice)
print(matrixplot(M, ColorRamp="Precipitation",
                 main="Monthly precipitation at Palomas st., [mm/month]"))
View(M)
View(pINIA_m)
