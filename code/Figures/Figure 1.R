setwd("E:/MW_ClimateChange/Data for frontiers paper")
library(dplyr)
library(ggplot2)
library(reshape2)
mean_updated <- read_csv("mean_updated.csv",col_types = cols(Dates = col_date(format = "%m/%d/%Y")))


year<- mean_updated%>%
  group_by(year)%>%
  summarise(CAN_ESM= sum(can_esm),
            CNRM_ESM= sum(cnrm_esm),
            IPSL= sum(ipsl),
            MPI= sum(mpi),
            GFDL=sum(gfdl),
            UKESM=sum(ukesm),
            EC_EARTH= sum(ec_earth),
            MIROC= sum(miroc),
            INM= sum(inm),
            MRI= sum(mri),
            ACCESS= sum(access),
            BCC=sum(bcc),
            CPC= sum(cpc,na.rm = TRUE))

year_diff<- mean_updated%>%
  group_by(year)%>%
  summarise(can_esm= sum(can_esm),
            cnrm_esm= sum(cnrm_esm),
            ipsl= sum(ipsl),
            mpi= sum(mpi),
            gfdl=sum(gfdl),
            ukesm=sum(ukesm),
            ec_earth= sum(ec_earth),
            miroc= sum(miroc),
            inm= sum(inm),
            mri= sum(mri),
            access= sum(access),
            bcc=sum(bcc),
            cpc= sum(cpc,na.rm = TRUE))



year_diff$can_esm_d<- year$CAN_ESM - year$CPC
year_diff$cnrm_esm_d<- year$CNRM_ESM - year$CPC
year_diff$ipsl_d<- year$IPSL - year$CPC
year_diff$mpi_d <- year$MPI - year$CPC
year_diff$gfdl_d<- year$GFDL - year$CPC
year_diff$ukesm_d<- year$UKESM - year$CPC
year_diff$ec_earth_d<- year$EC_EARTH - year$CPC
year_diff$miroc_d <- year$MIROC - year$CPC
year_diff$inm_d <- year$INM - year$CPC
year_diff$mri_d <- year$MRI - year$CPC
year_diff$access_d<- year$ACCESS - year$CPC
year_diff$bcc_d<- year$BCC - year$CPC


year_diff<- year_diff[,c(1,15:26)]

model<- c("year","CAN_ESM","CNRM_ESM","IPSL","MPI","GFDL","UKESM","EC_EARTH","MIROC","INM","MRI","ACCESS","BCC")
name<- model[2:13]
colnames(year_diff)<- model
year_m<- melt(year_diff,id='year')


cs<- c("Model"="Red","CPC"="blue")
mydf<- melt(year,id=c('year'))
mydf_1<- mydf[1:432,]
cpc<- mydf$value[433:468]
cpc_1<- rep(cpc,12)
mydf_1$cpc<- cpc_1
mydf_1<- data.frame(mydf_1)

mean<- data.frame((apply(year[,2:14],2,mean)))
colnames(mean) <-c("Model")
mean$difference<- round(((mean$Model- 787.3229)/787.3229)*100,2)
mean$cor<- rep(NA,13)
for (i in 1:13){
  mean[i,3]<- cor(year[,i+1],year[,14])
}
mean<- mean[1:12,]
lb<- as.character(mean$difference)
labels<- data.frame(variable=name,label=paste("% overestimation :",lb))
ggplot(mydf_1,aes(x=(year)))+
  geom_line(aes(y= value,color="Model"),size=1)+
  geom_line(aes(y=cpc,color="CPC"),size=1)+
  facet_wrap(.~variable)+
  xlab("Year")+
  ylab("Total Precipitation(mm/year)")+
  scale_color_manual(values = cs,name='Dataset')+
  theme_bw() +
  theme(plot.background = element_blank(),
        panel.grid.major =element_blank(),
        panel.grid.minor = element_blank(),
        axis.line = element_line(),
        strip.background = element_rect(fill='white'))+
  geom_text(x=2000,y=1400,aes(label=label),data = labels,size=4,fontface="bold")+
  theme(strip.text = element_text(face="bold",size=12))
panel

setwd("E:/MW_ClimateChange/Data for frontiers paper/Draft/Edits")
ggsave("yearly_overestimation.jpeg",width = 12, height=8)





































