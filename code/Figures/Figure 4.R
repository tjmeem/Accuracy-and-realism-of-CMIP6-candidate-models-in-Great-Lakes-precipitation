library(readr)

#setwd("G:/LCS-Filer/ekcarter_r/MW_ClimateChange/code")            
source("ivss.R")
url_fig4 <- "https://zenodo.org/record/17316002/files/Figure%204.zip?download=1"
zip4 <- tempfile(fileext = ".zip")
download.file(url_fig4, zip4, mode = "wb")
dir.create("./processed_data/Figure_4", showWarnings = FALSE, recursive = TRUE)
unzip(zip4, exdir = "./processed_data/Figure_4")
#model1
setwd("./trace_p/acess")
cdd_m1<- read.csv("CDD_s6_8.csv")
cwd_m1<- read.csv("CWD_s6_8.csv")
epd_m1<- read.csv("EPD_s6_8.csv")
tp_m1<- read.csv("TP_s6_8.csv")
mdp_m1<- read.csv("MDP_s6_8.csv")

setwd("./trace_p/resample/acess")
cdd_o1<- read.csv("CDD_s6_8.csv")
cwd_o1<- read.csv("CWD_s6_8.csv")
epd_o1<- read.csv("EPD_s6_8.csv")
tp_o1<- read.csv("TP_s6_8.csv")
mdp_o1<- read.csv("MDP_s6_8.csv")

cdd_v1<- IVSS(model=cdd_m1,observed=cdd_o1)
cwd_v1<- IVSS(model=cwd_m1,observed = cwd_o1)
epd_v1<- IVSS(model=epd_m1,observed = epd_o1)
mdp_v1<- IVSS(model=mdp_m1,observed = mdp_o1)
tp_v1<- IVSS(model=tp_m1,observed = tp_o1)

#model2
setwd("./trace_p/Bcc")
cdd_m2<- read.csv("CDD_s6_8.csv")
cwd_m2<- read.csv("CWD_s6_8.csv")
epd_m2<- read.csv("EPD_s6_8.csv")
tp_m2<- read.csv("TP_s6_8.csv")
mdp_m2<- read.csv("MDP_s6_8.csv")

setwd("./trace_p/resample/bcc")
cdd_o2<- read.csv("CDD_s6_8.csv")
cwd_o2<- read.csv("CWD_s6_8.csv")
epd_o2<- read.csv("EPD_s6_8.csv")
tp_o2<- read.csv("TP_s6_8.csv")
mdp_o2<- read.csv("MDP_s6_8.csv")

cdd_v2<- IVSS(model=cdd_m2,observed=cdd_o2)
cwd_v2<- IVSS(model=cwd_m2,observed = cwd_o2)
epd_v2<- IVSS(model=epd_m2,observed = epd_o2)
mdp_v2<- IVSS(model=mdp_m2,observed = mdp_o2)
tp_v2<- IVSS(model=tp_m2,observed = tp_o2)

setwd("./trace_p/canesm")
cdd_m3<- read.csv("CDD_s6_8.csv")
cwd_m3<- read.csv("CWD_s6_8.csv")
epd_m3<- read.csv("EPD_s6_8.csv")
tp_m3<- read.csv("TP_s6_8.csv")
mdp_m3<- read.csv("MDP_s6_8.csv")

setwd("./trace_p/resample/canesm")
cdd_o3<- read.csv("CDD_s6_8.csv")
cwd_o3<- read.csv("CWD_s6_8.csv")
epd_o3<- read.csv("EPD_s6_8.csv")
tp_o3<- read.csv("TP_s6_8.csv")
mdp_o3<- read.csv("MDP_s6_8.csv")

cdd_v3<- IVSS(model=cdd_m3,observed=cdd_o3)
cwd_v3<- IVSS(model=cwd_m3,observed = cwd_o3)
epd_v3<- IVSS(model=epd_m3,observed = epd_o3)
mdp_v3<- IVSS(model=mdp_m3,observed = mdp_o3)
tp_v3<- IVSS(model=tp_m3,observed = tp_o3)

#model4
setwd("./trace_p/cnrm")
cdd_m4<- read.csv("CDD_s6_8.csv")
cwd_m4<- read.csv("CWD_s6_8.csv")
epd_m4<- read.csv("EPD_s6_8.csv")
tp_m4<- read.csv("TP_s6_8.csv")
mdp_m4<- read.csv("MDP_s6_8.csv")

setwd("./trace_p/resample/cnrm")
cdd_o4<- read.csv("CDD_s6_8.csv")
cwd_o4<- read.csv("CWD_s6_8.csv")
epd_o4<- read.csv("EPD_s6_8.csv")
tp_o4<- read.csv("TP_s6_8.csv")
mdp_o4<- read.csv("MDP_s6_8.csv")

cdd_v4<- IVSS(model=cdd_m4,observed=cdd_o4)
cwd_v4<- IVSS(model=cwd_m4,observed = cwd_o4)
epd_v4<- IVSS(model=epd_m4,observed = epd_o4)
mdp_v4<- IVSS(model=mdp_m4,observed = mdp_o4)
tp_v4<- IVSS(model=tp_m4,observed = tp_o4)


#model 5
setwd("./trace_p/ec")
cdd_m5<- read.csv("CDD_s6_8.csv")
cwd_m5<- read.csv("CWD_s6_8.csv")
epd_m5<- read.csv("EPD_s6_8.csv")
tp_m5<- read.csv("TP_s6_8.csv")
mdp_m5<- read.csv("MDP_s6_8.csv")

setwd("./trace_p/resample/ec_earth")
cdd_o5<- read.csv("CDD_s6_8.csv")
cwd_o5<- read.csv("CWD_s6_8.csv")
epd_o5<- read.csv("EPD_s6_8.csv")
tp_o5<- read.csv("TP_s6_8.csv")
mdp_o5<- read.csv("MDP_s6_8.csv")

cdd_v5<- IVSS(model=cdd_m5,observed=cdd_o5)
cwd_v5<- IVSS(model=cwd_m5,observed = cwd_o5)
epd_v5<- IVSS(model=epd_m5,observed = epd_o5)
mdp_v5<- IVSS(model=mdp_m5,observed = mdp_o5)
tp_v5<- IVSS(model=tp_m5,observed = tp_o5)

#model 6
setwd("./trace_p/gfdl")
cdd_m6<- read.csv("CDD_s6_8.csv")
cwd_m6<- read.csv("CWD_s6_8.csv")
epd_m6<- read.csv("EPD_s6_8.csv")
tp_m6<- read.csv("TP_s6_8.csv")
mdp_m6<- read.csv("MDP_s6_8.csv")

setwd("./trace_p/resample/gfdl")
cdd_o6<- read.csv("CDD_s6_8.csv")
cwd_o6<- read.csv("CWD_s6_8.csv")
epd_o6<- read.csv("EPD_s6_8.csv")
tp_o6<- read.csv("TP_s6_8.csv")
mdp_o6<- read.csv("MDP_s6_8.csv")

cdd_v6<- IVSS(model=cdd_m6,observed=cdd_o6)
cwd_v6<- IVSS(model=cwd_m6,observed = cwd_o6)
epd_v6<- IVSS(model=epd_m6,observed = epd_o6)
mdp_v6<- IVSS(model=mdp_m6,observed = mdp_o6)
tp_v6<- IVSS(model=tp_m6,observed = tp_o6)

#model 7
#model7
setwd("./trace_p/inm")
cdd_m7<- read.csv("CDD_s6_8.csv")
cwd_m7<- read.csv("CWD_s6_8.csv")
epd_m7<- read.csv("EPD_s6_8.csv")
tp_m7<- read.csv("TP_s6_8.csv")
mdp_m7<- read.csv("MDP_s6_8.csv")

setwd("./trace_p/resample/inm")
cdd_o7<- read.csv("CDD_s6_8.csv")
cwd_o7<- read.csv("CWD_s6_8.csv")
epd_o7<- read.csv("EPD_s6_8.csv")
tp_o7<- read.csv("TP_s6_8.csv")
mdp_o7<- read.csv("MDP_s6_8.csv")

cdd_v7<- IVSS(model=cdd_m7,observed=cdd_o7)
cwd_v7<- IVSS(model=cwd_m7,observed = cwd_o7)
epd_v7<- IVSS(model=epd_m7,observed = epd_o7)
mdp_v7<- IVSS(model=mdp_m7,observed = mdp_o7)
tp_v7<- IVSS(model=tp_m7,observed = tp_o7)

#model8
setwd("./trace_p/ipsl")
cdd_m8<- read.csv("CDD_s6_8.csv")
cwd_m8<- read.csv("CWD_s6_8.csv")
epd_m8<- read.csv("EPD_s6_8.csv")
tp_m8<- read.csv("TP_s6_8.csv")
mdp_m8<- read.csv("MDP_s6_8.csv")

setwd("./trace_p/resample/ipsl")
cdd_o8<- read.csv("CDD_s6_8.csv")
cwd_o8<- read.csv("CWD_s6_8.csv")
epd_o8<- read.csv("EPD_s6_8.csv")
tp_o8<- read.csv("TP_s6_8.csv")
mdp_o8<- read.csv("MDP_s6_8.csv")

cdd_v8<- IVSS(model=cdd_m8,observed=cdd_o8)
cwd_v8<- IVSS(model=cwd_m8,observed = cwd_o8)
epd_v8<- IVSS(model=epd_m8,observed = epd_o8)
mdp_v8<- IVSS(model=mdp_m8,observed = mdp_o8)
tp_v8<- IVSS(model=tp_m8,observed = tp_o8)

setwd("./trace_p/miroc")
cdd_m9<- read.csv("CDD_s6_8.csv")
cwd_m9<- read.csv("CWD_s6_8.csv")
epd_m9<- read.csv("EPD_s6_8.csv")
tp_m9<- read.csv("TP_s6_8.csv")
mdp_m9<- read.csv("MDP_s6_8.csv")

setwd("./trace_p/resample/miroc")
cdd_o9<- read.csv("CDD_s6_8.csv")
cwd_o9<- read.csv("CWD_s6_8.csv")
epd_o9<- read.csv("EPD_s6_8.csv")
tp_o9<- read.csv("TP_s6_8.csv")
mdp_o9<- read.csv("MDP_s6_8.csv")

cdd_v9<- IVSS(model=cdd_m9,observed=cdd_o9)
cwd_v9<- IVSS(model=cwd_m9,observed = cwd_o9)
epd_v9<- IVSS(model=epd_m9,observed = epd_o9)
mdp_v9<- IVSS(model=mdp_m9,observed = mdp_o9)
tp_v9<- IVSS(model=tp_m9,observed = tp_o9)

#model10
setwd("./trace_p/mpi")
cdd_m10<- read.csv("CDD_s6_8.csv")
cwd_m10<- read.csv("CWD_s6_8.csv")
epd_m10<- read.csv("EPD_s6_8.csv")
tp_m10<- read.csv("TP_s6_8.csv")
mdp_m10<- read.csv("MDP_s6_8.csv")

setwd("./trace_p/resample/mpi")
cdd_o10<- read.csv("CDD_s6_8.csv")
cwd_o10<- read.csv("CWD_s6_8.csv")
epd_o10<- read.csv("EPD_s6_8.csv")
tp_o10<- read.csv("TP_s6_8.csv")
mdp_o10<- read.csv("MDP_s6_8.csv")

cdd_v10<- IVSS(model=cdd_m10,observed=cdd_o10)
cwd_v10<- IVSS(model=cwd_m10,observed = cwd_o10)
epd_v10<- IVSS(model=epd_m10,observed = epd_o10)
mdp_v10<- IVSS(model=mdp_m10,observed = mdp_o10)
tp_v10<- IVSS(model=tp_m10,observed = tp_o10)
#11
setwd("./trace_p/mri")
cdd_m11<- read.csv("CDD_s6_8.csv")
cwd_m11<- read.csv("CWD_s6_8.csv")
epd_m11<- read.csv("EPD_s6_8.csv")
tp_m11<- read.csv("TP_s6_8.csv")
mdp_m11<- read.csv("MDP_s6_8.csv")

setwd("./trace_p/resample/mri")
cdd_o11<- read.csv("CDD_s6_8.csv")
cwd_o11<- read.csv("CWD_s6_8.csv")
epd_o11<- read.csv("EPD_s6_8.csv")
tp_o11<- read.csv("TP_s6_8.csv")
mdp_o11<- read.csv("MDP_s6_8.csv")

cdd_v11<- IVSS(model=cdd_m11,observed=cdd_o11)
cwd_v11<- IVSS(model=cwd_m11,observed = cwd_o11)
epd_v11<- IVSS(model=epd_m11,observed = epd_o11)
mdp_v11<- IVSS(model=mdp_m11,observed = mdp_o11)
tp_v11<- IVSS(model=tp_m11,observed = tp_o11)

#12
setwd("./trace_p/ukesm")
cdd_m12<- read.csv("CDD_s6_8.csv")
cwd_m12<- read.csv("CWD_s6_8.csv")
epd_m12<- read.csv("EPD_s6_8.csv")
tp_m12<- read.csv("TP_s6_8.csv")
mdp_m12<- read.csv("MDP_s6_8.csv")

setwd("./trace_p/resample/ukesm")
cdd_o12<- read.csv("CDD_s6_8.csv")
cwd_o12<- read.csv("CWD_s6_8.csv")
epd_o12<- read.csv("EPD_s6_8.csv")
tp_o12<- read.csv("TP_s6_8.csv")
mdp_o12<- read.csv("MDP_s6_8.csv")

cdd_v12<- IVSS(model=cdd_m12,observed=cdd_o12)
cwd_v12<- IVSS(model=cwd_m12,observed = cwd_o12)
epd_v12<- IVSS(model=epd_m12,observed = epd_o12)
mdp_v12<- IVSS(model=mdp_m12,observed = mdp_o12)
tp_v12<- IVSS(model=tp_m12,observed = tp_o12)

models<- c("ACCESS","BCC","CANESM","CNRM","EC_EARTH","GFDL","INM","IPSL","MIROC","MPI","MRI","UKESM")
cdd<- c(cdd_v1,cdd_v2,cdd_v3,cdd_v4,cdd_v5,cdd_v6,cdd_v7,cdd_v8,cdd_v9,cdd_v10,cdd_v11,cdd_v12)
cwd<- c(cwd_v1,cwd_v2,cwd_v3,cwd_v4,cwd_v5,cwd_v6,cwd_v7,cwd_v8,cwd_v9,cwd_v10,cwd_v11,cwd_v12)
mdp<- c(mdp_v1,mdp_v2,mdp_v3,mdp_v4,mdp_v5,mdp_v6,mdp_v7,mdp_v8,mdp_v9,mdp_v10,mdp_v11,mdp_v12)
tp<- c(tp_v1,tp_v2,tp_v3,tp_v4,tp_v5,tp_v6,tp_v7,tp_v8,tp_v9,tp_v10,tp_v11,tp_v12)
epd<- c(epd_v1,epd_v2,epd_v3,epd_v4,epd_v5,epd_v6,epd_v7,epd_v8,epd_v9,epd_v10,epd_v11,epd_v12)

table<- data.frame(models,cdd,cwd,epd,tp,mdp)
table$n_cdd<- (table$cdd- median(table$cdd))/median(table$cdd)
table$n_cwd<- (table$cwd - median(table$cwd))/median(table$cwd)
table$n_epd<- (table$epd - median(table$epd))/median(table$epd)
table$n_mdp<- (table$mdp - median(table$mdp))/median(table$mdp)
table$n_tp<- (table$tp - median(table$tp))/median(table$tp)

nivss<- table[,c(1,7:11)]
MVI<- apply(nivss[,2:6],1,median)
MVI
nivss$MVI <- MVI
colnames(nivss)<- c("Models","CDD","CWD","EPD","MDP","TP","MVI")
x<- nivss[order(-MVI),]
m_nivss<- reshape2::melt(x)


m_nivss$Models<- as.factor(m_nivss$Models)
m_nivss$variable<- as.factor(m_nivss$variable)
library(RColorBrewer)
library(wesanderson)
library(ggplot2)
pal <- wes_palette("Zissou1", 100, type = "continuous")
pal1 <- wes_palette("GrandBudapest1", 100, type = "continuous")
pal2<- wes_palette("GrandBudapest2", 100, type = "continuous")
pal3<- wes_palette("Rushmore1", 100, type = "continuous")
pal4<- wes_palette("FantasticFox1",100,type="continuous")
pal5<- brewer.pal(name="BrBG",n=11)
pal6<- brewer.pal(name="BuPu",n=9)
pal7<- brewer.pal(name="RdBu",n=9)
lo<- c ('IPSL','CANESM','UKESM','BCC','CNRM','INM','GFDL','MIROC','ACCESS','MRI','MPI','EC_EARTH')
color_breaks<- c(-0.5,-0.4,-0.3,-0.2,-0.1,0,0.1,0.5,1,2,10)
color_breaks<- c(10,2,1,0.5,0.1,0,-0.1,-0.2,-0.3,-0.4,-0.5)
color_breaks_3<- c(10,1,2,0.5,0.1,0,-0.1,-0.2,-0.3,-0.4,-0.5)
cols1 <- colorRampPalette(pal5, space="rgb")(length(color_breaks))
ggplot(m_nivss)+
  geom_tile(aes(x= factor(Models,level=lo),y= factor(variable),fill=value))+ 
  scale_fill_gradientn(colours=rev(pal5),values=c(0,scales::rescale(color_breaks,from= range(m_nivss$value)),1),limits=range(m_nivss$value),breaks=color_breaks)+
  ylab("Precipitation Indices")+
  xlab("Model")+
  theme(axis.text.x = element_text(angle = 90, hjust = 1,size=18,face = 'bold'),axis.text.y = element_text(size=18,face = 'bold'),axis.title=element_text(size=18,face="bold"),panel.grid.major = element_blank(), panel.grid.minor = element_blank(),legend.position = "none")+
  theme(legend.position="none")

setwd("E:/MW_ClimateChange/Data for frontiers paper/Draft/Edits")
ggsave("portrait_bold.jpeg",width = 12, height=8)

setwd("E:/MW_ClimateChange/code")
source('plot_discrete_cbar.R')
setwd("E:/MW_ClimateChange/code")
source('plot_discrete_cbar.R')

plot_discrete_cbar(color_breaks, palette="BrBG", legend_title="NIVSS", spacing="constant",direction=-1)
setwd("E:/MW_ClimateChange/Data for frontiers paper/Draft/Edits")
ggsave("cs_dir.jpeg",width = 12, height=6)

