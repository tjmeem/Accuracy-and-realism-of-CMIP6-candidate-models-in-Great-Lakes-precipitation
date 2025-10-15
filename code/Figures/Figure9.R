
tmp <- tempfile(fileext = ".zip")
download.file("https://zenodo.org/record/17316002/files/Figure6-10.zip?download=1",
              tmp, mode = "wb")
unzip(tmp, exdir = "./processed_data/Figure6_10")

setwd("./cpc")
cpc<- read.csv("tp_s6_8.csv")
cpc_avg<- (data.frame(apply(cpc[,1:5],1,mean)))
colnames(cpc_avg)<- "TP"
cpc_avg$Timeline <- "Observed"
cpc_avg$year<- seq(1979,2014,1)
access<- rep("ACCESS",36)
ec<- rep("EC_EARTH",36)
miroc<- rep("MIROC",36)
mpi<- rep("MPI",36)
mri<- rep("MRI",36)
model<- c(access,ec,miroc,mpi,mri)
cpc_all<- rbind(cpc_avg,cpc_avg,cpc_avg,cpc_avg,cpc_avg)
cpc_all$Model<- model

#Access
setwd("./access/historical")
access_hist<- read.csv("tp_s6_8.csv")
access_hist_avg<- (data.frame(apply(access_hist[,1:5],1,mean)))
colnames(access_hist_avg)<- "TP"
access_hist_avg$Timeline <- rep("Historical",36)
access_hist_avg$year<- seq(1979,2014,1)

setwd("./access/ssp370")
access_ssp370<- read.csv("tp_s6_8.csv")
access_ssp370_avg<- (data.frame(apply(access_ssp370[,1:5],1,mean)))
colnames(access_ssp370_avg)<- "TP"
access_ssp370_avg$Timeline<- rep("SSP3-7.0",86)
access_ssp370_avg$year<- seq(2015,2100,1)
setwd("./access/ssp585")
access_ssp585<- read.csv("tp_s6_8.csv")
access_ssp585_avg<- (data.frame(apply(access_ssp585[,1:5],1,mean)))
colnames(access_ssp585_avg)<- "TP"
access_ssp585_avg$Timeline<- rep("SSP5-8.5",86)
access_ssp585_avg$year<- seq(2015,2100,1)
access_full<- rbind(access_hist_avg,access_ssp370_avg,access_ssp585_avg)
access_full$Model<- rep("ACCESS",208) 

#Ec_earth
setwd("./ec_earth/historical")
ec_hist<- read.csv("tp_s6_8.csv")
ec_hist_avg<- data.frame(apply(ec_hist[,1:5],1,mean))
colnames(ec_hist_avg)<- "TP"
ec_hist_avg$Timeline<- rep("Historical",36)
ec_hist_avg$year<- seq(1979,2014,1)
setwd("./ec_earth/ssp370")
ec_ssp370<- read.csv("tp_s6_8.csv")
ec_ssp370_avg<- (data.frame(apply(ec_ssp370[,1:5],1,mean)))
colnames(ec_ssp370_avg)<- "TP"
ec_ssp370_avg$Timeline<- rep("SSP3-7.0",86)
ec_ssp370_avg$year<- seq(2015,2100,1)
setwd("./ec_earth/ssp585")
ec_ssp585<- read.csv("TP_s6_8.csv")
ec_ssp585_avg<- (data.frame(apply(ec_ssp585[,1:5],1,mean)))
colnames(ec_ssp585_avg)<- "TP"
ec_ssp585_avg$Timeline<- rep("SSP5-8.5",86)
ec_ssp585_avg$year<- seq(2015,2100,1)
ec_full<- rbind(ec_hist_avg,ec_ssp370_avg,ec_ssp585_avg)
ec_full$Model<- rep("EC_EARTH",208)

#Miroc
setwd("./miroc/historical")
miroc_hist<- read.csv("tp_s6_8.csv")
miroc_hist_avg<- data.frame(apply(miroc_hist[,1:5],1,mean))
colnames(miroc_hist_avg)<- "TP"
miroc_hist_avg$Timeline<- rep("Historical",36)
miroc_hist_avg$year<- seq(1979,2014,1)
setwd("./miroc/ssp370")
miroc_ssp370<- read.csv("TP_s6_8.csv")
miroc_ssp370_avg<- data.frame(apply(miroc_ssp370[,1:5],1,mean))
colnames(miroc_ssp370_avg)<- "TP"
miroc_ssp370_avg$Timeline<- rep("SSP3-7.0",86)
miroc_ssp370_avg$year<- seq(2015,2100,1)
setwd("./miroc/ssp585")
miroc_ssp585<- read.csv("TP_s6_8.csv")
miroc_ssp585_avg<- data.frame(apply(miroc_ssp585[,1:5],1,mean))
colnames(miroc_ssp585_avg)<- "TP"
miroc_ssp585_avg$Timeline<- rep("SSP5-8.5",86)
miroc_ssp585_avg$year<- seq(2015,2100,1)
miroc_full<- rbind(miroc_hist_avg,miroc_ssp370_avg,miroc_ssp585_avg)
miroc_full$Model <- rep("MIROC",208)

#MPI
setwd("./MPI/historical")
mpi_hist<- read.csv("tp_s6_8.csv")
mpi_hist_avg<- data.frame(apply(mpi_hist[,1:5],1,mean))
colnames(mpi_hist_avg)<- "TP"
mpi_hist_avg$Timeline<- rep("Historical",36)
mpi_hist_avg$year<- seq(1979,2014,1)

setwd("./MPI/ssp370")
mpi_ssp370<- read.csv("TP_s6_8.csv")
mpi_ssp370_avg<- data.frame(apply(mpi_ssp370[,1:5],1,mean))
colnames(mpi_ssp370_avg)<- "TP"
mpi_ssp370_avg$Timeline<- rep("SSP3-7.0",86)
mpi_ssp370_avg$year<- seq(2015,2100)
setwd("./MPI/ssp585")
mpi_ssp585<- read.csv("TP_s6_8.csv")
mpi_ssp585_avg<- data.frame(apply(mpi_ssp585[,1:5],1,mean))
colnames(mpi_ssp585_avg)<- "TP"
mpi_ssp585_avg$Timeline<- rep("SSP5-8.5",86)
mpi_ssp585_avg$year<- seq(2015,2100)
mpi_full<- rbind(mpi_hist_avg,mpi_ssp370_avg,mpi_ssp585_avg)
mpi_full$Model<- rep("MPI",208)

#MRI
setwd("./MRI/historical")
mri_hist<- read.csv("tp_s6_8.csv")
mri_hist_avg<- data.frame(apply(mri_hist[,1:5],1,mean))
colnames(mri_hist_avg)<- "TP"
mri_hist_avg$year<- seq(1979,2014,1)
mri_hist_avg$Timeline<- rep("Historical",36)
setwd("./MRI/ssp370")
mri_ssp370<- read.csv("TP_s6_8.csv")
mri_ssp370_avg<- data.frame(apply(mri_ssp370[,1:5],1,mean))
colnames(mri_ssp370_avg)<- "TP"
mri_ssp370_avg$Timeline<- rep("SSP3-7.0",86)
mri_ssp370_avg$year<- seq(2015,2100)
setwd("./MRI/ssp585")
mri_ssp585<- read.csv("TP_s6_8.csv")
mri_ssp585_avg<- data.frame(apply(mri_ssp585[,1:5],1,mean))
colnames(mri_ssp585_avg)<- "TP"
mri_ssp585_avg$Timeline<- rep("SSP5-8.5",86)
mri_ssp585_avg$year<- seq(2015,2100)

mri_full<- rbind(mri_hist_avg,mri_ssp370_avg,mri_ssp585_avg)
mri_full$Model<- rep("MRI",208)
tp_all<- rbind(cpc_all,access_full,ec_full,miroc_full,mpi_full,mri_full)

library(ggplot2)
ggplot(data=tp_all,aes(x=year,y=TP,fill=Timeline,colour=Timeline))+
  geom_line(aes(y=TP))+
  facet_wrap(~factor(Model,levels=c('EC_EARTH','MPI','MRI','ACCESS','MIROC')))+
  geom_vline(xintercept = 2014, linetype="solid", 
             color = "grey", size=0.75)+
  xlim(c(1979,2100))

