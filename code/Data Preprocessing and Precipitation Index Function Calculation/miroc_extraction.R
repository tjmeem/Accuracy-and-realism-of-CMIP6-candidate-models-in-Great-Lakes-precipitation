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

setwd("C:/Users/tamee/Downloads/miroc_es2l/ssp370/pr")
list_miroc<- list.files(pattern = ".nc")
for (i in 1:86){
  p<- rotate(brick(list_miroc[i]))
  n<- paste0("miroc_f_",i)
  assign(n,t(as.data.frame(raster::extract(p,region,fun=mean))))
  
}
miroc_pr<- ls(pattern= "miroc_f_")
miroc_future= data.frame()
for (i in 1:86){
  
  df <- get(miroc_pr[i])
  miroc_future <- rbind(miroc_future,df)
}
for (i in 1:31411){
  miroc_future[i,1:5] <- 86400*miroc_future[i,1:5]
}

for (i in 1:86){
  pa<- brick(list_miroc[i])
  np<- paste0("miroc_date_",i)
  assign(np,data.frame(date(getZ(pa))))
  
}
miroc_dt<- ls(pattern= "miroc_date_")
miroc_date= data.frame()
for (i in 1:86){
  
  df <- get(miroc_dt[i])
  miroc_date <- rbind(miroc_date,df)
}
miroc_ssp370 <- cbind(miroc_date,miroc_future)
colnames(miroc_ssp370)<- lakes
write.csv(miroc_ssp370,"C:/Users/tamee/Downloads/new_runs/miroc_ssp370.csv")

setwd("C:/Users/tamee/Downloads/miroc_es2l/ssp585/pr")
list_miroc_ssp585<- list.files(pattern = ".nc")
for (i in 1:86){
  p<- rotate(brick(list_miroc_ssp585[i]))
  n<- paste0("miroc_hm_",i)
  assign(n,t(as.data.frame(raster::extract(p,region,fun=mean))))
  
}
miroc_pr_hm<- ls(pattern= "miroc_hm_")
miroc_future_hm= data.frame()
for (i in 1:86){
  
  df <- get(miroc_pr_hm[i])
  miroc_future_hm <- rbind(miroc_future_hm,df)
}
for (i in 1:31411){
  miroc_future_hm[i,1:5] <- 86400*miroc_future_hm[i,1:5]
}
miroc_ssp585<- cbind(miroc_date,miroc_future_hm)
colnames(miroc_ssp585)<- lakes
write.csv(miroc_ssp585,"C:/Users/tamee/Downloads/new_runs/miroc_ssp585.csv")
source("C:/Users/tamee/Downloads/PI.R")
setwd("C:/Users/tamee/Downloads/new_runs/miroc")
p_c<- c(6:8)
regP<-precip_trace(Pdat=miroc_ssp370[,2:6], 
                   m_c=p_c, 
                   time= miroc_ssp370$Date,
                   out_path=("./ssp370/"))

regP<-precip_trace(Pdat=miroc_ssp585[,2:6], 
                   m_c=p_c, 
                   time= miroc_ssp585$Date,
                   out_path=("./ssp585/"))
setwd("C:/Users/tamee/Downloads/miroc_es2l/historical/v20191129/pr")
miroc_list_h<- list.files(pattern= ".nc")
for (i in 130:165){
  p<- rotate(brick(miroc_list_h[i]))
  n<- paste0("miroc_historical_",i)
  assign(n,t(as.data.frame(raster::extract(p,region,fun=mean))))
}
miroc_pr_h<- ls(pattern= "miroc_historical_")
miroc_historic= data.frame()
for (i in 2:37){
  
  df <- get(miroc_pr_h[i])
  miroc_historic <- rbind(miroc_historic,df)
}

for (i in 130:165){
  pa<- brick(miroc_list_h[i])
  np<- paste0("miroc_historical_date_",i+1849)
  assign(np,data.frame(date(getZ(pa))))
  
}
miroc_pr_h<- ls(pattern= "miroc_historical_date_")
miroc_historic_date= data.frame()
for (i in 1:36){
  
  df <- get(miroc_pr_h[i])
  miroc_historic_date <- rbind(miroc_historic_date,df)
}
miroc_historical<- cbind(miroc_historic_date,miroc_historic)
colnames(miroc_historical)<- lakes
for (i in 1:13149){
  miroc_historical[i,2:6] <- 86400*miroc_historical[i,2:6]
}
write.csv(miroc_historical,"C:/Users/tamee/Downloads/new_runs/miroc_historical.csv")
setwd("C:/Users/tamee/Downloads/new_runs/miroc")
p_c<- c(6:8)
regP<-precip_trace(Pdat=miroc_historical[,2:6], 
                   m_c=p_c, 
                   time= miroc_historical$Date,
                   out_path=("./historical/"))
