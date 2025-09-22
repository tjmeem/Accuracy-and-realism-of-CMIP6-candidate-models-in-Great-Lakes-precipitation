setwd("E:/MW_ClimateChange/Data for frontiers paper/NewModels/Basin/Superior/Summer")


cdd_sup<- read.csv("CDD_s6_8.csv")
cdd_sup_mean<- apply(cdd_sup[,1:12],1,mean)

setwd("E:/MW_ClimateChange/Data for frontiers paper/NewModels/Basin/Ontario/Summer")
cdd_ont<- read.csv("CDD_s6_8.csv")
cdd_ont_mean<- apply(cdd_ont[,1:12],1,mean)

setwd("E:/MW_ClimateChange/Data for frontiers paper/NewModels/Basin/Michigan/Summer")
cdd_michigan<- read.csv("CDD_s6_8.csv")
cdd_mich_mean<- apply(cdd_michigan[,1:12],1,mean)

setwd("E:/MW_ClimateChange/Data for frontiers paper/NewModels/Basin/Huron/Summer")
cdd_huron<- read.csv("CDD_s6_8.csv")
cdd_huron_mean<- apply(cdd_huron[,1:12],1,mean)
setwd("E:/MW_ClimateChange/Data for frontiers paper/NewModels/Basin/Erie/Summer")
cdd_erie<- read.csv("CDD_s6_8.csv")
cdd_erie_mean<- apply(cdd_erie[,1:12],1,mean)
cpc_basin<- data.frame(cdd_sup$cpc,cdd_ont$cpc,cdd_michigan$cpc,cdd_huron$cpc,cdd_erie$cpc)
colnames(cpc_basin)<- c("Superior","Ontario","Michigan","Huron","Erie")
mean_basin<- data.frame(cdd_sup_mean,cdd_ont_mean,cdd_mich_mean,cdd_huron_mean,cdd_erie_mean)
colnames(mean_basin)<- c("Superior","Ontario","Michigan","Huron","Erie")
en<- rep("Ensemble",36)
cpc<- rep("CPC",36)
mean_basin$Type<- en
cpc_basin$Type<- cpc
cdd<- rbind(mean_basin,cpc_basin)
cdd<- cdd[,c(1,3,4,5,2,6)]
a<- reshape2::melt(cdd,id="Type")
colors1<- c("CPC"="lightblue","Ensemble"= "cyan4")
ggplot(data = a,aes(x=variable,y=value,fill=Type))+
  geom_boxplot()+
  scale_fill_manual(values= colors1)+
  #new_scale_color()+
  ylim(c(0,15))+
  xlab("Basins")+
  ylab("CDD")+
  #ggtitle("CDD")+
  theme_bw()+
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())+
  theme(axis.text.x = element_text(angle = 0, hjust = 1,size=18,face='bold'),axis.text.y = element_text(angle = 0, hjust = 1,size=18,face='bold'),axis.title=element_text(size=18,face="bold"),plot.title=element_text(size=20,face='bold'),panel.grid.major = element_blank(), panel.grid.minor = element_blank(),legend.title=element_text(size=20,face="bold"),legend.position = 'none')

setwd("E:/MW_ClimateChange/Data for frontiers paper/Draft/Edits")
ggsave("cdd_ensemble_nl.jpeg",width = 12, height=8)

setwd("E:/MW_ClimateChange/Data for frontiers paper/NewModels/Basin/Superior/Summer")

cwd_sup<- read.csv("CWD_s6_8.csv")
cwd_sup_mean<- apply(cwd_sup[,1:12],1,mean)
setwd("E:/MW_ClimateChange/Data for frontiers paper/NewModels/Basin/Ontario/Summer")
cwd_ont<- read.csv("CWD_s6_8.csv")
cwd_ont_mean<- apply(cwd_ont[,1:12],1,mean)
setwd("E:/MW_ClimateChange/Data for frontiers paper/NewModels/Basin/Michigan/Summer")
cwd_michigan<- read.csv("CWD_s6_8.csv")
cwd_mich_mean<- apply(cwd_michigan[,1:12],1,mean)
setwd("E:/MW_ClimateChange/Data for frontiers paper/NewModels/Basin/Huron/Summer")
cwd_huron<- read.csv("CWD_s6_8.csv")
cwd_huron_mean<- apply(cwd_huron[,1:12],1,mean)
setwd("E:/MW_ClimateChange/Data for frontiers paper/NewModels/Basin/Erie/Summer")
cwd_erie<- read.csv("CWD_s6_8.csv")
cwd_erie_mean<- apply(cwd_erie[,1:12],1,mean)
cpc_basin_cwd<- data.frame(cwd_sup$cpc,cwd_ont$cpc,cwd_michigan$cpc,cwd_huron$cpc,cwd_erie$cpc)
colnames(cpc_basin_cwd)<- c("Superior","Ontario","Michigan","Huron","Erie")
mean_basin_cwd<- data.frame(cwd_sup_mean,cwd_ont_mean,cwd_mich_mean,cwd_huron_mean,cwd_erie_mean)
lakes<- c("Superior","Ontario","Michigan","Huron","Erie")
colnames(mean_basin_cwd)<- c("Superior","Ontario","Michigan","Huron","Erie")
mean_basin_cwd$Type<- en
cpc_basin_cwd$Type<- cpc
cwd<- rbind(mean_basin_cwd,cpc_basin_cwd)
cwd<- cwd[,c(c(1,3,4,5,2,6))]
b<- reshape2::melt(cwd,id="Type")
ggplot(data = b,aes(x=variable,y=value,fill=Type))+
  geom_boxplot()+
  scale_fill_manual(values= colors1)+
  xlab("Basins")+
  ylab("Days")+
  ggtitle("Cumulative Wet Days")+
  ylim(c(0,50))+
  theme_bw()+
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())+
  theme(axis.text.x = element_text(angle = 0, hjust = 1,size=12,face='bold'),axis.text.y = element_text(angle = 0, hjust = 1,size=18,face='bold'),axis.title=element_text(size=28,face="bold"),plot.title=element_text(size=30,face='bold'),panel.grid.major = element_blank(), panel.grid.minor = element_blank(),legend.title=element_text(size=20,face="bold"),legend.text=element_text(size=18,face="bold"))

ggplot(data = b,aes(x=variable,y=value,fill=Type))+
  geom_boxplot()+
  scale_fill_manual(values= colors1)+
  xlab("Basins")+
  ylab("Cumulative Wet Days (Days/year)")+
  ggtitle('CWD')+
  ylim(c(0,50))+
  theme_bw()+
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())+
  theme(axis.text.x = element_text(angle = 0, hjust = 1,size=12,face='bold'),axis.text.y = element_text(angle = 0, hjust = 1,size=12,face='bold'),axis.title=element_text(size=18,face="bold"),plot.title=element_text(size=20,face='bold'),panel.grid.major = element_blank(), panel.grid.minor = element_blank(),legend.title=element_text(size=20,face="bold"),legend.position = 'none')


setwd("E:/MW_ClimateChange/Data for frontiers paper/Draft/Edits")  
ggsave("cwd_ensemble_edited_nl.jpeg",width = 12, height=8)

setwd("E:/MW_ClimateChange/Data for frontiers paper/NewModels/Basin/Superior/Summer")

tp_sup<- read.csv("TP_s6_8.csv")
tp_sup_mean<- apply(tp_sup[,1:12],1,mean)

setwd("E:/MW_ClimateChange/Data for frontiers paper/NewModels/Basin/Ontario/Summer")
tp_ont<- read.csv("TP_s6_8.csv")
tp_ont_mean<- apply(tp_ont[,1:12],1,mean)

setwd("E:/MW_ClimateChange/Data for frontiers paper/NewModels/Basin/Michigan/Summer")
tp_michigan<- read.csv("TP_s6_8.csv")
tp_mich_mean<- apply(tp_michigan[,1:12],1,mean)

setwd("E:/MW_ClimateChange/Data for frontiers paper/NewModels/Basin/Huron/Summer")
tp_huron<- read.csv("TP_s6_8.csv")
tp_huron_mean<- apply(tp_huron[,1:12],1,mean)
setwd("E:/MW_ClimateChange/Data for frontiers paper/NewModels/Basin/Erie/Summer")
tp_erie<- read.csv("TP_s6_8.csv")
tp_erie_mean<- apply(tp_erie[,1:12],1,mean)
cpc_basin_tp<- data.frame(tp_sup$cpc,tp_ont$cpc,tp_michigan$cpc,tp_huron$cpc,tp_erie$cpc)
colnames(cpc_basin_tp)<- lakes
cpc_basin_tp$Type<- cpc
mean_basin_tp<- data.frame(tp_sup_mean,tp_ont_mean,tp_mich_mean,tp_huron_mean,tp_erie_mean)
colnames(mean_basin_tp)<- lakes
mean_basin_tp$Type<- en
tp<- rbind(mean_basin_tp,cpc_basin_tp)
tp<- tp[,c(1,3,4,5,2,6)]
c<- reshape2::melt(tp,id="Type")
ggplot(data = c,aes(x=variable,y=value,fill=Type))+
  geom_boxplot()+
  scale_fill_manual(values= colors1)+
  xlab("Basins")+
  ylab("TP")+
  #ggtitle("Total Precipitation")+
  theme_bw()+
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())+
  theme(axis.text.x = element_text(angle = 0, hjust = 1,size=12,face='bold'),axis.text.y = element_text(angle = 0, hjust = 1,size=12,face='bold'),axis.title=element_text(size=12,face="bold"),plot.title=element_text(size=30,face='bold'),panel.grid.major = element_blank(), panel.grid.minor = element_blank(),legend.title=element_text(size=30,face="bold"),legend.position = 'none')


setwd("E:/MW_ClimateChange/Data for frontiers paper/Draft/Edits")
ggsave("tp_ensemble_edited_nl.jpeg",width = 12, height=8)
setwd("E:/MW_ClimateChange/Data for frontiers paper/NewModels/Basin/Superior/Summer")

mdp_sup<- read.csv("MDP_s6_8.csv")
mdp_sup_mean<- apply(mdp_sup[,1:12],1,mean)

setwd("E:/MW_ClimateChange/Data for frontiers paper/NewModels/Basin/Ontario/Summer")
mdp_ont<- read.csv("MDP_s6_8.csv")
mdp_ont_mean<- apply(mdp_ont[,1:12],1,mean)

setwd("E:/MW_ClimateChange/Data for frontiers paper/NewModels/Basin/Michigan/Summer")
mdp_michigan<- read.csv("MDP_s6_8.csv")
mdp_mich_mean<- apply(mdp_michigan[,1:12],1,mean)

setwd("E:/MW_ClimateChange/Data for frontiers paper/NewModels/Basin/Huron/Summer")
mdp_huron<- read.csv("MDP_s6_8.csv")
mdp_huron_mean<- apply(mdp_huron[,1:12],1,mean)
setwd("E:/MW_ClimateChange/Data for frontiers paper/NewModels/Basin/Erie/Summer")
mdp_erie<- read.csv("MDP_s6_8.csv")
mdp_erie_mean<- apply(mdp_erie[,1:12],1,mean)
cpc_basin_mdp<- data.frame(mdp_sup$cpc,mdp_ont$cpc,mdp_michigan$cpc,mdp_huron$cpc,mdp_erie$cpc)
colnames(cpc_basin_mdp)<- lakes
cpc_basin_mdp$Type<- cpc
mean_basin_mdp<- data.frame(mdp_sup_mean,mdp_ont_mean,mdp_mich_mean,mdp_huron_mean,mdp_erie_mean)
colnames(mean_basin_mdp)<- lakes
mean_basin_mdp$Type<- en
mdp<- rbind(mean_basin_mdp,cpc_basin_mdp)
mdp<- mdp[,c(1,3,4,5,2,6)]
d<- reshape2:: melt(mdp,id="Type")
ggplot(data = d,aes(x=variable,y=value,fill=Type))+
  geom_boxplot()+
  scale_fill_manual(values= colors1)+
  xlab("Basins")+
  ylab("mm")+
  #ggtitle("Maximum Daily Precipitation")+
  theme_bw()+
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())+
  theme(axis.text.x = element_text(face='bold',size=10),axis.text.y = element_text(face='bold',size=10))
setwd("E:/MW_ClimateChange/Data for frontiers paper/Draft/Edits")
ggsave("mdp_ensemble_edited.jpeg",width = 12, height=8)

setwd("E:/MW_ClimateChange/Data for frontiers paper/NewModels/Basin/Superior/Summer")

epd_sup<- read.csv("EPD_s6_8.csv")
epd_sup_mean<- apply(epd_sup[,1:12],1,mean)

setwd("E:/MW_ClimateChange/Data for frontiers paper/NewModels/Basin/Ontario/Summer")
epd_ont<- read.csv("EPD_s6_8.csv")
epd_ont_mean<- apply(epd_ont[,1:12],1,mean)

setwd("E:/MW_ClimateChange/Data for frontiers paper/NewModels/Basin/Michigan/Summer")
epd_michigan<- read.csv("EPD_s6_8.csv")
epd_mich_mean<- apply(epd_michigan[,1:12],1,mean)

setwd("E:/MW_ClimateChange/Data for frontiers paper/NewModels/Basin/Huron/Summer")
epd_huron<- read.csv("EPD_s6_8.csv")
epd_huron_mean<- apply(epd_huron[,1:12],1,mean)
setwd("E:/MW_ClimateChange/Data for frontiers paper/NewModels/Basin/Erie/Summer")
epd_erie<- read.csv("EPD_s6_8.csv")
epd_erie_mean<- apply(epd_erie[,1:12],1,mean)
cpc_basin_epd<- data.frame(epd_sup$cpc,epd_ont$cpc,epd_michigan$cpc,epd_huron$cpc,epd_erie$cpc)
colnames(cpc_basin_epd)<- lakes
cpc_basin_epd$Type<- cpc
mean_basin_epd<- data.frame(epd_sup_mean,epd_ont_mean,epd_mich_mean,epd_huron_mean,epd_erie_mean)
colnames(mean_basin_epd)<- lakes
mean_basin_epd$Type<- en
epd<- rbind(mean_basin_epd,cpc_basin_epd)
epd<- epd[,c(1,3,4,5,2,6)]
e<- reshape2::melt(epd,id="Type")
ggplot(data = e,aes(x=variable,y=value,fill=Type))+
  geom_boxplot()+
  scale_fill_manual(values= colors1)+
  xlab("Basins")+
  ylab("Days")+
  #ggtitle("Extreme Precipitation Days")+
  theme_bw()+
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())+
  theme(axis.text.x = element_text(angle = 0, hjust = 1,size=12,face='bold'),axis.text.y = element_text(angle = 0, hjust = 1,size=12,face='bold'),axis.title=element_text(size=12,face="bold"),plot.title=element_text(size=30,face='bold'),panel.grid.major = element_blank(), panel.grid.minor = element_blank(),legend.title=element_text(size=30,face="bold"))

  
setwd("E:/MW_ClimateChange/Data for frontiers paper/Draft/Edits")
ggsave("epd_ensemble_edited_nl.jpeg",width = 12, height=8)
setwd("E:/MW_ClimateChange/Data for frontiers paper/NewModels/Basin/Superior/Summer")

ratio_sup<- read.csv("ratio_s6_8.csv")
ratio_sup_mean<- apply(ratio_sup[,2:13],1,mean)

setwd("E:/MW_ClimateChange/Data for frontiers paper/NewModels/Basin/Ontario/Summer")
ratio_ont<- read.csv("ratio_s6_8.csv")
ratio_ont_mean<- apply(ratio_ont[,2:13],1,mean)

setwd("E:/MW_ClimateChange/Data for frontiers paper/NewModels/Basin/Michigan/Summer")
ratio_michigan<- read.csv("ratio_s6_8.csv")
ratio_mich_mean<- apply(ratio_michigan[,2:13],1,mean)

setwd("E:/MW_ClimateChange/Data for frontiers paper/NewModels/Basin/Huron/Summer")
ratio_huron<- read.csv("ratio_s6_8.csv")
ratio_huron_mean<- apply(ratio_huron[,2:13],1,mean)
setwd("E:/MW_ClimateChange/Data for frontiers paper/NewModels/Basin/Erie/Summer")
ratio_erie<- read.csv("ratio_s6_8.csv")
ratio_erie_mean<- apply(ratio_erie[,2:13],1,mean)
cpc_basin_ratio<- data.frame(ratio_sup$X13,ratio_ont$X13,ratio_michigan$X13,ratio_huron$X13,ratio_erie$X13)
colnames(cpc_basin_ratio)<- c("Superior","Ontario","Michigan","Huron","Erie")
cpc_basin_ratio$Type<- cpc
mean_basin_ratio<- data.frame(ratio_sup_mean,ratio_ont_mean,ratio_mich_mean,ratio_huron_mean,ratio_erie_mean)
colnames(mean_basin_ratio)<- c("Superior","Ontario","Michigan","Huron","Erie")
mean_basin_ratio$Type<- en
ratio<- rbind(mean_basin_ratio,cpc_basin_ratio)
ratio<- ratio[,c(1,3,4,5,2,6)]
e<- melt(ratio,id="Type")
ggplot(data = e,aes(x=variable,y=value,fill=Type))+
  geom_boxplot()+
  ylim(c(0,1))+
  xlab("Basins")+
  ylab("Ratio")+
  ggtitle("Fraction of Precipitation from Extreme Precipitation")
setwd("E:/MW_ClimateChange/Data for frontiers paper/Draft/Edits")
ggsave("ratio_ensemble.jpeg",width = 12, height=8)

setwd("E:/MW_ClimateChange/Data for frontiers paper/NewModels/Basin/Superior/Summer")

ratio_sup<- read.csv("ratio_s6_8.csv")
ratio_sup_mean<- apply(ratio_sup[,2:13],1,mean)

setwd("E:/MW_ClimateChange/Data for frontiers paper/NewModels/Basin/Ontario/Summer")
ratio_ont<- read.csv("ratio_s6_8.csv")
ratio_ont_mean<- apply(ratio_ont[,2:13],1,mean)

setwd("E:/MW_ClimateChange/Data for frontiers paper/NewModels/Basin/Michigan/Summer")
ratio_michigan<- read.csv("ratio_s6_8.csv")
ratio_mich_mean<- apply(ratio_michigan[,2:13],1,mean)

setwd("E:/MW_ClimateChange/Data for frontiers paper/NewModels/Basin/Huron/Summer")
ratio_huron<- read.csv("ratio_s6_8.csv")
ratio_huron_mean<- apply(ratio_huron[,2:13],1,mean)
setwd("E:/MW_ClimateChange/Data for frontiers paper/NewModels/Basin/Erie/Summer")
ratio_erie<- read.csv("ratio_s6_8.csv")
ratio_erie_mean<- apply(ratio_erie[,2:13],1,mean)
cpc_basin_ratio<- data.frame(ratio_sup$X13,ratio_ont$X13,ratio_michigan$X13,ratio_huron$X13,ratio_erie$X13)
lakes<- c("Superior","Ontario","Michigan","Huron","Erie")
colnames(cpc_basin_ratio)<- lakes
cpc_basin_ratio$Type<- cpc
mean_basin_ratio<- data.frame(ratio_sup_mean,ratio_ont_mean,ratio_mich_mean,ratio_huron_mean,ratio_erie_mean)
colnames(mean_basin_ratio)<- lakes
mean_basin_ratio$Type<- en
ratio<- rbind(mean_basin_ratio,cpc_basin_ratio)
e<- melt(ratio,id="Type")
ggplot(data = e,aes(x=variable,y=value,fill=Type))+
  geom_boxplot()+
  ylim(c(0,1))+
  xlab("Basins")+
  ylab("Ratio")+
  ggtitle("Fraction of Precipitation from Extreme Precipitation")
setwd("E:/MW_ClimateChange/Data for frontiers paper/NewModels/Basin/Superior/Summer")

fday_sup<- read.csv("5day.csv")
fday_sup_mean<- apply(fday_sup[,2:13],1,mean)

setwd("E:/MW_ClimateChange/Data for frontiers paper/NewModels/Basin/Ontario/Summer")
fday_ont<- read.csv("5day.csv")
fday_ont_mean<- apply(fday_ont[,2:13],1,mean)

setwd("E:/MW_ClimateChange/Data for frontiers paper/NewModels/Basin/Michigan/Summer")
fday_michigan<- read.csv("5day.csv")
fday_mich_mean<- apply(fday_michigan[,2:13],1,mean)

setwd("E:/MW_ClimateChange/Data for frontiers paper/NewModels/Basin/Huron/Summer")
fday_huron<- read.csv("5day.csv")
fday_huron_mean<- apply(fday_huron[,2:13],1,mean)
setwd("E:/MW_ClimateChange/Data for frontiers paper/NewModels/Basin/Erie/Summer")
fday_erie<- read.csv("5day.csv")
fday_erie_mean<- apply(fday_erie[,2:13],1,mean)
cpc_basin_fday<- data.frame(fday_sup$V13,fday_ont$V13,fday_michigan$V13,fday_huron$V13,fday_erie$V13)
colnames(cpc_basin_fday)<- lakes
cpc_basin_fday$Type<- cpc
mean_basin_fday<- data.frame(fday_sup_mean,fday_ont_mean,fday_mich_mean,fday_huron_mean,fday_erie_mean)
colnames(mean_basin_fday)<- lakes
mean_basin_fday$Type<- en
fday<- rbind(mean_basin_fday,cpc_basin_fday)
fday<- fday[,c(1,3,4,5,2,6)]
f<- reshape2::melt(fday,id="Type")
ggplot(data = f,aes(x=variable,y=value,fill=Type))+
  geom_boxplot()+
  scale_fill_manual(values= colors1)+
  xlab("Basins")+
  ylab("Five Days Precipitation(mm)")+
  ggtitle("FDAY")

setwd("E:/MW_ClimateChange/Data for frontiers paper/Draft/Edits")
ggsave("fday_ensemble.jpeg",width = 12, height=8)
