

setwd( "C:/Users/jdlecy/Dropbox/02 - CLASSES/02 - MASTERS/09 - DDM II/SYR Parcels" )

library( maptools )
library( sp )

syr <- readShapePoly( fn="01-05-2015", proj4string=CRS("+proj=longlat +datum=WGS84") )

plot( syr,  border="gray80" )

# extract the parcel data as a data frame:

dat <- as.data.frame( syr )

names( dat )



class( dat$YearBuilt )

dat$YearBuilt <- as.numeric( as.character( dat$YearBuilt ))

summary( dat$YearBuilt )

dat$YearBuilt[ dat$YearBuilt == 0 ] <- NA

# create color ramp

color.function <- colorRampPalette( c("firebrick4","light gray","darkblue" ) )

col.ramp <- color.function( 7 ) # number of groups you desire

# create the color vector

eras <- c(0,1900,1920,1940,1960,1980,2000,2015)
  
col.vec <- as.character( cut( dat$YearBuilt, breaks=eras, labels=col.ramp ) )

# plot the choropleth map

par( mar=c(0,0,1,0) )
# par( mfrow=c(1,1) )
plot( syr, col=col.vec, border=NA, main="Age of Buildings" )

legend.text=c("1800-1900","1901-1920","1921-1941","1941-1960","1961-1980","1981-2000","2001-2015")

legend( "bottomright", bg="white",
        pch=19, pt.cex=1.5, cex=0.7,
        legend=legend.text, 
        col=col.ramp, 
        box.col="white",
        title="Period of Construction" 
       )