library(sp)
library(sf)
library(ncdf4)
library(rgdal)
library(lubridate)
library(dplyr)
library(raster)
library(reshape2)
library(tidyverse)
setwd("G:/LCS-Filer/ekcarter_r/MW_ClimateChange/Data for frontiers paper")

region<- st_read("greatlakes_subbasins.shp") 
shp =readOGR(dsn=".",layer = "greatlakes_subbasins")
e<- extent(region)
setwd("G:/LCS-Filer/ekcarter_r/MW_ClimateChange/Data for frontiers paper/UKESM1")
ukesm1<- brick("pr_day_UKESM1-0-LL_historical_r1i1p1f1_gn_19500101-20141230.nc")
ukesm1<- rotate(ukesm1)
d1<- data.frame(date(getZ(ukesm1)))
d1$year<- year(d1$date.getZ.ukesm1..)
colnames(d1)<- c("Date","Year")
date_ukesm<- d1%>%
  filter(Year>1978)
ukesm1<- subset(ukesm1,which(d1$Year>1978))
ukesm<- crop(ukesm1,extent(shp))
values(ukesm)<- values(ukesm)*24*3600
ukesm_daliy<-(as.data.frame(ukesm,xy=TRUE))
ukesm_daily_t<- t(ukesm_daliy)
ukesm_d<- data.frame(ukesm_daily_t[-c(1,2),])
ukesm_d$date<- date_ukesm$Date
setwd("E:/MW_ClimateChange/Data for frontiers paper/Daily Precip/")

ukesm_d<- read.csv("ukesm.csv")
      
ukesm_e<- ukesm_d[,-c(1,92)]
ukesm_e$year<- year(ukesm_d$date)
ukesm_e$month<- month(ukesm_d$date)
ukesm_summer_mn<- ukesm_e%>%
  filter(month== 6| month== 7| month ==8)

ukesm_fall_mn<- ukesm_e%>%
  filter(month== 9| month== 10| month ==11)

ukesm_winter_mn<- ukesm_e%>%
  filter(month== 12| month== 1| month ==2)

ukesm_spring_mn<- ukesm_e%>%
  filter(month== 3| month== 4| month ==5)




ukesm_summer<- ukesm_summer_mn[,-92]
ukesm_fall<- ukesm_fall_mn[,-92]
ukesm_winter<- ukesm_winter_mn[,-92]
ukesm_spring<- ukesm_spring_mn[,-92]
write.csv(ukesm_d,"E:/MW_ClimateChange/Data for frontiers paper/Daily Precip/ukesm.csv")

a<- melt(ukesm_summer,id="year")
b<- a%>%
  group_by(year,variable)%>%
  mutate(q95 = quantile(value, 0.90), row = row_number()) %>%
  filter(value <= q95) %>%
  select(-q95) %>%
  spread(year, value) %>%
  select(-row)
b1 <- b%>% 
  
  mutate_all(funs(replace_na(.,0)))

b2 <- b1%>%
  group_by(variable)%>%
  summarise_each(funs(sum))
b3<- t(b2)
b3<- data.frame(b3)
b4<- data.frame(b3[-1,])
b4[] <- lapply(b4, function(x) as.numeric(as.character(x))) 
write.csv(b4,"E:/MW_ClimateChange/Data for frontiers paper/trace_p/ukesm/Extreme_total.csv")
setwd("G:/LCS-Filer/ekcarter_r/MW_ClimateChange/Data for frontiers paper/trace_p/ukesm")
tp_ukesm<- read.csv("TP_s6_8.csv")
ratio_ukesm<- b4/tp_ukesm
write.csv(ratio_ukesm,"G:/LCS-Filer/ekcarter_r/MW_ClimateChange/Data for frontiers paper/trace_p/ukesm/ratio_ukesm.csv")

a1<- reshape2::melt(ukesm_fall,id="year")
z<- a1%>%
  group_by(year,variable)%>%
  mutate(q95 = quantile(value, 0.90), row = row_number()) %>%
  filter(value <= q95) %>%
  select(-q95) %>%
  spread(year, value) %>%
  select(-row)
z1 <- z%>% 
  
  mutate_all(funs(replace_na(.,0)))

z2 <- z1%>%
  group_by(variable)%>%
  summarise_each(funs(sum))
z3<- t(z2)
z3<- data.frame(z3)
z4<- data.frame(z3[-1,])
z4[] <- lapply(z4, function(x) as.numeric(as.character(x))) 
write.csv(z4,"E:/MW_ClimateChange/Data for frontiers paper/trace_p/ukesm/Extreme_total_fall.csv")
setwd("G:/LCS-Filer/ekcarter_r/MW_ClimateChange/Data for frontiers paper/trace_p/ukesm")
tp_ukesm<- read.csv("TP_s6_8.csv")
ratio_ukesm<- b4/tp_ukesm
write.csv(ratio_ukesm,"G:/LCS-Filer/ekcarter_r/MW_ClimateChange/Data for frontiers paper/trace_p/ukesm/ratio_ukesm.csv")
setwd()

source("G:/LCS-Filer/ekcarter_r/MW_ClimateChange/trace.R")

p_c<- c(3:5)
regP<-precip_trace(Pdat=ukesm_d[,1:90], 
                   m_c=p_c, 
                   min_yr=1979, 
                   max_yr=2014, 
                   out_path=("./Data for frontiers paper/trace_p/ukesm/"))
#GFDL
setwd("G:/LCS-Filer/ekcarter_r/MW_ClimateChange/Data for frontiers paper/GFDL-ESM4")
gfdl<- list.files(pattern=".nc")

for (i in 2:4){
  p<- rotate(brick(gfdl[i]))
  n<- paste0("gfdl_",i)
  assign(n,as.data.frame(crop(p,extent(shp)),xy=TRUE))
  
}

dt_gfdl1<- data.frame(date(getZ(brick(gfdl[2]))))
colnames(dt_gfdl1)<- c("Dates")
dt_gfdl2<- data.frame(date(getZ(brick(gfdl[3]))))
colnames(dt_gfdl2)<- c("Dates")
dt_gfdl3<- data.frame(date(getZ(brick(gfdl[4]))))
colnames(dt_gfdl3)<- c("Dates")
dt_gfdl<- rbind(dt_gfdl1,dt_gfdl2,dt_gfdl3)
dt_gfdl$year<- year(dt_gfdl$Dates)
gfdl_2t<- t(gfdl_2)
gfdl_3t<- t(gfdl_3)
gfdl_4t <- t(gfdl_4)
gfdl_dataframe<- rbind(gfdl_2t,gfdl_3t[-c(1:2),],gfdl_4t[-c(1:2),])
gfdl_f<- data.frame(gfdl_dataframe[-c(1,2),])
gfdl_c<- cbind(dt_gfdl,gfdl_f)

gfdl_final<- gfdl_c%>%
  filter(year>1978)
for (i in 1:13140){
  gfdl_final[i,3:167] <- 86400*gfdl_final[i,3:167]
}

gfdl_final<- data.frame(gfdl_final)
gfdl_final$month<- month(gfdl_final$Dates)
write.csv(gfdl_final,"E:/MW_ClimateChange/Data for frontiers paper/Daily Precip/gfdl.csv")
gfdl_final<- read.csv("gfdl.csv")
gfdl_final<- gfdl_final[,-1]
gfdl_summer_month<- gfdl_final%>%
  filter(month==6|month==7|month==8)
gfdl_summer<- gfdl_summer_month[,-c(1,168)]
c<- melt(gfdl_summer,id="year")
c1<- c%>%
  group_by(year,variable)%>%
  mutate(q95 = quantile(value, 0.90), row = row_number()) %>%
  filter(value <= q95) %>%
  select(-q95) %>%
  spread(year, value) %>%
  select(-row)
c2 <- c1%>% 
  
  mutate_all(funs(replace_na(.,0)))

c3<- c2%>%
  group_by(variable)%>%
  summarise_each(funs(sum))
c4<- t(c3)
c4<- data.frame(c4)
c5<- data.frame(c4[-1,])
c5[] <- lapply(c5, function(x) as.numeric(as.character(x))) 
write.csv(c5,"E:/MW_ClimateChange/Data for frontiers paper/trace_p/gfdl/Extreme_total.csv")
setwd("G:/LCS-Filer/ekcarter_r/MW_ClimateChange/Data for frontiers paper/trace_p/gfdl")
tp_gfdl<- read.csv("TP_s6_8.csv")
ratio_gfdl<- c5/tp_gfdl
write.csv(ratio_gfdl,"E:/MW_ClimateChange/Data for frontiers paper/trace_p/gfdl/ratio_s6_8.csv")
source("G:/LCS-Filer/ekcarter_r/MW_ClimateChange/trace.R")
setwd("G:/LCS-Filer/ekcarter_r/MW_ClimateChange")
p_c<- c(6:8)
regP<-precip_trace(Pdat=gfdl_final[,3:167], 
                   m_c=p_c, 
                   min_yr=1979, 
                   max_yr=2014, 
                   out_path=("./Data for frontiers paper/trace_p/gfdl/"))

setwd("G:/LCS-Filer/ekcarter_r/MW_ClimateChange/data/GLADE/historicalP/CanESM")
can<- brick("pr_day_CanESM5_historical_r1i1p1f1_gn_18500101-20141231.nc")
can<- rotate(can)
can_glk<- crop(can,extent(shp))
can_glk_df<- as.data.frame(can_glk,xy=TRUE)
can_dt<- data.frame(date(getZ(can)))
colnames(can_dt)<- c("Date")
can_dt$Year<- year(can_dt$Date)
can_glk_t<- t(can_glk_df)
can_dt_f<- cbind(can_glk_t[-c(1:2),],can_dt)
can_esm<- can_dt_f%>%
  filter(can_dt_f$Year>1978)
for (i in 1:13140){
  can_esm[i,1:28]<- 86400*can_esm[i,1:28]
}
can_esm$month<- month(can_esm$Date)
write.csv(can_esm,"E:/MW_ClimateChange/Data for frontiers paper/Daily Precip/can_esm.csv")
can_esm<- read.csv("can_esm.csv")
can_esm<- can_esm[,-1]
can_esm_summer_month<- can_esm%>%
  filter(month==6|month==7|month==8)
can_summer<- can_esm_summer_month[,-c(29,31)]
d<- melt(can_summer,id="Year")
d1<- d%>%
  group_by(Year,variable)%>%
  mutate(q95 = quantile(value, 0.90), row = row_number()) %>%
  filter(value <= q95) %>%
  select(-q95) %>%
  spread(Year, value) %>%
  select(-row) 

d2 <- d1%>% 
  
  mutate_all(funs(replace_na(.,0)))

d3<- d2%>%
  group_by(variable)%>%
  summarise_each(funs(sum))
d4<- t(d3)
d4<- data.frame(d4)
d5<- data.frame(d4[-1,])
d5[] <- lapply(d5, function(x) as.numeric(as.character(x))) 
write.csv(d5,"E:/MW_ClimateChange/Data for frontiers paper/trace_p/canesm/Extreme_total.csv")
setwd("G:/LCS-Filer/ekcarter_r/MW_ClimateChange/Data for frontiers paper/trace_p/canesm")
tp_canesm<- read.csv("TP_s6_8.csv")
ratio_canesm<- d5/tp_canesm
write.csv(ratio_canesm,"E:/MW_ClimateChange/Data for frontiers paper/trace_p/canesm/ratio_s6_8.csv")

setwd("G:/LCS-Filer/ekcarter_r/MW_ClimateChange")
p_c<- c(6:8)
setwd("G:/LCS-Filer/ekcarter_r/MW_ClimateChange")
regP<-precip_trace(Pdat=can_esm[,1:28], 
                   m_c=p_c, 
                   min_yr=1979, 
                   max_yr=2014, 
                   out_path=("./Data for frontiers paper/trace_p/canesm/"))

#bcc
setwd("G:/LCS-Filer/ekcarter_r/MW_ClimateChange/data/GLADE/historicalP/bcc/pr")
bcc<- brick("pr_day_BCC-ESM1_historical_r1i1p1f1_gn_18500101-20141231.nc")
bcc<- rotate(bcc)
bcc_glk<- crop(bcc,extent(shp))
bcc_glk_df<- as.data.frame(bcc_glk,xy=TRUE)
bcc_dt<- data.frame(date(getZ(bcc)))
colnames(bcc_dt)<- c("Date")
bcc_dt$Year<- year(bcc_dt$Date)
bcc_glk_t<- t(bcc_glk_df)
bcc_glk_f<- cbind(bcc_glk_t[-c(1:2),],bcc_dt)
bcc_final<- bcc_glk_f%>%
  filter(Year>1978)
for (i in 1:13140){
  bcc_final[i,1:28] <- 86400*bcc_final[i,1:28]
}
bcc_final$month<- month(bcc_final$Date)
write.csv(bcc_final,"E:/MW_ClimateChange/Data for frontiers paper/Daily Precip/bcc.csv")
bcc_summer_month<- bcc_final%>%
  filter(month==6|month==7|month==8)
bcc_summer<- bcc_summer_month[,-c(29,31)]
e<- melt(bcc_summer,id="Year")
e1<- e%>%
  group_by(Year,variable)%>%
  mutate(q95 = quantile(value, 0.90), row = row_number()) %>%
  filter(value <= q95) %>%
  select(-q95) %>%
  spread(Year, value) %>%
  select(-row) 

e2 <- e1%>% 
  
  mutate_all(funs(replace_na(.,0)))

e3<- e2%>%
  group_by(variable)%>%
  summarise_each(funs(sum))
e4<- t(e3)
e4<- data.frame(e4)
e5<- data.frame(e4[-1,])
e5[] <- lapply(e5, function(x) as.numeric(as.character(x))) 
write.csv(e5,"E:/MW_ClimateChange/Data for frontiers paper/trace_p/bcc/Extreme_total.csv")
setwd("G:/LCS-Filer/ekcarter_r/MW_ClimateChange/Data for frontiers paper/trace_p/bcc")
tp_bcc<- read.csv("TP_s6_8.csv")
ratio_bcc<- e5/tp_bcc
write.csv(ratio_bcc,"E:/MW_ClimateChange/Data for frontiers paper/trace_p/bcc/ratio_s6_8.csv")


setwd("G:/LCS-Filer/ekcarter_r/MW_ClimateChange")
p_c<- c(3:5)
setwd("G:/LCS-Filer/ekcarter_r/MW_ClimateChange")
regP<-precip_trace(Pdat=bcc_final[,1:28], 
                   m_c=p_c, 
                   min_yr=1979, 
                   max_yr=2014, 
                   out_path=("./Data for frontiers paper/trace_p/Bcc/"))

#cnrm
setwd("G:/LCS-Filer/ekcarter_r/MW_ClimateChange/data/GLADE/historicalP/cnrm-esm2-1")
cnrm<- brick("pr_day_CNRM-ESM2-1_historical_r3i1p1f2_gr_19500101-20141231.nc")
cnrm<- rotate(cnrm)
cnrm_glk<- crop(cnrm,extent(shp))
cnrm_glk_df<- as.data.frame(cnrm_glk,xy=TRUE)
cnrm_glk_t<- t(cnrm_glk_df)
cnrm_dt<- data.frame(date(getZ(cnrm)))
colnames(cnrm_dt)<- c("Date")
cnrm_dt$year<- year(cnrm_dt$Date)
cnrm_f<- cbind(cnrm_glk_t[-c(1,2),],cnrm_dt)
cnrm_final<- cnrm_f %>%
  filter(year>1978)
for (i in 1:13149){
  cnrm_final[i,1:98]<- 86400*cnrm_final[i,1:98]
}
cnrm_final$month<- month(cnrm_final$Date)
write.csv(cnrm_final,"E:/MW_ClimateChange/Data for frontiers paper/Daily Precip/cnrm.csv")
cnrm_final<- read.csv("cnrm.csv")
cnrm_summer_month<- cnrm_final%>%
  filter(month==6|month==7|month==8)
cnrm_summer<- cnrm_summer_month[,-c(1,100,102)]
f<- melt(cnrm_summer,id="year")
f1<- f%>%
  group_by(year,variable)%>%
  mutate(q95 = quantile(value, 0.90), row = row_number()) %>%
  filter(value <= q95) %>%
  select(-q95) %>%
  spread(year, value) %>%
  select(-row) 

f2 <- f1%>% 
  
  mutate_all(funs(replace_na(.,0)))

f3<- f2%>%
  group_by(variable)%>%
  summarise_each(funs(sum))
f4<- t(f3)
f4<- data.frame(f4)
f5<- data.frame(f4[-1,])
f5[] <- lapply(f5, function(x) as.numeric(as.character(x))) 
write.csv(f5,"E:/MW_ClimateChange/Data for frontiers paper/trace_p/cnrm/Extreme_total.csv")
setwd("G:/LCS-Filer/ekcarter_r/MW_ClimateChange/Data for frontiers paper/trace_p/cnrm")
tp_cnrm<- read.csv("TP_s6_8.csv")
ratio_cnrm<- f5/tp_cnrm
write.csv(ratio_cnrm,"E:/MW_ClimateChange/Data for frontiers paper/trace_p/cnrm/ratio_s6_8.csv")

p_c<- c(12,1,2)
setwd("G:/LCS-Filer/ekcarter_r/MW_ClimateChange")
regP<-precip_trace(Pdat=cnrm_final[,1:98], 
                   m_c=p_c, 
                   min_yr=1979, 
                   max_yr=2014, 
                   out_path=("./Data for frontiers paper/trace_p/cnrm/"))
#
setwd("G:/LCS-Filer/ekcarter_r/MW_ClimateChange/data/GLADE/historicalP/INM/pr")
inm_1 <- brick("pr_day_INM-CM4-8_historical_r1i1p1f1_gr1_19500101-19991231.nc")
inm_1<- rotate(inm_1)
inm_2<- brick("pr_day_INM-CM4-8_historical_r1i1p1f1_gr1_20000101-20141231.nc")
inm_2<- rotate(inm_2)
inm_1_glk<- crop(inm_1,extent(shp))
inm_1_glk_df<- as.data.frame(inm_1_glk,xy=TRUE)
inm_1_glk_df_t<- t(inm_1_glk_df)
inm_2_glk<- crop(inm_2,extent(shp))
inm_2_glk_df<- as.data.frame(inm_2_glk,xy=TRUE)
inm_2_glk_df_t<- t(inm_2_glk_df)
inm_glk_df<- rbind(inm_1_glk_df_t,inm_2_glk_df_t[-c(1:2),])
inm_1_dt<- data.frame(date(getZ(inm_1)))
colnames(inm_1_dt)<- c("Dates")
inm_1_dt$year<- year(inm_1_dt$Dates)
inm_2_dt<- data.frame(date(getZ(inm_2)))
colnames(inm_2_dt)<- c("Dates")
inm_2_dt$year<- year(inm_2_dt$Dates)
inm_dt<- rbind(inm_1_dt,inm_2_dt)
inm_full<- cbind(inm_glk_df[-c(1:2),],inm_dt)
inm_final<- inm_full%>%
  filter(year>1978)
for (i in 1:13140){
  inm_final[i,1:63]<- 86400*inm_final[i,1:63]
}
inm_final$month<- month(inm_final$Date)
write.csv(inm_final,"E:/MW_ClimateChange/Data for frontiers paper/Daily Precip/inm.csv")
inm_summer_month<- inm_final%>%
  filter(month==6|month==7|month==8)
inm_summer<- inm_summer_month[,-c(64,66)]
g<- melt(inm_summer,id="year")
g1<- g%>%
  group_by(year,variable)%>%
  mutate(q95 = quantile(value, 0.90), row = row_number()) %>%
  filter(value <= q95) %>%
  select(-q95) %>%
  spread(year, value) %>%
  select(-row) 

g2 <- g1%>% 
  
  mutate_all(funs(replace_na(.,0)))

g3<- g2%>%
  group_by(variable)%>%
  summarise_each(funs(sum))
g4<- t(g3)
g4<- data.frame(g4)
g5<- data.frame(g4[-1,])
g5[] <- lapply(g5, function(x) as.numeric(as.character(x))) 
write.csv(g5,"E:/MW_ClimateChange/Data for frontiers paper/trace_p/inm/Extreme_total.csv")
setwd("G:/LCS-Filer/ekcarter_r/MW_ClimateChange/Data for frontiers paper/trace_p/inm")
tp_inm<- read.csv("TP_s6_8.csv")
ratio_inm<- g5/tp_inm
write.csv(ratio_inm,"E:/MW_ClimateChange/Data for frontiers paper/trace_p/inm/ratio_s6_8.csv")


p_c<- c(12,1,2)
setwd("G:/LCS-Filer/ekcarter_r/MW_ClimateChange")
regP<-precip_trace(Pdat=inm_final[,1:63], 
                   m_c=p_c, 
                   min_yr=1979, 
                   max_yr=2014, 
                   out_path=("./Data for frontiers paper/trace_p/inm/"))
#IPSL
setwd("G:/LCS-Filer/ekcarter_r/MW_ClimateChange/data/GLADE/historicalP/IPSL/v20180803/pr")
ipsl<- brick("pr_day_IPSL-CM6A-LR_historical_r30i1p1f1_gr_18500101-20141231.nc")
ipsl<- rotate(ipsl)
ipsl_glk<- crop(ipsl,extent(shp))
ipsl_glk_df<- as.data.frame(ipsl_glk,xy=TRUE)
ipsl_glk_df_t<- t(ipsl_glk_df)
ipsl_dt<- data.frame(date(getZ(ipsl)))
colnames(ipsl_dt)<- c("Dates")
ipsl_dt$year<- year(ipsl_dt$Dates)
ipsl_full<- cbind(ipsl_glk_df_t[-c(1:2),],ipsl_dt)
ipsl_final<- ipsl_full%>%
  filter(year>1978)
for (i in 1:13149){
  ipsl_final[i,1:72]<- 86400*ipsl_final[i,1:72]
}
ipsl_final$month<- month(ipsl_final$Date)
write.csv(ipsl_final,"E:/MW_ClimateChange/Data for frontiers paper/Daily Precip/ipsl.csv")
ipsl_summer_month<- ipsl_final%>%
  filter(month==6|month==7|month==8)
ipsl_summer<- ipsl_summer_month[,-c(73,75)]
h<- melt(ipsl_summer,id="year")
h1<- h%>%
  group_by(year,variable)%>%
  mutate(q95 = quantile(value, 0.90), row = row_number()) %>%
  filter(value <= q95) %>%
  select(-q95) %>%
  spread(year, value) %>%
  select(-row) 

h2 <- h1%>% 
  
  mutate_all(funs(replace_na(.,0)))

h3<- h2%>%
  group_by(variable)%>%
  summarise_each(funs(sum))
h4<- t(h3)
h4<- data.frame(h4)
h5<- data.frame(h4[-1,])
h5[] <- lapply(h5, function(x) as.numeric(as.character(x))) 
write.csv(h5,"E:/MW_ClimateChange/Data for frontiers paper/trace_p/ipsl/Extreme_total.csv")
setwd("G:/LCS-Filer/ekcarter_r/MW_ClimateChange/Data for frontiers paper/trace_p/ipsl")
tp_ipsl<- read.csv("TP_s6_8.csv")
ratio_ipsl<- h5/tp_ipsl
write.csv(ratio_ipsl,"E:/MW_ClimateChange/Data for frontiers paper/trace_p/ipsl/ratio_s6_8.csv")

p_c<- c(9:11)
setwd("G:/LCS-Filer/ekcarter_r/MW_ClimateChange")
regP<-precip_trace(Pdat=ipsl_final[,1:72], 
                   m_c=p_c, 
                   min_yr=1979, 
                   max_yr=2014, 
                   out_path=("./Data for frontiers paper/trace_p/ipsl/"))
#MRI
setwd("G:/LCS-Filer/ekcarter_r/MW_ClimateChange/data/GLADE/historicalP/MRI/pr")
mri_1<- brick("pr_day_MRI-ESM2-0_historical_r1i1p1f1_gn_19500101-19991231.nc")
mmri_1<- rotate(mri_1)
mri_2<- brick("pr_day_MRI-ESM2-0_historical_r1i1p1f1_gn_20000101-20141231.nc")
mri_2<- rotate(mri_2)
mri_glk_1<- crop(mmri_1,extent(shp))
mri_glk_df_1<- as.data.frame(mri_glk_1,xy=TRUE)
mri_glk_2<- crop(mri_2,extent(shp))
mri_glk_df_2<- as.data.frame(mri_glk_2,xy=TRUE)
mri_glk_df_1_t<- t(mri_glk_df_1)
mri_glk_df_2_t<- t(mri_glk_df_2)
mri_glk_df<- rbind(mri_glk_df_1_t[-c(1:2),],mri_glk_df_2_t)
mri_dt_1<- data.frame(date(getZ(mri_1)))
colnames(mri_dt_1)<- c("Dates")
mri_dt_1$year<- year(mri_dt_1$Dates)
mri_dt_2<- data.frame(date(getZ(mri_2)))
colnames(mri_dt_2)<- c("Dates")
mri_dt_2$year<- year(mri_dt_2$Dates)
mri_dt<- rbind(mri_dt_1,mri_dt_2)
mri_full<- cbind(mri_glk_df[-c(1:2),],mri_dt)

mri_final<- mri_full%>%
  filter(year>1978)

for (i in 1:13149){
  mri_final[i,1:144]<- 86400* mri_final[i,1:144]
}
mri_final$month<- month(mri_final$Dates)

write.csv(mri_final,"E:/MW_ClimateChange/Data for frontiers paper/Daily Precip/mri.csv")
mri_summer_month<- mri_final%>%
  filter(month==6|month==7|month==8)
mri_summer<- mri_summer_month[,-c(145,147)]
i<- melt(mri_summer,id="year")
i1<- i%>%
  group_by(year,variable)%>%
  mutate(q95 = quantile(value, 0.90), row = row_number()) %>%
  filter(value <= q95) %>%
  select(-q95) %>%
  spread(year, value) %>%
  select(-row) 

i2 <- i1%>% 
  
  mutate_all(funs(replace_na(.,0)))

i3<- i2%>%
  group_by(variable)%>%
  summarise_each(funs(sum))
i4<- t(i3)
i4<- data.frame(i4)
i5<- data.frame(i4[-1,])
i5[] <- lapply(i5, function(x) as.numeric(as.character(x))) 
write.csv(i5,"E:/MW_ClimateChange/Data for frontiers paper/trace_p/mri/Extreme_total.csv")
i5<- read.csv("Extreme_total.csv")
setwd("G:/LCS-Filer/ekcarter_r/MW_ClimateChange/Data for frontiers paper/trace_p/mri")
tp_mri<- read.csv("TP_s6_8.csv")
ratio_mri<- i5[,-1]/tp_mri
write.csv(ratio_mri,"E:/MW_ClimateChange/Data for frontiers paper/trace_p/mri/ratio_s6_8.csv")

p_c<- c(12,1,2)
setwd("G:/LCS-Filer/ekcarter_r/MW_ClimateChange")
regP<-precip_trace(Pdat=mri_final[,1:144], 
                   m_c=p_c, 
                   min_yr=1979, 
                   max_yr=2014, 
                   out_path=("./Data for frontiers paper/trace_p/mri/"))
#miroc_es2l
setwd("G:/LCS-Filer/ekcarter_r/MW_ClimateChange/data/GLADE/historicalP/miroc/Pr")

miroc<- list.files(pattern=".nc")
for (i in 1:36){
  p<- rotate(brick(miroc[i]))
  n<- paste0("pr",i)
  assign(n,t(as.data.frame(crop(p,extent(shp)))))
  
}
miroc_glk<- rbind(pr1,pr2,pr3,pr4,pr5,pr6,pr7,pr8,pr9,pr10,pr11,pr12,pr13,pr14,pr15,pr16,pr17,pr18,pr19,pr20,pr21,pr22,pr23,pr24,pr25,pr26,pr27,pr28,pr29,pr30,pr31,pr32,pr33,pr34,pr35,pr36)

for (i in 1:36){
  a<- rotate(brick(miroc[i]))
  b<- paste0("miroc_dt_",i)
  (assign(b,data.frame(date(getZ(a)))))
  
}

miroc_dt<- rbind(miroc_dt_1,miroc_dt_2,miroc_dt_3,miroc_dt_4,miroc_dt_5,miroc_dt_6,miroc_dt_7,miroc_dt_8,miroc_dt_9,miroc_dt_10,miroc_dt_11,miroc_dt_12,miroc_dt_13,miroc_dt_14,miroc_dt_15,miroc_dt_16,miroc_dt_17,miroc_dt_18,miroc_dt_19,miroc_dt_20,miroc_dt_21,miroc_dt_22,miroc_dt_23,miroc_dt_24,miroc_dt_25,miroc_dt_26,miroc_dt_27,miroc_dt_28,miroc_dt_29,miroc_dt_30,miroc_dt_31,miroc_dt_32,miroc_dt_33,miroc_dt_34,miroc_dt_35,miroc_dt_36)
miroc_final<- cbind(miroc_glk,miroc_dt)
for (i in 1:13149){
  miroc_final[i,1:28]<- 86400*miroc_final[i,1:28]
}
miroc_final$month<- month(miroc_dt$date.getZ.a..)
miroc_final$year<- year(miroc_dt$date.getZ.a..)
write.csv(miroc_final,"E:/MW_ClimateChange/Data for frontiers paper/Daily Precip/miroc.csv")
miroc_summer_month<- miroc_final%>%
  filter(month==6|month==7|month==8)
miroc_summer<- miroc_summer_month[,-c(29,30)]
j<- melt(miroc_summer,id="year")
j1<- j%>%
  group_by(year,variable)%>%
  mutate(q95 = quantile(value, 0.90), row = row_number()) %>%
  filter(value <= q95) %>%
  select(-q95) %>%
  spread(year, value) %>%
  select(-row) 

j2 <- j1%>% 
  
  mutate_all(funs(replace_na(.,0)))

j3<- j2%>%
  group_by(variable)%>%
  summarise_each(funs(sum))
j4<- t(j3)
j4<- data.frame(j4)
j5<- data.frame(j4[-1,])
j5[] <- lapply(j5, function(x) as.numeric(as.character(x))) 
write.csv(j5,"E:/MW_ClimateChange/Data for frontiers paper/trace_p/miroc/Extreme_total.csv")
setwd("G:/LCS-Filer/ekcarter_r/MW_ClimateChange/Data for frontiers paper/trace_p/miroc")
tp_miroc<- read.csv("TP_s6_8.csv")
ratio_miroc<- j5/tp_miroc
write.csv(ratio_miroc,"E:/MW_ClimateChange/Data for frontiers paper/trace_p/miroc/ratio_s6_8.csv")




p_c<- c(6:8)
setwd("G:/LCS-Filer/ekcarter_r/MW_ClimateChange")
regP<-precip_trace(Pdat=miroc_final[,1:28], 
                   m_c=p_c, 
                   min_yr=1979, 
                   max_yr=2014, 
                   out_path=("./Data for frontiers paper/trace_p/miroc/"))
#ec-earth
setwd("G:/LCS-Filer/ekcarter_r/MW_ClimateChange/data/GLADE/historicalP/EC-Earth3/pr")
ec<- list.files(pattern = ".nc")
for (i in 1:36){
  pa<- rotate(brick(ec[i]))
  np<- paste0("ec",i)
  assign(np,t(as.data.frame(crop(pa,extent(shp)),xy=TRUE)))
  
}
for (i in 1:36){
  pa<- (brick(ec[i]))
  np<- paste0("ec_date",i)
  assign(np,data.frame(date(getZ(pa))))
  
}
ec_dates<- rbind(ec_date1,ec_date2,ec_date3,ec_date4,ec_date5,ec_date6,ec_date7,ec_date8,ec_date9,ec_date10,ec_date11,ec_date12,ec_date13,ec_date14,ec_date15,ec_date16,ec_date17,ec_date18,ec_date19,ec_date20,ec_date21,ec_date22,ec_date23,ec_date24,ec_date25,ec_date26,ec_date27,ec_date28,ec_date29,ec_date30,ec_date31,ec_date32,ec_date33,ec_date34,ec_date35,ec_date36)
ec_glk<- rbind(ec1,ec2[-c(1:2),],ec3[-c(1:2),],ec4[-c(1:2),],ec5[-c(1:2),],ec6[-c(1:2),],ec7[-c(1:2),],ec8[-c(1:2),],ec9[-c(1:2),],ec10[-c(1:2),],ec11[-c(1:2),],ec12[-c(1:2),],ec13[-c(1:2),],ec14[-c(1:2),],ec15[-c(1:2),],ec16[-c(1:2),],ec17[-c(1:2),],ec18[-c(1:2),],ec19[-c(1:2),],ec20[-c(1:2),],ec21[-c(1:2),],ec22[-c(1:2),],ec23[-c(1:2),],ec24[-c(1:2),],ec25[-c(1:2),],ec26[-c(1:2),],ec27[-c(1:2),],ec28[-c(1:2),],ec29[-c(1:2),],ec30[-c(1:2),],ec31[-c(1:2),],ec32[-c(1:2),],ec33[-c(1:2),],ec34[-c(1:2),],ec35[-c(1:2),],ec36[-c(1:2),])
ec_final<- cbind(ec_glk[-c(1:2),],ec_dates)
for (i in 1:13148){
  ec_final[i,1:378]<- 86400*ec_final[i,1:378]
}
ec_final$month<- month(ec_final$date.getZ.pa..)
ec_final$year<- year(ec_final$date.getZ.pa..)
write.csv(ec_final,"E:/MW_ClimateChange/Data for frontiers paper/Daily Precip/ec_earth.csv")
ec_summer_month<- ec_final%>%
  filter(month==6|month==7|month==8)
ec_summer<- ec_summer_month[,-c(379,380)]
k<- melt(ec_summer,id="year")
k1<- k%>%
  group_by(year,variable)%>%
  mutate(q95 = quantile(value, 0.90), row = row_number()) %>%
  filter(value <= q95) %>%
  select(-q95) %>%
  spread(year, value) %>%
  select(-row) 

k2 <- k1%>% 
  
  mutate_all(funs(replace_na(.,0)))

k3<- k2%>%
  group_by(variable)%>%
  summarise_each(funs(sum))
k4<- t(k3)
k4<- data.frame(k4)
k5<- data.frame(k4[-1,])
k5[] <- lapply(k5, function(x) as.numeric(as.character(x))) 
write.csv(k5,"E:/MW_ClimateChange/Data for frontiers paper/trace_p/ec/Extreme_total.csv")
setwd("G:/LCS-Filer/ekcarter_r/MW_ClimateChange/Data for frontiers paper/trace_p/ec")
tp_ec<- read.csv("TP_s6_8.csv")
ratio_ec<- k5/tp_ec
write.csv(ratio_ec,"E:/MW_ClimateChange/Data for frontiers paper/trace_p/ec/ratio_s6_8.csv")





#access
setwd("G:/LCS-Filer/ekcarter_r/MW_ClimateChange/data/GLADE/historicalP/ACCESS-ESM/Historic Pr")
acess<- list.files(pattern = ".nc")
for (i in 1:2){
  p<- rotate(brick(acess[i]))
  n<- paste0("acess",i)
  assign(n,t(as.data.frame(crop(p,extent(shp)),xy=TRUE)))
  
}
for (i in 1:2){
  ac<- (brick(acess[i]))
  dt<- paste0("ac_date",i)
  assign(dt,data.frame(date(getZ(ac))))
  
}
acess_date<- rbind(ac_date1,ac_date2)
acess_glk<- rbind(acess1,acess2[-c(1:2),])
acess_full<- cbind(acess_glk[-c(1:2),],acess_date)
acess_full$year<- year(acess_full$date.getZ.ac..)

acess_final<- acess_full%>%
  filter(year>1978)

for (i in 1:13149){
  acess_final[i,1:80]<- 86400*acess_final[i,1:80]
}
acess_final$month<- month(acess_final$date.getZ.ac..)
acess_final$year<- year(acess_final$date.getZ.ac..)
write.csv(acess_final,"E:/MW_ClimateChange/Data for frontiers paper/Daily Precip/acess.csv")
acess_summer_month<- acess_final%>%
  filter(month==6|month==7|month==8)
acess_summer<- acess_summer_month[,-c(81,83)]
l<- melt(acess_summer,id="year")
l1<- l%>%
  group_by(year,variable)%>%
  mutate(q95 = quantile(value, 0.90), row = row_number()) %>%
  filter(value <= q95) %>%
  select(-q95) %>%
  spread(year, value) %>%
  select(-row) 

l2 <- l1%>% 
  
  mutate_all(funs(replace_na(.,0)))

l3<- l2%>%
  group_by(variable)%>%
  summarise_each(funs(sum))
l4<- t(l3)
l4<- data.frame(l4)
l5<- data.frame(l4[-1,])
l5[] <- lapply(l5, function(x) as.numeric(as.character(x))) 
write.csv(l5,"E:/MW_ClimateChange/Data for frontiers paper/trace_p/acess/Extreme_total.csv")
setwd("G:/LCS-Filer/ekcarter_r/MW_ClimateChange/Data for frontiers paper/trace_p/acess")
tp_acess<- read.csv("TP_s6_8.csv")
ratio_acess<- l5/tp_acess
write.csv(ratio_acess,"E:/MW_ClimateChange/Data for frontiers paper/trace_p/acess/ratio_s6_8.csv")




p_c<- c(6:8)
p_c<- c(6:8)
setwd("G:/LCS-Filer/ekcarter_r/MW_ClimateChange")
regP<-precip_trace(Pdat=acess_final[,1:80], 
                   m_c=p_c, 
                   min_yr=1979, 
                   max_yr=2014, 
                   out_path=("./Data for frontiers paper/trace_p/acess/"))
#MPI
setwd("G:/LCS-Filer/ekcarter_r/MW_ClimateChange/data/GLADE/historicalP/MPI/pr")
mpi <- list.files(pattern = ".nc")
for (i in 1:8){
  mp<- rotate(brick(mpi[i]))
  np<- paste0("mpi",i)
  assign(np,t(as.data.frame(crop(mp,extent(shp)),xy=TRUE)))
  
}
for (i in 1:8){
  ac<- (brick(mpi[i]))
  dt<- paste0("mpi_date",i)
  assign(dt,data.frame(date(getZ(ac))))
  
}
mpi_date<- rbind(mpi_date1,mpi_date2,mpi_date3,mpi_date4,mpi_date5,mpi_date6,mpi_date7,mpi_date8)
mpi_glk<- rbind(mpi1,mpi2[-c(1:2),],mpi3[-c(1:2),],mpi4[-c(1:2),],mpi5[-c(1:2),],mpi6[-c(1:2),],mpi7[-c(1:2),],mpi8[-c(1:2),])
mpi_full<- cbind(mpi_glk[-c(1:2),],mpi_date)
mpi_sp<- mpi_full
mpi_full$year<- year(mpi_full$date.getZ.ac..)
mpi_final<- mpi_full%>%
  filter(year>1978)
for (i in 1:13149){
  mpi_final[i,1:220]<- 86400*mpi_final[i,1:220]
}
mpi_final$month<- month(mpi_final$date.getZ.ac..)
write.csv(mpi_final,"E:/MW_ClimateChange/Data for frontiers paper/Daily Precip/mpi.csv")
mpi_summer_month<- mpi_final%>%
  filter(month==6|month==7|month==8)
mpi_summer<- mpi_summer_month[,-c(221,223)]
l<- melt(mpi_summer,id="year")
l1<- l%>%
  group_by(year,variable)%>%
  mutate(q95 = quantile(value, 0.90), row = row_number()) %>%
  filter(value <= q95) %>%
  select(-q95) %>%
  spread(year, value) %>%
  select(-row) 

l2 <- l1%>% 
  
  mutate_all(funs(replace_na(.,0)))

l3<- l2%>%
  group_by(variable)%>%
  summarise_each(funs(sum))
l4<- t(l3)
l4<- data.frame(l4)
l5<- data.frame(l4[-1,])
l5[] <- lapply(l5, function(x) as.numeric(as.character(x))) 
write.csv(l5,"E:/MW_ClimateChange/Data for frontiers paper/trace_p/mpi/Extreme_total.csv")
setwd("G:/LCS-Filer/ekcarter_r/MW_ClimateChange/Data for frontiers paper/trace_p/mpi")
tp_mpi<- read.csv("TP_s6_8.csv")
ratio_mpi<- l5/tp_mpi
write.csv(ratio_mpi,"E:/MW_ClimateChange/Data for frontiers paper/trace_p/mpi/ratio_s6_8.csv")

p_c<- c(3:5)
setwd("G:/LCS-Filer/ekcarter_r/MW_ClimateChange")
regP<-precip_trace(Pdat=mpi_final[,1:220], 
                   m_c=p_c, 
                   min_yr=1979, 
                   max_yr=2014, 
                   out_path=("./Data for frontiers paper/trace_p/mpi/"))

#Calculating cpc in models grid

setwd("C:/Users/tamee/Downloads/greatlakes/")
region <- st_read("greatlakes_subbasins.shp", quiet = TRUE)
bb <- st_bbox(region)
e  <- extent(bb["xmin"], bb["xmax"], bb["ymin"], bb["ymax"])

setwd("C:/Users/tamee/Downloads/bcc")
bcc <- list.files(pattern = "\\.nc$", full.names = TRUE)
p1  <- brick(bcc[1])
p1  <- rotate(p1)
p1  <- crop(p1, e)

setwd("C:/Users/tamee/Downloads/")
files <- head(list.files(pattern = ".nc", full.names = TRUE), 36)

out_list <- vector("list", length(files))
for (i in seq_along(files)) {
  p2 <- brick(files[i])
  p2 <- rotate(p2)
  p2 <- crop(p2, e)
  p3 <- raster::resample(p2, p1, method = "bilinear")
  p4 <- t(as.data.frame(p3, xy = TRUE))
  p4 <- p4[-c(1, 2), , drop = FALSE]
  colnames(p4) <- paste0("cell_", seq_len(ncol(p4)))
  date <- data.frame(Date = as.Date(getZ(p2)))
  out_list[[i]] <- cbind(p4, date, source_file = basename(files[i]))
}

combined <- do.call(rbind, out_list)

