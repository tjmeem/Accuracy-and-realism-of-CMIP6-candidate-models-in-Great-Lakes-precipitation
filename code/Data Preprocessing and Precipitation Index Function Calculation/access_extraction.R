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

setwd("C:/Users/tamee/Downloads/access/ssp370/pr")
list_access<- list.files(pattern = ".nc")

for (i in 1:2){
  p<- rotate(brick(list_access[i]))
  n<- paste0("access_f_",i)
  assign(n,t(as.data.frame(raster::extract(p,region,fun=mean))))
  
}
access_full<- rbind(access_f_1,access_f_2)
for (i in 1:31411){
  access_full[i,1:5] <- 86400*access_full[i,1:5]
}
for (i in 1:2){
  pa<- (brick(list_access[i]))
  np<- paste0("access_date_",i)
  assign(np,data.frame(date(getZ(pa))))
  
}
access_date<- rbind(access_date_1,access_date_2)
access_ssp370<- cbind(access_date,access_full)
colnames(access_ssp370)<- lakes
write.csv(access_ssp370,"C:/Users/tamee/Downloads/new_runs/access_ssp370.csv")

setwd("C:/Users/tamee/Downloads/access/ssp585/pr")
list_access_hm<- list.files(pattern = ".nc")

for (i in 1:2){
  p<- rotate(brick(list_access_hm[i]))
  n<- paste0("access_f_hm",i)
  assign(n,t(as.data.frame(raster::extract(p,region,fun=mean))))
  
}
access_full_585<- rbind(access_f_hm1,access_f_hm2)
for (i in 1:31411){
  access_full_585[i,1:5] <- 86400*access_full_585[i,1:5]
}
access_ssp585<- cbind(access_date,access_full_585)
colnames(access_ssp585)<- lakes
write.csv(access_ssp585,"C:/Users/tamee/Downloads/new_runs/access_ssp585.csv")

source("C:/Users/tamee/Downloads/PI.R")
setwd("C:/Users/tamee/Downloads/new_runs/access")
p_c<- c(6:8)
regP<-precip_trace(Pdat=access_ssp370[,2:6], 
                   m_c=p_c, 
                   time= access_ssp370$Date,
                   out_path=("./ssp370/"))

regP<-precip_trace(Pdat=access_ssp585[,2:6], 
                   m_c=p_c, 
                   time= access_ssp585$Date,
                   out_path=("./ssp585/"))
setwd("C:/Users/tamee/Downloads/access/historical/v20191108/pr")
list_access_hist<- list.files(pattern = 'nc')
for (i in 1:2){
  p<- rotate(brick(list_access_hist[i]))
  n<- paste0("access_hist_",i)
  assign(n,t(as.data.frame(raster::extract(p,region,fun=mean))))
  
}
access_hist_full<- rbind(access_hist_1,access_hist_2)
for (i in 1:23741){
  access_hist_full[i,1:5] <- 86400*access_hist_full[i,1:5]
}
for (i in 1:2){
  pa<- (brick(list_access_hist[i]))
  np<- paste0("access_hist_date_",i)
  assign(np,data.frame(date(getZ(pa))))
  
}
access_hist_date<- rbind(access_hist_date_1,access_hist_date_2)
access_historical<- cbind(access_hist_date,access_hist_full)
colnames(access_historical)<- lakes
access_historical_filtered<- access_historical%>%
  filter(year(access_historical$Date)> 1978)
write.csv(access_historical_filtered,"C:/Users/tamee/Downloads/new_runs/access_historical.csv")

source("C:/Users/tamee/Downloads/PI.R")
setwd("C:/Users/tamee/Downloads/new_runs/access")
p_c<- c(6:8)
regP<-precip_trace(Pdat=access_historical_filtered[,2:6], 
                   m_c=p_c, 
                   time= access_historical_filtered$Date,
                   out_path=("./historical/"))
