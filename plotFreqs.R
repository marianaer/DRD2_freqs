library(maptools) #
library(ggplot2) #
library(scatterpie) #

setwd("/home/mescobar/Escritorio/DRD2/freqs/") 

rs_List <- c("rs1076560", "rs2283265", "rs1125394", "rs4648318", "rs12364283", "rs11214608")

freq.plot <- function(rsID) {
  
  rs <- read.table(paste(rsID, ".frq.strat", sep = ""), header = T, colClasses = c("numeric", rep("character", 4), rep("numeric", 3)))
  x <- c(21, -106, -86, 83, 105, 130, -56, 79, 20)
  y <- c(7, 28.6, 12, 55, 35, -25, -15, 21, 47)
  coords <- cbind(x, y)
  rs <- cbind(rs, coords, 1-rs[6])
  names(rs)[11]<- "MajAF"
  minor_Allele<-rs[1,4]
  major_Allele<-rs[1,5]

  # ORA SÍ ESTE ES EL CHIDO
  pdf(paste(rsID,"Frq.pdf", sep="")) 
  worldmap <- map_data ("world")
  mapplot1 <- ggplot(worldmap) +
    geom_map(data = worldmap, map = worldmap, aes(x = long, y = lat, map_id = region), fill = "gray70") +
    geom_scatterpie(aes(x = x, y = y), data = rs, cols = c("MAF", "MajAF")) + coord_fixed() +
    scale_fill_manual(values = c("#153E7E", "#6698FF"), labels=c(minor_Allele, major_Allele)) +
    labs(title = rsID, x = "Longitude", y = "Latitude", fill="", subtitle= "Allelic Frequency") +
    theme(legend.position = "top", plot.subtitle=element_text(color="#153E7E", face="bold"), plot.title=element_text(face="bold"))
    
  print(mapplot1)
  dev.off()
  #return(mapplot1)
}

lapply(rs_List[1:6], FUN = freq.plot)
