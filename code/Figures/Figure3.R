tmp <- tempfile(fileext = ".zip")
download.file("https://zenodo.org/record/17316002/files/fig%201,2,3.zip?download=1", tmp, mode="wb")
unzip(tmp, exdir = "./processed_data")
mean_updated <- read_csv("E:/MW_ClimateChange/Data for frontiers paper/mean_updated.csv",col_types = cols(Dates = col_date(format = "%m/%d/%Y")))

mean_updated <- read_csv("E:/MW_ClimateChange/Data for frontiers paper/mean_updated.csv",col_types = cols(Dates = col_date(format = "%m/%d/%Y")))


library(tidyverse)


month<- mean_updated%>%
  group_by(month)%>%
  summarise(can_esm= mean(can_esm),
            cnrm_esm= mean(cnrm_esm),
            ipsl= mean(ipsl),
            mpi= mean(mpi),
            gfdl=mean(gfdl),
            ukesm=mean(ukesm),
            ec_earth= mean(ec_earth),
            miroc= mean(miroc),
            inm= mean(inm),
            mri= mean(mri),
            access= mean(access),
            bcc=mean(bcc),
            cpc= mean(cpc,na.rm = TRUE))



library(plotrix)
month_se<- mean_updated%>%
  group_by(month)%>%
  summarise(can_esm= std.error(can_esm),
            cnrm_esm= std.error(cnrm_esm),
            ipsl= std.error(ipsl,na.rm=TRUE),
            mpi= std.error(mpi),
            gfdl= std.error(gfdl),
            ukesm= std.error(ukesm),
            ec_earth= std.error(ec_earth),
            miroc= std.error(miroc),
            inm= std.error(inm),
            mri= std.error(mri),
            access= std.error(access),
            bcc=std.error(bcc),
            cpc= std.error(cpc,na.rm = TRUE))


month_5<- mean_updated%>%
  group_by(month)%>%
  summarise(can_esm= quantile(can_esm,0.025),
            cnrm_esm= quantile(cnrm_esm,0.025),
            ipsl= quantile(ipsl,0.025,na.rm=TRUE),
            mpi= quantile(mpi,0.025),
            gfdl= quantile(gfdl,0.025),
            ukesm= quantile(ukesm,0.025),
            ec_earth= quantile(ec_earth,0.025),
            miroc= quantile(miroc,0.025),
            inm= quantile(inm,0.025),
            mri= quantile(mri,0.025),
            access= quantile(access,0.025),
            bcc=quantile(bcc,0.025),
            cpc= quantile(cpc,0.025,na.rm = TRUE))


month_95<- mean_updated%>%
  group_by(month)%>%
  summarise(can_esm= quantile(can_esm,0.975),
            cnrm_esm= quantile(cnrm_esm,0.975),
            ipsl= quantile(ipsl,0.975),
            mpi= quantile(mpi,0.975),
            gfdl= quantile(gfdl,0.975),
            ukesm= quantile(ukesm,0.975),
            ec_earth= quantile(ec_earth,0.975),
            miroc= quantile(miroc,0.975),
            inm= quantile(inm,0.975),
            mri= quantile(mri,0.975),
            access= quantile(access,0.975),
            bcc=quantile(bcc,0.975),
            cpc= quantile(cpc,0.975,na.rm = TRUE))




mon_melt<- reshape2::melt(month,id="month")
mon_melt_05<- reshape2::melt(month_5,id='month')
mon_melt_95<- reshape2::melt(month_95,id='month')
mon_melt_se<- reshape2::melt(month_se,id='month')

mon_melt_updated<- mon_melt[1:144,]
mon_melt_05_updated<- mon_melt_05[1:144,]
mon_melt_95_updated<- mon_melt_95[1:144,]
mon_melt_updated$q_95<- mon_melt_95_updated$value
mon_melt_updated$q_05<- mon_melt_05_updated$value
mon_melt_cpc<- mon_melt[145:156,]
mon_melt_cpc_05<- mon_melt_05[145:156,]
mon_melt_cpc_95<- mon_melt_95[145:156,]
mon_melt_cpc$q_05<- mon_melt_cpc_05$value
mon_melt_cpc$q_95<- mon_melt_cpc_95$value
mon_melt_updated$cpc<- rep(mon_melt_cpc$value,12)
mon_melt_updated$cpc_q05<- rep(mon_melt_cpc_05$value,12)
mon_melt_updated$cpc_q95<- rep(mon_melt_cpc$q_95,12)
setwd("E:/MW_ClimateChange/Data for Frontiers Paper")
month_sig <- read_csv("Draft/month_sig.csv")
mon_melt_updated$significance <- month_sig$significance
cs<- c("Model"="red","CPC"="blue")
y_break<- seq(0.001,20,0.01)
ggplot(data = mon_melt_updated,aes(x= month)) +
  geom_line(aes(y=cpc),size=1)+
  geom_ribbon(aes(ymin=cpc_q05,ymax=cpc_q95,fill="CPC"),alpha=0.5)+
  geom_line(aes(y=value),size=1)+
  geom_ribbon(aes(ymin=q_05,ymax=q_95,fill="Model"),alpha=0.5) +
  geom_point(aes(y=value,shape=significance))+
  facet_wrap(.~variable) +
  scale_fill_manual(values= cs)+
  scale_x_continuous(breaks = 1:12)+
  guides(fill=guide_legend(title="Type"),size=20)+
  xlab("Month")+
  ylab("Monthly Average Precipitation(mm/day)")+
  scale_shape_discrete(labels=c("Similar with CPC","Different from CPC"))+
  theme_bw() +
  theme(plot.background = element_blank(),
        panel.grid.major =element_blank(),
        panel.grid.minor = element_blank(),
        axis.line = element_line(),
        strip.background = element_rect(fill='white'))
  





  
