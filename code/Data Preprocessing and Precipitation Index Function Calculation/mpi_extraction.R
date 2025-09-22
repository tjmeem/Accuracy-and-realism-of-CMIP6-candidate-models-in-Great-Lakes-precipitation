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
lakes<- c("Dates","Superior","Ontario","Michigan","Huron","Erie")
setwd("C:/Users/tamee/Downloads/MPI/ssp370/pr")
list_mpi<- list.files(pattern = ".nc")
for (i in 1:5){
  p<- rotate(brick(list_mpi[i]))
  n<- paste0("mpi_f_",i)
  assign(n,t(as.data.frame(raster::extract(p,region,fun=mean))))
  
}
mpi_full<- rbind(mpi_f_1,mpi_f_2,mpi_f_3,mpi_f_4,mpi_f_5)
for (i in 1:31411){
  mpi_full[i,1:5] <- 86400*mpi_full[i,1:5]
}
for (i in 1:5){
  pa<- (brick(list_mpi[i]))
  np<- paste0("mpi_date_",i)
  assign(np,data.frame(date(getZ(pa))))
  
}
mpi_date<- rbind(mpi_date_1,mpi_date_2,mpi_date_3,mpi_date_4,mpi_date_5)
mpi_ssp370<- cbind(mpi_date,mpi_full)
colnames(mpi_ssp370)<- lakes
write.csv(mpi_ssp370,"C:/Users/tamee/Downloads/new_runs/mpi_ssp370.csv")

setwd("C:/Users/tamee/Downloads/MPI/ssp585/pr")
list_mpi_hm<- list.files(pattern = ".nc")
for (i in 1:5){
  p<- rotate(brick(list_mpi_hm[i]))
  n<- paste0("mpi_f_hm_",i)
  assign(n,t(as.data.frame(raster::extract(p,region,fun=mean))))
  
}
mpi_full_hm<- rbind(mpi_f_hm_1,mpi_f_hm_2,mpi_f_hm_3,mpi_f_hm_4,mpi_f_hm_5)
for (i in 1:31411){
  mpi_full_hm[i,1:5] <- 86400*mpi_full_hm[i,1:5]
}
mpi_ssp585<- cbind(mpi_date,mpi_full_hm)
colnames(mpi_ssp585)<- lakes
write.csv(mpi_ssp585,"C:/Users/tamee/Downloads/new_runs/mpi_ssp585.csv")

source("C:/Users/tamee/Downloads/PI.R")
setwd("C:/Users/tamee/Downloads/new_runs/MPI")
p_c<- c(6:8)

regP<-precip_trace(Pdat=mpi_ssp370[,2:6], 
                   m_c=p_c, 
                   time= mpi_ssp370$Date,
                   out_path=("./ssp370/"))

regP<-precip_trace(Pdat=mpi_ssp585[,2:6], 
                   m_c=p_c, 
                   time= mpi_ssp585$Date,
                   out_path=("./ssp585/"))

#setwd("C:/Users/tamee/Downloads/MPI/historical/v20190710")
setwd("C:/Users/tamee/Downloads/Zg/MPI/pr/precip")
list_mpi_h<- list.files(pattern = ".nc")

for (i in 1:8){
  p<- rotate(brick(list_mpi_h[i]))
  n<- paste0("mpi_hist_",i)
  assign(n,t(as.data.frame(raster::extract(p,region,fun=mean))))
  
}
mpi_hist<- rbind(mpi_hist_1, mpi_hist_2, mpi_hist_3,mpi_hist_4,mpi_hist_5,mpi_hist_6,mpi_hist_7,mpi_hist_8)
for (i in 1:14610){
  mpi_hist[i,1:5] <- 86400*mpi_hist[i,1:5]
}
for (i in 1:8){
  pa<- (brick(list_mpi_h[i]))
  np<- paste0("mpi_date_hist_",i)
  assign(np,data.frame(date(getZ(pa))))
  
}
mpi_hist_date<- rbind(mpi_date_hist_1,mpi_date_hist_2,mpi_date_hist_3,mpi_date_hist_4,mpi_date_hist_5,mpi_date_hist_6,mpi_date_hist_7,mpi_date_hist_8)
mpi_historical<- cbind(mpi_hist_date,mpi_hist)
mpi_historical<- mpi_historical
colnames(mpi_historical)<- lakes
mpi_historical_filtered <- mpi_historical %>%
  filter(year(Dates) > 1978)

setwd("C:/Users/tamee/Downloads/new_runs/MPI")
regP<-precip_trace(Pdat=mpi_historical_filtered[,2:6], 
                   m_c=p_c, 
                   time= mpi_historical_filtered$Date,
                   out_path=("./HR/"))

write.csv(mpi_historical_filtered,"C:/Users/tamee/Downloads/new_runs/mpi_historical.csv")
