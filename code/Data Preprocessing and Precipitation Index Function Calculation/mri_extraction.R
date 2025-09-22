library(sp)
library(sf)
library(ncdf4)
library(rgdal)
library(lubridate)
library(dplyr)
library(raster)
library(reshape2)
library(tidyverse)

setwd("C:/Users/tamee/Downloads/MRI")
mri<- list.files(pattern=".nc")
setwd("C:/Users/tamee/Downloads/greatlakes")
region<- st_read("greatlakes_subbasins.shp") 
shp =readOGR(dsn=".",layer = "greatlakes_subbasins")
e<- extent(region)

p1<- brick(mri[1])
p1<- rotate(p1)

mri_glk<- t(data.frame(raster::extract(p1,region,fun=mean)))
mri_dt<- data.frame(date(getZ(p1)))
colnames(mri_dt)<- c("Date")
for (i in 1:18262){
  mri_glk[i,1:5] <- 86400* mri_glk[i,1:5]
}
lakes<- c("Superior","Ontario","Michigan","Huron","Erie")
colnames(mri_glk)<- lakes
mri_full<- cbind(mri_dt,mri_glk)

p2<- brick(mri[2])
p2<- rotate(p2)

mri_glk1<- t(data.frame(raster::extract(p2,region,fun=mean)))
mri_dt1<- data.frame(date(getZ(p2)))
colnames(mri_dt1)<- c("Date")
for (i in 1:5479){
  mri_glk1[i,1:5] <- 86400* mri_glk1[i,1:5]
}
colnames(mri_glk1)<- lakes
mri_full1<- cbind(mri_dt1,mri_glk1)
mri_historical<- rbind(mri_full,mri_full1)
mri_hist<- mri_historical%>%
  filter(year(Date)>1978)
write.csv(mri_hist,"C:/Users/tamee/Downloads/MRI/mri_hist.csv")

setwd("C:/Users/tamee/Downloads/MRI/ssp370")
mri_f<- list.files(pattern=".nc")

for (i in 1:2){
  p<- raster::rotate(brick(mri_f[i]))
  n<- paste0("pr",i)
  assign(n,t(data.frame(raster::extract(p,region,fun=mean))))
  
}                                               
future_pr<- rbind(pr1,pr2)

for (i in 1:2){
  a<- (brick(mri_f[i]))
  b<- paste0("mri_f_dt_",i)
  (assign(b,(data.frame(date(getZ(a))))))
  
}
mri_f_date<- rbind(mri_f_dt_1,mri_f_dt_2)
colnames(mri_f_date)<- c("Date")
for (i in 1:31411){
  future_pr[i,1:5] <- 86400* future_pr[i,1:5]
}
colnames(future_pr)<- lakes
mri_ssp370<- cbind(mri_f_date,future_pr)
write.csv(mri_ssp370,"C:/Users/tamee/Downloads/MRI/mri_ssp370.csv")

mri_f1<- list.files(pattern=".nc")
for (i in 1:2){
  a<- (brick(mri_f1[i]))
  b<- paste0("mri_f1_dt_",i)
  (assign(b,(data.frame(date(getZ(a))))))
  
}
mri_f1_dt<- rbind(mri_f1_dt_1,mri_f1_dt_2)
colnames(mri_f1_dt)<- c('Dates')

for (i in 1:2){
  p<- raster::rotate(brick(mri_f1[i]))
  n<- paste0("pr",i)
  assign(n,t(data.frame(raster::extract(p,region,fun=mean))))
  
}        
mri_ssp585<- rbind(pr1,pr2)
colnames(mri_ssp585)<- lakes
mri_ssp585<- cbind(mri_f1_dt,mri_ssp585)
for (i in 1:31411){
  mri_ssp585[i,2:6] <- 86400* mri_ssp585[i,2:6]
}
write.csv(mri_ssp585,"C:/Users/tamee/Downloads/MRI/mri-new_ssp585.csv")
