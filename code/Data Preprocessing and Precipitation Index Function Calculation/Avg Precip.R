library(sp)
library(sf)
library(ncdf4)
library(rgdal)
library(lubridate)
library(dplyr)
library(raster)
library(reshape2)
library(tidyverse)
source("C:/Users/tamee/Downloads/PI.R")
#bcc
setwd("C:/Users/tamee/Downloads/greatlakes")
region<- st_read("greatlakes_subbasins.shp") 

setwd("C:/Users/tamee/Downloads/bcc")
bcc<- list.files(pattern=".nc")
p1<- brick(bcc[1])
p1<- raster::rotate(p1)
bcc_glk<- t(data.frame(raster::extract(p1,region,fun=mean)))
bcc_dt<- data.frame(date(getZ(p1)))
colnames(bcc_dt)<- c("Date")
lakes<- c("Superior","Ontario","Michigan","Huron","Erie")
colnames(bcc_glk)<-lakes
bcc_all<- cbind(bcc_glk,bcc_dt)
bcc_all$year<- year(bcc_dt$Date)
bcc<- bcc_all%>%
  filter((bcc_all$year)>1978)

for (i in 1:13140){
  bcc[i,1:5] <- 86400* bcc[i,1:5]
}
write.csv(bcc,'C:/Users/tamee/Downloads/bcc/bcc_historical.csv')

bcc<- read.csv('bcc_historical.csv')
bcc_avg<- data.frame(rowMeans(bcc[,2:6]))
colnames(bcc_avg)<- c('bcc')

regP<-precip_trace(Pdat=bcc[,2:6], 
                   m_c= c(6:8), 
                   time= bcc$Date,
                   out_path=("./historical/"))
#CanESM
setwd("C:/Users/tamee/Downloads/CanESM")
can<- list.files(pattern=".nc")
p2<- brick(can[1])
p2_rotate<- raster::rotate(p2)
can_glk<- t(data.frame(raster::extract(p2_rotate,region,fun=mean)))
lakes<- c("Superior","Ontario","Michigan","Huron","Erie")
colnames(can_glk)<-lakes
can_dt<- data.frame(date(getZ(p2_rotate)))
colnames(can_dt)<- c("Date")
can_all<- cbind(can_glk,can_dt)
can_all$year<- year(can_dt$Date)
can_esm<- can_all%>%
  filter((can_all$year)>1978)

for (i in 1:13140){
  can_esm[i,1:5] <- 86400* can_esm[i,1:5]
}

write.csv(can_esm,'C:/Users/tamee/Downloads/CanESM/canesm_historical.csv')
can_esm<- read.csv('canesm_historical.csv')
can_avg<- data.frame(rowMeans(can_esm[,1:5]))
colnames(can_avg)<- ('can_esm')
regP<-precip_trace(Pdat=can_esm[,2:6], 
                   m_c= c(6:8), 
                   time= can_esm$Date,
                   out_path=("./historical/"))
#gfdl
setwd("C:/Users/tamee/Downloads/gfdl")

gfdl_list<- list.files(pattern=".nc")
for (i in 1:3){
  p<- raster::rotate(brick(gfdl_list[i]))
  n<- paste0("gfdl_",i)
  assign(n,t(data.frame(raster::extract(p,region,fun=mean))))
  
}   

gfdl_glk<- rbind(gfdl_1,gfdl_2,gfdl_3)
colnames(gfdl_glk)<- lakes
for (i in 1:3){
  a<- (brick(gfdl_list[i]))
  b<- paste0("gfdl_dt_",i)
  (assign(b,(data.frame(date(getZ(a))))))
  
}
gfdl_date<- rbind(gfdl_dt_1,gfdl_dt_2,gfdl_dt_3)
colnames(gfdl_date)<- "Date"
gfdl_all<- cbind(gfdl_glk,gfdl_date)
gfdl_all$year<- year(gfdl_all$Date)

gfdl_filtered<- gfdl_all%>%
  filter(year>1978)
for (i in 1:13140){
  gfdl_filtered[i,1:5] <- 86400* gfdl_filtered[i,1:5]
}

write.csv(gfdl_filtered,'C:/Users/tamee/Downloads/gfdl/gfdl_historical.csv')
gfdl_filtered<- read.csv('gfdl_historical.csv')
gfdl_avg<- data.frame(rowMeans(gfdl_filtered[,1:5]))
colnames(gfdl_avg)<- "gfdl"

regP<-precip_trace(Pdat=gfdl_filtered[,2:6], 
                   m_c= c(6:8), 
                   time=gfdl_filtered$Date,
                   out_path=("./historical/"))
#inm
setwd("C:/Users/tamee/Downloads/inm")

inm_list<- list.files(pattern=".nc")
for (i in 1:2){
  p<- raster::rotate(brick(inm_list[i]))
  n<- paste0("inm_",i)
  assign(n,t(data.frame(raster::extract(p,region,fun=mean))))
  
}   

inm_glk<- rbind(inm_1,inm_2)
colnames(inm_glk)<- lakes
for (i in 1:2){
  a<- (brick(inm_list[i]))
  b<- paste0("inm_dt_",i)
  (assign(b,(data.frame(date(getZ(a))))))
  
}
inm_date<- rbind(inm_dt_1,inm_dt_2)
colnames(inm_date)<- "Date"
inm_all<- cbind(inm_glk,inm_date)
inm_all$year<- year(inm_all$Date)

inm_filtered<- inm_all%>%
  filter(year>1978)
for (i in 1:13140){
  inm_filtered[i,1:5] <- 86400* inm_filtered[i,1:5]
}

inm_avg<- data.frame(rowMeans(inm_filtered[,1:5]))
inm_avg$date<- inm_filtered$Date
colnames(inm_avg)<- ('inm')
write.csv(inm_filtered,'C:/Users/tamee/Downloads/inm/inm_historical.csv')
inm_filtered<- read.csv('inm_historical.csv')
regP<-precip_trace(Pdat=inm_filtered[,2:6], 
                   m_c= c(6:8), 
                   time= bcc$Date,
                   out_path=("./historical/"))

mean1<- cbind(bcc_avg,can_avg,gfdl_avg,inm_avg)
mean_sup1<-cbind(bcc$Superior,can_esm$Superior,gfdl_filtered$Superior,inm_filtered$Superior,inm_filtered$Date)
mean_ont1<-cbind(bcc$Ontario,can_esm$Ontario,gfdl_filtered$Ontario,inm_filtered$Ontario,inm_filtered$Date)
mean_huron1<- cbind(bcc$Huron,can_esm$Huron,gfdl_filtered$Huron,inm_filtered$Huron,inm_filtered$Date)
mean_erie1<- cbind(bcc$Erie,can_esm$Erie,gfdl_filtered$Erie,inm_filtered$Erie,inm_filtered$Date)
mean_michigan1<- cbind(bcc$Michigan,can_esm$Michigan,gfdl_filtered$Michigan,inm_filtered$Michigan,inm_filtered$Date)

colnames(mean_sup1)<- c('bcc','can_esm','gfdl','inm','date')
colnames(mean_ont1)<- c('bcc','can_esm','gfdl','inm','date')
colnames(mean_huron1)<- c('bcc','can_esm','gfdl','inm','date')
colnames(mean_erie1)<- c('bcc','can_esm','gfdl','inm','date')
colnames(mean_michigan1)<- c('bcc','can_esm','gfdl','inm','date')

#ec

setwd("C:/Users/tamee/Downloads/ec_earth/historical/pr")
list_ec_hist<- list.files(pattern='.nc')
for (i in 1:36){
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

setwd("C:/Users/tamee/Downloads/new_runs/")
ec_historical<- read.csv('ec_historical.csv')
ec_avg<- data.frame(rowMeans(ec_historical[,3:7]))
colnames(ec_avg)<- 'ec_earth'

#mpi
setwd("C:/Users/tamee/Downloads/MPI/historical/v20190710")

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
                   out_path=("./"))
mpi_historical_filtered<- read.csv('mpi_historical.csv')
mpi_avg<- data.frame(rowMeans(mpi_historical_filtered[,3:7]))
colnames(mpi_avg)<- "mpi"

#MRI
setwd("C:/Users/tamee/Downloads/mri")

mri_list<- list.files(pattern=".nc")
for (i in 1:2){
  p<- raster::rotate(brick(mri_list[i]))
  n<- paste0("mri_",i)
  assign(n,t(data.frame(raster::extract(p,region,fun=mean))))
  
}   

mri_glk<- rbind(mri_1,mri_2)
colnames(mri_glk)<- lakes
for (i in 1:2){
  a<- (brick(mri_list[i]))
  b<- paste0("mri_dt_",i)
  (assign(b,(data.frame(date(getZ(a))))))
  
}
mri_date<- rbind(mri_dt_1,mri_dt_2)
colnames(mri_date)<- "Date"
mri_all<- cbind(mri_glk,mri_date)
mri_all$year<- year(mri_all$Date)

mri_filtered<- mri_all%>%
  filter(year>1978)
for (i in 1:13140){
  mri_filtered[i,1:5] <- 86400* mri_filtered[i,1:5]
}
setwd("C:/Users/tamee/Downloads")

mri_filtered<- read.csv("mri_historical.csv")
mri_avg<- data.frame(rowMeans(mri_filtered[,3:7]))
colnames(mri_avg)<- ('mri')
write.csv(mri_filtered,'C:/Users/tamee/Downloads/mri/mri_historical.csv')

#access
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
access_history_filtered<- read.csv('access_historical.csv')
access_avg<- data.frame(rowMeans(access_history_filtered[,3:7]))
colnames(access_avg)<- "access"
access_avg$date<- access_history_filtered$Date
source("C:/Users/tamee/Downloads/PI.R")
setwd("C:/Users/tamee/Downloads/new_runs/access")
p_c<- c(6:8)
regP<-precip_trace(Pdat=access_historical_filtered[,2:6], 
                   m_c=p_c, 
                   time= access_historical_filtered$Date,
                   out_path=("./historical/"))

#miroc

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
setwd("C:/Users/tamee/Downloads/new_runs")
p_c<- c(6:8)
regP<-precip_trace(Pdat=miroc_historical[,2:6], 
                   m_c=p_c, 
                   time= miroc_historical$Date,
                   out_path=("./historical/"))

miroc_historical<- read.csv('miroc_historical.csv')
miroc_avg<- data.frame(rowMeans(miroc_historical[,3:7]))
colnames(miroc_avg)<- 'miroc'
mean2<- cbind(access_avg,ec_avg,mpi_avg,mri_avg,miroc_avg)
mean_sup2<- cbind(access_history_filtered$Superior,ec_historical$Superior,mpi_historical_filtered$Superior,mri_filtered$Superior,miroc_historical$Superior,miroc_historical$Date)

mean_ont2<- cbind(access_history_filtered$Ontario,ec_historical$Ontario,mpi_historical_filtered$Ontario,mri_filtered$Ontario,miroc_historical$Ontario,miroc_historical$Date)
mean_michigan2<-cbind(access_history_filtered$Michigan,ec_historical$Michigan,mpi_historical_filtered$Michigan,mri_filtered$Michigan,miroc_historical$Michigan,miroc_historical$Date)
mean_huron2<- cbind(access_history_filtered$Huron,ec_historical$Huron,mpi_historical_filtered$Huron,mri_filtered$Huron,miroc_historical$Huron,miroc_historical$Date)
mean_erie2<- cbind(access_history_filtered$Erie,ec_historical$Erie,mpi_historical_filtered$Erie,mri_filtered$Erie,miroc_historical$Erie,miroc_historical$Date)

colnames(mean_sup2)<- c("access","ec_earth","mpi","mri","miroc","date")
colnames(mean_ont2)<- c("access","ec_earth","mpi","mri","miroc","date")
colnames(mean_michigan2)<- c("access","ec_earth","mpi","mri","miroc","date")
colnames(mean_huron2)<- c("access","ec_earth","mpi","mri","miroc","date")
colnames(mean_erie2)<- c("access","ec_earth","mpi","mri","miroc","date")

mean1<- mean1 %>%
mutate(date=as.character(date))
  
mean_nine<- inner_join(mean1,mean2,by='date')
mean_superior_nine<- inner_join(mean_sup1,mean_sup2,by='date')
#cnrm
setwd("C:/Users/tamee/Downloads/greatlakes")
region<- st_read("greatlakes_subbasins.shp") 
setwd("C:/Users/tamee/Downloads/cnrm")
cnrm_list<- list.files(pattern=".nc")
p3<- brick(cnrm_list[1])
p3_rotate<- rotate(p3)
lakes<- c("Superior","Ontario","Michigan","Huron","Erie")
cnrm_glk<- t(data.frame(raster::extract(p3_rotate,region,fun=mean)))
colnames(cnrm_glk) <- lakes
cnrm_dt<- data.frame(date(getZ(p3)))
colnames(cnrm_dt)<- c("Date")
cnrm_all<- cbind(cnrm_glk,cnrm_dt)
cnrm_all$year<- year(cnrm_dt$Date)

cnrm_filtered<- cnrm_all%>%
  filter(year>1978)
for (i in 1:13149){
  cnrm_filtered[i,1:5] <- 86400* cnrm_filtered[i,1:5]
}

write.csv(cnrm_filtered,"cnrm_historical.csv")
cnrm_filtered<- read.csv("cnrm_historical.csv")

cnrm_avg<- data.frame(rowMeans(cnrm_filtered[,1:5]))
cnrm_avg$date<- cnrm_filtered$Date
colnames(cnrm_avg)<- c("cnrm","date")

regP<-precip_trace(Pdat=cnrm_filtered[,2:6], 
                   m_c=c(6:8), 
                   time= cnrm_filtered$Date,
                   out_path=("./historical/"))

#ukesm
setwd("C:/Users/tamee/Downloads/ukesm")
ukesm_list<- list.files(pattern=".nc")
p4<- brick(ukesm_list[1])
p4_rotate<- rotate(p4)
lakes<- c("Superior","Ontario","Michigan","Huron","Erie")
ukesm_glk<- t(data.frame(raster::extract(p4_rotate,region,fun=mean)))
colnames(ukesm_glk) <- lakes
ukesm_dt<- data.frame(date(getZ(p4)))
colnames(ukesm_dt)<- c("Date")
ukesm_all<- cbind(ukesm_glk,ukesm_dt)
ukesm_all$year<- year(ukesm_dt$Date)
ukesm_filtered<- ukesm_all%>%
  filter(year>1978)

for (i in 1:12960){
  ukesm_filtered[i,1:5] <- 86400* ukesm_filtered[i,1:5]
}

ukesm_avg<- data.frame(rowMeans(ukesm_filtered[,1:5]))
colnames(ukesm_avg)<- 'ukesm'
ukesm_avg$date<- ukesm_filtered$Date
write.csv(ukesm_filtered,"ukesm_historical.csv")
ukesm<- read.csv('ukesm_historical.csv')
regP<-precip_trace(Pdat=ukesm[,2:6], 
                   m_c=c(6:8), 
                   time= ukesm$Date,
                   out_path=("./historical/"))

#ipsl
setwd("C:/Users/tamee/Downloads/ipsl")
ipsl_list<- list.files(pattern=".nc")
p5<- brick(ipsl_list[1])
p5_rotate<- rotate(p5)

lakes<- c("Superior","Ontario","Michigan","Huron","Erie")
ipsl_glk<- t(data.frame(raster::extract(p5_rotate,region,fun=mean)))
colnames(inm_glk) <- lakes
ipsl_dt<- data.frame(date(getZ(p5)))
colnames(ipsl_dt)<- c("Date")
ipsl_all<- cbind(ipsl_glk,ipsl_dt)
ipsl_all$year<- year(ipsl_dt$Date)
ipsl_filtered<- ipsl_all%>%
  filter(year>1978)

for (i in 1:13149){
  ipsl_filtered[i,1:5] <- 86400* ipsl_filtered[i,1:5]
}
ipsl_avg<- data.frame(rowMeans(ipsl_filtered[,1:5]))
colnames(ipsl_avg)<-'ipsl'
write.csv(ipsl_filtered,"ipsl_historical.csv")
ipsl<- read.csv('ipsl_historical.csv')
colnames(ipsl)<- c("X","Superior","Ontario","Michigan","Huron","Erie","Date","Year")
mean3<- cbind(cnrm_avg,ipsl_avg)
mean_sup3<- cbind(cnrm_filtered$Superior,ipsl$Superior,ipsl$Date)
mean_ont3<- cbind(cnrm_filtered$Ontario,ipsl$Ontario,ipsl$Date)
mean_huron3<- cbind(cnrm_filtered$Huron,ipsl$Huron,ipsl$Date)
mean_michigan3<- cbind(cnrm_filtered$Michigan,ipsl$Michigan,ipsl$Date)
mean_erie3<- cbind(cnrm_filtered$Erie,ipsl$Erie,ipsl$Date)


colnames(mean_sup3)<- colnames(mean_ont3)<- colnames(mean_huron3)<- colnames(mean_michigan3)<- colnames(mean_erie3)<- c('cnrm_esm','ipsl','date')
ukesm_avg<- ukesm_avg%>%
  mutate(date=as.character(date))

ukesm_sup<- cbind(ukesm$Superior,ukesm$Date)
ukesm_ont<- cbind(ukesm$Ontario,ukesm$Date)
ukesm_mich<- cbind(ukesm$Michigan,ukesm$Date)
ukesm_huron<- cbind(ukesm$Huron,ukesm$Date)
ukesm_erie<- cbind(ukesm$Erie,ukesm$Date)

colnames(ukesm_sup)<- colnames(ukesm_ont)<- colnames(ukesm_mich)<- colnames(ukesm_huron)<- colnames(ukesm_erie)<- c("ukesm","date")
superior <- data.frame(mean_sup1) %>%
  inner_join(data.frame(mean_sup2), by = "date") %>%
  inner_join(data.frame(mean_sup3), by = "date") %>%
  inner_join(data.frame(ukesm_sup), by ='date')
superior <- superior %>%
  select(-date, date) 

Ontario <- data.frame(mean_ont1) %>%
  inner_join(data.frame(mean_ont2), by = "date") %>%
  inner_join(data.frame(mean_ont3), by = "date")%>%
  inner_join(data.frame(ukesm_ont), by ="date")
Ontario <- Ontario %>%
  select(-date, date) 


Huron<- data.frame(mean_huron1) %>%
  inner_join(data.frame(mean_huron2), by = "date") %>%
  inner_join(data.frame(mean_huron3), by = "date")%>%
  inner_join(data.frame(ukesm_huron), by ="date")
Huron <- Huron %>%
  select(-date, date) 


Michigan<- data.frame(mean_michigan1) %>%
  inner_join(data.frame(mean_michigan2), by = "date") %>%
  inner_join(data.frame(mean_michigan3), by = "date")%>%
  inner_join(data.frame(ukesm_mich), by ="date")

Michigan <- Michigan %>%
  select(-date, date) 


Erie<- data.frame(mean_erie1) %>%
  inner_join(data.frame(mean_erie2), by = "date") %>%
  inner_join(data.frame(mean_erie3), by = "date")%>%
  inner_join(data.frame(ukesm_erie), by ="date")

Erie <- Erie %>%
  select(-date, date) 


mean4<- inner_join(mean3,ukesm_avg,by='date')

setwd("C:/Users/tamee/Downloads/cpc/")
cpc_hist<- list.files(pattern='.nc')
for (i in 1:36){
  p<- (brick(list_ec_hist[i]))
  n<- paste0("cpc_historical_",i)
  assign(n,t(as.data.frame(raster::extract(p,region,fun=mean))))
}
cpc_pr_h<- ls(pattern= "cpc_historical_")
cpc_historic= data.frame()
for (i in 1:36){
  
  df <- get(cpc_pr_h[i])
  cpc_historic <- rbind(cpc_historic,df)
}

for (i in 1:36){
  pa<- brick(list_cpc_hist[i])
  np<- paste0("cpc_historical_date_",i)
  assign(np,data.frame(date(getZ(pa))))
  
}
cpc_pr_h<- ls(pattern= "cpc_historical_date_")
cpc_historic_date= data.frame()
for (i in 1:36){
  
  df <- get(cpc_pr_h[i])
  cpc_historic_date <- rbind(cpc_historic_date,df)
}
cpc_historical<- cbind(cpc_historic_date,cpc_historic)
colnames(cpc_historical)<- lakes
for (i in 1:13149){
  cpc_historical[i,2:6] <- 86400*cpc_historical[i,2:6]
}

setwd("C:/Users/tamee/Downloads/new_runs/")
cpc_historical<- read.csv('cpc_historical.csv')
cpc_avg<- data.frame(rowMeans(cpc_historical[,3:7]))
cpc_avg$date<- ec_historical$Date
colnames(cpc_avg)<- c('cpc','date')

mean4<- read.csv('mean.csv')
mean_model<- inner_join(mean_nine,mean4,by='date')
mean_model<- mean_model[,-11]
mean_updated<- inner_join(mean_model,cpc_avg,by='date')
mean_updated$year<- year(mean_updated$date)
mean_updated$month<- month(mean_updated$date)

write.csv(mean_updated,'C:/Users/tamee/Downloads/new_runs/mean_updated.csv')
write.csv(superior,'C:/Users/tamee/Downloads/Basins/superior.csv')
write.csv(Ontario,'C:/Users/tamee/Downloads/Basins/ontario.csv')
write.csv(Huron,'C:/Users/tamee/Downloads/Basins/huron.csv')
write.csv(Michigan,'C:/Users/tamee/Downloads/Basins/michigan.csv')
write.csv(Erie,'C:/Users/tamee/Downloads/Basins/erie.csv')
setwd("C:/Users/tamee/Downloads/Basins")
superior[,1:12] <- lapply(superior[,1:12], function(x) as.numeric(as.character(x)))

Ontario[,1:12] <- lapply(Ontario[,1:12], function(x) as.numeric(as.character(x)))

Michigan[,1:12] <- lapply(Michigan[,1:12], function(x) as.numeric(as.character(x)))
Huron[,1:12] <- lapply(Huron[,1:12], function(x) as.numeric(as.character(x)))

Erie[,1:12] <- lapply(Erie[,1:12], function(x) as.numeric(as.character(x)))
regP<-precip_trace(Pdat=Erie[,1:12], 
                   m_c=c(6:8), 
                   time= Erie$date,
                   out_path=("./Erie/"))

#Combine the precipitation anomalies for selected models
setwd("C:/Users/tamee/Downloads/precip_anomalies/cpc")

cpc_sai<- read.csv('SAI_s6_8.csv')
cpc_avg<- apply(cpc_sai, 1, mean, na.rm = TRUE)

setwd("C:/Users/tamee/Downloads/precip_anomalies/mpi")

mpi_sai<- read.csv('SAI_s6_8.csv')
mpi_avg<- apply(mpi_sai, 1, mean, na.rm = TRUE)

setwd("C:/Users/tamee/Downloads/precip_anomalies/mri")
mri_sai<- read.csv('SAI_s6_8.csv')
mri_avg<- apply(mri_sai, 1, mean, na.rm = TRUE)

setwd("C:/Users/tamee/Downloads/precip_anomalies/ec_earth")

ec_sai<- read.csv('SAI_s6_8.csv')
ec_avg<- apply(ec_sai, 1, mean, na.rm = TRUE)

setwd("C:/Users/tamee/Downloads/precip_anomalies/miroc")

miroc_sai<- read.csv('SAI_s6_8.csv')
miroc_avg<- apply(miroc_sai, 1, mean, na.rm = TRUE)

setwd("C:/Users/tamee/Downloads/precip_anomalies/access")

access_sai<- read.csv('SAI_s6_8.csv')
access_avg<- apply(access_sai, 1, mean, na.rm = TRUE)

precip_anomalies<- cbind(cpc_avg,ec_avg,mpi_avg,mri_avg,access_avg,miroc_avg)
colnames(precip_anomalies)<- c('CPC','EC_EARTH','MPI','MRI','ACCESS','MIROC')
write.csv(precip_anomalies,'C:/Users/tamee/Downloads/precip_anomalies/precip_anomalies.csv')
