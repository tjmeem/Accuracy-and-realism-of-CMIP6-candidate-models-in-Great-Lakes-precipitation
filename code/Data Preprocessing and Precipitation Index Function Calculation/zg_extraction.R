
library(abind)
library(ncdf4)
library(lubridate)
#miroc
setwd("E:/MW_ClimateChange/data/GLADE/HistoricalZg/Miroc/zg")
zg_miroc<- nc_open("zg_Amon_MIROC-ES2L_historical_r1i1p1f1_gn_185001-201412.nc")
lat_miroc<-ncvar_get(zg_miroc, "lat")
lon_miroc<-ncvar_get(zg_miroc, "lon")
lev_miroc<-ncvar_get(zg_miroc, "plev")
z_miroc<-ncvar_get(zg_miroc, "zg")
time_miroc<-ncvar_get(zg_miroc, "time")
time_miroc<-as.POSIXct("1850-01-01 00:00")+as.difftime(time,units="days")
time_miroc<-as.Date(time_miroc, origin=as.Date("1850-01-01  00:00:0.0"))
time_int<- time_miroc[year(time_miroc)>1978 & year(time_miroc)<2015]
time_summe_mirocr<- time_int[month(time_int)%in%c(6,7,8)]
year_summer_miroc<-year(time_summer_miroc)
mn_summer_miroc<- month(time_summer_miroc)

z_500_miroc<- z_miroc[,,6,]
z_500_reg_miroc<- z_500_miroc[which(lon_miroc>180),which(lat_miroc>-10),which(time_miroc%in%time_int & month(time_miroc)%in%mn_summer_miroc)]
ltmz_zg_miroc<-array(NA, dim=c(dim(z_500_reg_miroc)[1:2],36))
for (i in c(1979:2014)){
  ltmz_zg_miroc[,,i-1978]<- apply(z_500_reg_miroc[,,year_summer_miroc%in%i],c(1,2),mean,na.rm=TRUE)
}

z_anom_miroc<-array(NA, dim=dim(ltmz_zg_miroc))
for(i in 1:dim(ltmz_zg_miroc)[1]){
  for(j in 1:dim(ltmz_zg_miroc)[2]){
    for(k in 1:dim(ltmz_zg_miroc)[3]){
      z_anom_miroc[i,j,k]<-(ltmz_zg_miroc[i,j,k]-mean(ltmz_zg_miroc[i,j,]))/sd(ltmz_zg_miroc[i,j,])
    }
  }
}

z_anom_miroc_2d<- data.frame()
for (i in 1:63) {
  for (j in 1:36) {
    z_anom_2d_miroc<- rbind (z_anom_2d_miroc, z_anom_miroc[i,j,1:36])
  }
}




z_anom_t_miroc<- t(z_anom_2d_miroc)
z_anom_t_miroc[is.nan(z_anom_t_miroc)]= NA
z_anom_t_miroc[which(!is.finite(z_anom_t_miroc))]=NA
z_anom_t_miroc[is.na(z_anom_t_miroc)]=0

write.csv(z_anom_t_miroc,"C:/Users/tameem/z_anom_miroc.csv")

#EC_earth

setwd("E:/MW_ClimateChange/data/GLADE/HistoricalZg/Ec-earth/zg")
ec<- list.files(pattern=".nc")
for (i in 1:36){
  p<- nc_open(ec[i])
  n<- paste0("zg_",i)
  assign(n,ncvar_get(p,varid = "zg"))
  
}
for (i in 1:36){
  p<- nc_open(ec[i])
  n<- paste0("time_",i)
  assign(n,ncvar_get(p,varid = "time"))
  
}
ec_zg<- abind(zg_1,zg_2,zg_3,zg_4,zg_5,zg_6,zg_7,zg_8,zg_9,zg_10,zg_11,zg_12,zg_13,zg_14,zg_15,zg_16,zg_17,zg_18,zg_19,zg_20,zg_21,zg_22,zg_23,zg_24,zg_25,zg_26,zg_27,zg_28,zg_29,zg_30,zg_31,zg_32,zg_33,zg_34,zg_35,zg_36)
ec_time<- abind(time_1,time_2,time_3,time_4,time_5,time_6,time_7,time_8,time_9,time_10,time_11,time_12,time_13,time_14,time_15,time_16,time_17,time_18,time_19,time_20,time_21,time_22,time_23,time_24,time_25,time_26,time_27,time_28,time_29,time_30,time_31,time_32,time_33,time_34,time_35,time_36)
time_ec<-as.POSIXct("1850-01-01 00:00")+as.difftime(ec_time,units="days")
time_ec<-as.Date(time_ec, origin=as.Date("1850-01-01  00:00:0.0"))
lat_ec<- ncvar_get(p,varid="lat")
lon_ec<- ncvar_get(p,varid="lon")
plev_ec<- ncvar_get(p,varid="plev")
ec_zg_500<- ec_zg[,,6,]
time_summer_ec<- time_ec[month(time_ec)%in%c(6,7,8)]
year_summer_ec<-year(time_summer_ec)
mn_summer_ec<- month(time_summer_ec)
z_500_reg_ec<- ec_zg_500[which(lon_ec>180),which(lat_ec>-10),which(time_ec%in%time_summer)]
ltmz_zg_ec<-array(NA, dim=c(dim(z_500_reg_ec)[1:2],36))
for (i in c(1979:2014)){
  ltmz_zg_ec[,,i-1978]<- apply(z_500_reg_ec[,,year_summer_ec%in%i],c(1,2),mean,na.rm=TRUE)
}

z_anom_ec<-array(NA, dim=dim(ltmz_zg_ec))
for(i in 1:dim(ltmz_zg_ec)[1]){
  for(j in 1:dim(ltmz_zg_ec)[2]){
    for(k in 1:dim(ltmz_zg_ec)[3]){
      z_anom_ec[i,j,k]<-(ltmz_zg_ec[i,j,k]-mean(ltmz_zg_ec[i,j,]))/sd(ltmz_zg_ec[i,j,])
    }
  }
}
z_anom_2d_ec<- data.frame()
for (i in 1:256) {
  for (j in 1:142) {
    z_anom_2d_ec<- rbind (z_anom_2d_ec, z_anom_ec[i,j,1:36])
  }
}
z_anom_t_ec<- t(z_anom_2d_ec)
z_anom_t_ec[is.nan(z_anom_t_ec)]= NA
z_anom_t_ec[which(!is.finite(z_anom_t_ec))]=NA
z_anom_t_ec[is.na(z_anom_t_ec)]=0

write.csv(z_anom_t_ec,"C:/Users/tameem/z_anom_ec.csv")

#MPI
setwd("C:/Users/tamee/Downloads/mpi")
m1<- nc_open("zg_Amon_MPI-ESM1-2-HR_historical_r1i1p1f1_gn_197501-197912.nc")
lat_mpi<-ncvar_get(m1, "lat")
lon_mpi<-ncvar_get(m1, "lon")
mpi<- list.files(pattern=".nc")
for (i in 26:33){
  p<- nc_open(mpi[i])
  n<- paste0("z_mpi_",i-25)
  assign(n,ncvar_get(p,varid = "zg"))
  
}
for (i in 26:33){
  p<- nc_open(mpi[i])
  n<- paste0("time_m",i-25)
  assign(n,ncvar_get(p,varid = "time"))
  
}
z_mpi<- abind(z_mpi_1,z_mpi_2,z_mpi_3,z_mpi_4,z_mpi_5,z_mpi_6,z_mpi_7,z_mpi_8)
z_mpi_500<- z_mpi[,,6,]
time_mpi<- abind(time_m1,time_m2,time_m3,time_m4,time_m5,time_m6,time_m7,time_m8)
time_mpi<-as.POSIXct("1850-01-01 00:00")+as.difftime(time_mpi,units="days")
time_mpi<-as.Date(time_mpi, origin=as.Date("1850-01-01  00:00:0.0"))
time_mpi<- time_mpi[year(time_mpi)>1978]
mnth_mpi<- month(time_mpi)
year_mpi<-year(time_mpi)
z_mpi_year<-z_mpi_500[,,which(year_mpi>1978)]
z_mpi_summer<- z_mpi_year[,,(which(mnth_mpi==6 | mnth_mpi==7 | mnth_mpi==8))]
z_mpi_summer<- z_mpi_summer[which(lon_mpi>180),which(lat_mpi>-10),]
ltmz_zg_mpi<-array(NA, dim=c(dim(z_mpi_summer)[1:2],36))
year<- 1979:2014
year_summer_mpi<- rep(year,each=3)
for (i in c(1979:2014)){
  ltmz_zg_mpi[,,i-1978]<- apply(z_mpi_summer[,,year_summer_mpi%in%i],c(1,2),mean,na.rm=TRUE)
}

z_anom_mpi<-array(NA, dim=dim(ltmz_zg_mpi))
for(i in 1:dim(ltmz_zg_mpi)[1]){
  for(j in 1:dim(ltmz_zg_mpi)[2]){
    for(k in 1:dim(ltmz_zg_mpi)[3]){
      z_anom_mpi[i,j,k]<-(ltmz_zg_mpi[i,j,k]-mean(ltmz_zg_mpi[i,j,]))/sd(ltmz_zg_mpi[i,j,])
    }
  }
}
z_anom_2d_mpi<- data.frame()
for (i in 1:191) {
  for (j in 1:107) {
    z_anom_2d_mpi<- rbind (z_anom_2d_mpi, z_anom_mpi[i,j,1:36])
  }
}
z_anom_t_mpi<- t(z_anom_2d_mpi)
z_anom_t_mpi[is.nan(z_anom_t_mpi)]= NA
z_anom_t_mpi[which(!is.finite(z_anom_t_mpi))]=NA
z_anom_t_mpi[is.na(z_anom_t_mpi)]=0

write.csv(z_anom_t_mpi,"C:/Users/tamee/Downloads/z_anom_mpi.csv")

#MRI
setwd("C:/Users/tamee/Downloads/Zg/MRI/zg")
m1<- nc_open("zg_Amon_MRI-ESM2-0_historical_r1i1p1f1_gn_195001-199912.nc")
lat_mri<-ncvar_get(m1, "lat")
lon_mri<-ncvar_get(m1, "lon")
mri<- list.files(pattern=".nc")
for (i in 1:2){
  p<- nc_open(mri[i])
  n<- paste0("z_mpi_",i)
  assign(n,ncvar_get(p,varid = "zg"))
  
}
for (i in 1:2){
  p<- nc_open(mri[i])
  n<- paste0("time_m",i)
  assign(n,ncvar_get(p,varid = "time"))
  
}
z_mri<- abind(z_mpi_1,z_mpi_2)
z_mri_500<- z_mri[,,6,]
time_mri<- abind(time_m1,time_m2)
time_mri<-as.POSIXct("1850-01-01 00:00")+as.difftime(time_mri,units="days")
time_mri<-as.Date(time_mri, origin=as.Date("1850-01-01  00:00:0.0"))
time_mri<- time_mri[year(time_mri)>1978]
mnth_mri<- month(time_mri)
year_mri<-year(time_mri)
z_mri_year<-z_mri_500[,,which(year_mri>1978)]
z_mri_summer<- z_mri_year[,,(which(mnth_mri==6 | mnth_mri==7 | mnth_mri==8))]
year_summer<- rep(1979:2014,3)
z_mri_summer<- z_mri_summer[which(lon_n>180),which(lat_n>-10),]
ltmz_zg_mri<-array(NA, dim=c(dim(z_mri_summer)[1:2],36))

for (i in c(1979:2014)){
  ltmz_zg_mri[,,i-1978]<- apply(z_mri_summer[,,year_summer%in%i],c(1,2),mean,na.rm=TRUE)
}

z_anom_mri<-array(NA, dim=dim(ltmz_zg_mri))
for(i in 1:dim(ltmz_zg_mri)[1]){
  for(j in 1:dim(ltmz_zg_mri)[2]){
    for(k in 1:dim(ltmz_zgMri)[3]){
      z_anom_mri[i,j,k]<-(ltmz_zg_mri[i,j,k]-mean(ltmz_zg_mri[i,j,]))/sd(ltmz_zg_mri[i,j,])
    }
  }
}
z_anom_2d_mri<- data.frame()
for (i in 1:159) {
  for (j in 1:89) {
    z_anom_2d_mri<- rbind (z_anom_2d_mri, z_anom_mri[i,j,1:36])
  }
}
z_anom_t_mri<- t(z_anom_2d_mri)
z_anom_t_mri[is.nan(z_anom_t_mri)]= NA
z_anom_t_mri[which(!is.finite(z_anom_t_mri))]=NA
z_anom_t_mri[is.na(z_anom_t_mri)]=0

write.csv(z_anom_t_mri,"C:/Users/tamee/Downloads/Zg/MRI/zg/z_anom_mri.csv")

#access
setwd("E:/MW_ClimateChange/data/GLADE/HistoricalZg/ACCESS/zg")
m<- nc_open("zg_Amon_ACCESS-ESM1-5_historical_r1i1p1f1_gn_195001-201412.nc")
lat_ac<-ncvar_get(m, "lat")
lon_ac<-ncvar_get(m, "lon")
lev_ac<-ncvar_get(m, "plev")
z<_ac-ncvar_get(m, "zg")
time_ac<-ncvar_get(m, "time")
z_ac_500<- z[,,6,]

time_ac<-as.POSIXct("1850-01-01 00:00")+as.difftime(time,units="days")
time_ac<-as.Date(time_ac, origin=as.Date("1850-01-01  00:00:0.0"))
time_ac<- time_ac[year(time_ac)>1978]
mnth_ac<- month(time_ac)
year_ac<-year(time_ac)
z_ac_year<-z_ac_500[,,which(year_ac>1978)]
z_ac_summer<- z_ac_year[,,(which(mnth_ac==6 | mnth_ac==7 | mnth_ac==8))]
year_summer<- rep(1979:2014,3)
z_ac_summer<- z_ac_summer[which(lon>180),which(lat>-10),]
ltmz_zg_ac<-array(NA, dim=c(dim(z_ac_summer)[1:2],36))
for (i in c(1979:2014)){
  ltmz_zg_ac[,,i-1978]<- apply(z_ac_summer[,,year_summer%in%i],c(1,2),mean,na.rm=TRUE)
}

z_anom_ac<-array(NA, dim=dim(ltmz_zg_ac))
for(i in 1:dim(ltmz_zg_ac)[1]){
  for(j in 1:dim(ltmz_zg_ac)[2]){
    for(k in 1:dim(ltmz_zg_ac)[3]){
      z_anom_ac[i,j,k]<-(ltmz_zg_ac[i,j,k]-mean(ltmz_zg_ac[i,j,]))/sd(ltmz_zg_ac[i,j,])
    }
  }
}
z_anom_2d_ac<- data.frame()
for (i in 1:96) {
  for (j in 1:80) {
    z_anom_2d_ac<- rbind (z_anom_2d_ac, z_anom_ac[i,j,1:36])
  }
}
z_anom_t_ac<- t(z_anom_2d_ac)
z_anom_t_ac[is.nan(z_anom_t_ac)]= NA
z_anom_t_ac[which(!is.finite(z_anom_t_ac))]=NA
z_anom_t_ac[is.na(z_anom_t_ac)]=0

write.csv(z_anom_t_ac,"C:/Users/tameem/z_anom_ac.csv")


