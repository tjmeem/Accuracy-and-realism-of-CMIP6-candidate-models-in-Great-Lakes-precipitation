library(sp)
library(sf)
library(ncdf4)
library(rgdal)
library(lubridate)
library(dplyr)
library(raster)
library(reshape2)
library(tidyverse)

setwd("C:/Users/tamee/Downloads/greatlakes")
region<- st_read("greatlakes_subbasins.shp") 
shp =readOGR(dsn=".",layer = "greatlakes_subbasins")
e<- extent(region)

setwd("C:/Users/tamee/Downloads/Ec_earth/pr_150/")
list_ec<- list.files(pattern = ".nc")
for (i in 1:86){
  p<- rotate(brick(list_ec[i]))
  n<- paste0("ec_f_",i)
  assign(n,t(as.data.frame(raster::extract(p,region,fun=mean))))
  
}
ec_pr<- ls(pattern= "ec_f_")
ec_future= data.frame()
for (i in 1:86){
  
  df <- get(ec_pr[i])
  ec_future <- rbind(ec_future,df)
}
for (i in 1:31411){
  ec_future[i,1:5] <- 86400*ec_future[i,1:5]
}

for (i in 1:86){
  pa<- brick(list_ec[i])
  np<- paste0("ec_date_",i)
  assign(np,data.frame(date(getZ(pa))))
  
}
ec_dt<- ls(pattern= "ec_date_")
ec_date= data.frame()
for (i in 1:86){
  
  df <- get(ec_dt[i])
  ec_date <- rbind(ec_date,df)
}
ec_ssp370<- cbind(ec_date,ec_future)
lakes<- c("Date","Superior","Ontario","Michigan","Huron","Erie")
colnames(ec_ssp370)<- lakes
write.csv(ec_ssp370,"C:/Users/tamee/Downloads/Ec_earth/ssp370/pr150/ec_ssp370.csv")

setwd("C:/Users/tamee/Downloads/ec_earth/ssp585/pr")
list_ec_ssp585<- list.files(pattern = ".nc")
for (i in 1:86){
  p<- rotate(brick(list_ec_ssp585[i]))
  n<- paste0("ec_hm_",i)
  assign(n,t(as.data.frame(raster::extract(p,region,fun=mean))))
  
}
ec_pr_hm<- ls(pattern= "ec_hm_")
ec_future_hm= data.frame()
for (i in 1:86){
  
  df <- get(ec_pr_hm[i])
  ec_future_hm <- rbind(ec_future_hm,df)
}
for (i in 1:31411){
  ec_future_hm[i,1:5] <- 86400*ec_future_hm[i,1:5]
}
ec_ssp585<- cbind(ec_date,ec_future_hm)
colnames(ec_ssp585) <- lakes
write.csv(ec_ssp585,"C:/Users/tamee/Downloads/new_runs/ec_ssp585.csv")
source("C:/Users/tamee/Downloads/PI.R")
setwd("C:/Users/tamee/Downloads/new_runs/ec_earth")
p_c<- c(6:8)
regP<-precip_trace(Pdat=ec_ssp370[,2:6], 
                   m_c=p_c, 
                   time= ec_ssp370$Date,
                   out_path=("./ssp370/"))

regP<-precip_trace(Pdat=ec_ssp585[,2:6], 
                   m_c=p_c, 
                   time= ec_ssp585$Date,
                   out_path=("./ssp585/"))

setwd("C:/Users/tamee/Downloads/ec_earth/historical/pr")
list_ec_hist<- list.files(pattern='.nc')
for (i in 130:165){
  p<- rotate(brick(list_ec_hist[i]))
  n<- paste0("ec_historical_",i)
  assign(n,t(as.data.frame(raster::extract(p,region,fun=mean))))
}
ec_pr_h<- ls(pattern= "ec_historical_")
ec_historic= data.frame()
for (i in 1:36){
  
  df <- get(ec_pr_h[i])
  ec_historic <- rbind(ec_historic,df)
}

for (i in 130:165){
  pa<- brick(list_ec_hist[i])
  np<- paste0("ec_historical_date_",i)
  assign(np,data.frame(date(getZ(pa))))
  
}
ec_pr_h<- ls(pattern= "ec_historical_date_")
ec_historic_date= data.frame()
for (i in 1:36){
  
  df <- get(ec_pr_h[i])
  ec_historic_date <- rbind(ec_historic_date,df)
}
ec_historical<- cbind(ec_historic_date,ec_historic)
colnames(ec_historical)<- lakes
for (i in 1:13149){
  ec_historical[i,2:6] <- 86400*ec_historical[i,2:6]
}

write.csv(ec_historical,"C:/Users/tamee/Downloads/new_runs/ec_historical.csv")

setwd("C:/Users/tamee/Downloads/new_runs/ec_earth")
regP<-precip_trace(Pdat=ec_historical[,2:6], 
                   m_c=p_c, 
                   time= ec_historical$Date,
                   out_path=("./historical/"))
