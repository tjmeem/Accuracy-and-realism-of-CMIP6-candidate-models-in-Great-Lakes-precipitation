setwd("C:/Users/tamee/Downloads/new_runs/cpc")
cpc<- read.csv("cwd_s6_8.csv")
cpc_avg<- (data.frame(apply(cpc[,1:5],1,mean)))
colnames(cpc_avg)<- "CWD"
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
setwd("C:/Users/tamee/Downloads/new_runs/access/historical")
access_hist<- read.csv("cwd_s6_8.csv")
access_hist_avg<- (data.frame(apply(access_hist[,1:5],1,mean)))
colnames(access_hist_avg)<- "CWD"
access_hist_avg$Timeline <- rep("Historical",36)
access_hist_avg$year<- seq(1979,2014,1)
intercept_access<- rep(mean(access_hist_avg$CWD),2)
setwd("C:/Users/tamee/Downloads/new_runs/access/ssp370")
access_ssp370<- read.csv("cwd_s6_8.csv")
access_ssp370_avg<- (data.frame(apply(access_ssp370[,1:5],1,mean)))
colnames(access_ssp370_avg)<- "CWD"
access_ssp370_avg$Timeline<- rep("SSP3-7.0",86)
access_ssp370_avg$year<- seq(2015,2100,1)
yr<- seq(0,85,1)
acess_fit_370<- lm(access_ssp370_avg$CWD ~ yr)
access_slope_370<- acess_fit_370$coefficients[2]
setwd("C:/Users/tamee/Downloads/new_runs/access/ssp585")
access_ssp585<- read.csv("cwd_s6_8.csv")
access_ssp585_avg<- (data.frame(apply(access_ssp585[,1:5],1,mean)))
colnames(access_ssp585_avg)<- "CWD"
access_ssp585_avg$Timeline<- rep("SSP5-8.5",86)
access_ssp585_avg$year<- seq(2015,2100,1)
acess_fit_585<- lm(access_ssp585_avg$CWD ~ yr)
access_slope_585<- acess_fit_585$coefficients[2]
access_full<- rbind(access_hist_avg,access_ssp370_avg,access_ssp585_avg)
access_full$Model<- rep("ACCESS",208) 

#Ec_earth
setwd("C:/Users/tamee/Downloads/new_runs/ec_earth/historical")
ec_hist<- read.csv("cwd_s6_8.csv")
ec_hist_avg<- data.frame(apply(ec_hist[,1:5],1,mean))
colnames(ec_hist_avg)<- "CWD"
ec_hist_avg$Timeline<- rep("Historical",36)
ec_hist_avg$year<- seq(1979,2014,1)
intercept_ec<- rep(mean(ec_hist_avg$CWD),2)
setwd("C:/Users/tamee/Downloads/new_runs/ec_earth/ssp370")
ec_ssp370<- read.csv("cwd_s6_8.csv")
ec_ssp370_avg<- (data.frame(apply(ec_ssp370[,1:5],1,mean)))
colnames(ec_ssp370_avg)<- "CWD"
ec_ssp370_avg$Timeline<- rep("SSP3-7.0",86)
ec_ssp370_avg$year<- seq(2015,2100,1)
ec_fit_370<- lm(ec_ssp370_avg$CWD ~ yr)
ec_slope_370<- ec_fit_370$coefficients[2]
setwd("C:/Users/tamee/Downloads/new_runs/ec_earth/ssp585")
ec_ssp585<- read.csv("CWD_s6_8.csv")
ec_ssp585_avg<- (data.frame(apply(ec_ssp585[,1:5],1,mean)))
colnames(ec_ssp585_avg)<- "CWD"
ec_ssp585_avg$Timeline<- rep("SSP5-8.5",86)
ec_ssp585_avg$year<- seq(2015,2100,1)
ec_fit_585<- lm(ec_ssp585_avg$CWD ~ yr)
ec_slope_585<- ec_fit_585$coefficients[2]
ec_full<- rbind(ec_hist_avg,ec_ssp370_avg,ec_ssp585_avg)
ec_full$Model<- rep("EC_EARTH",208)

#MIROC
setwd("C:/Users/tamee/Downloads/new_runs/miroc/historical")
miroc_hist<- read.csv("cwd_s6_8.csv")
miroc_hist_avg<- data.frame(apply(miroc_hist[,1:5],1,mean))
colnames(miroc_hist_avg)<- "CWD"
miroc_hist_avg$Timeline<- rep("Historical",36)
miroc_hist_avg$year<- seq(1979,2014,1)
intercept_miroc<- rep(mean(miroc_hist_avg$CWD),2)
setwd("C:/Users/tamee/Downloads/new_runs/miroc/ssp370")
miroc_ssp370<- read.csv("CWD_s6_8.csv")
miroc_ssp370_avg<- data.frame(apply(miroc_ssp370[,1:5],1,mean))
colnames(miroc_ssp370_avg)<- "CWD"
miroc_ssp370_avg$Timeline<- rep("SSP3-7.0",86)
miroc_ssp370_avg$year<- seq(2015,2100,1)
miroc_fit_ssp370<- lm(miroc_ssp370_avg$CWD ~ yr)
miroc_slope_370<- miroc_fit_ssp370$coefficients[2]
setwd("C:/Users/tamee/Downloads/new_runs/miroc/ssp585")
miroc_ssp585<- read.csv("CWD_s6_8.csv")
miroc_ssp585_avg<- data.frame(apply(miroc_ssp585[,1:5],1,mean))
colnames(miroc_ssp585_avg)<- "CWD"
miroc_ssp585_avg$Timeline<- rep("SSP5-8.5",86)
miroc_ssp585_avg$year<- seq(2015,2100,1)
miroc_fit_ssp585<- lm(miroc_ssp585_avg$CWD ~ yr)
miroc_slope_585<- miroc_fit_ssp585$coefficients[2]
miroc_full<- rbind(miroc_hist_avg,miroc_ssp370_avg,miroc_ssp585_avg)
miroc_full$Model <- rep("MIROC",208)

#MPI
setwd("C:/Users/tamee/Downloads/new_runs/MPI/historical")
mpi_hist<- read.csv("cwd_s6_8.csv")
mpi_hist_avg<- data.frame(apply(mpi_hist[,1:5],1,mean))
colnames(mpi_hist_avg)<- "CWD"
mpi_hist_avg$Timeline<- rep("Historical",36)
mpi_hist_avg$year<- seq(1979,2014,1)
intercept_mpi<- rep(mean(mpi_hist_avg$CWD),2)
setwd("C:/Users/tamee/Downloads/new_runs/MPI/ssp370")
mpi_ssp370<- read.csv("CWD_s6_8.csv")
mpi_ssp370_avg<- data.frame(apply(mpi_ssp370[,1:5],1,mean))
colnames(mpi_ssp370_avg)<- "CWD"
mpi_ssp370_avg$Timeline<- rep("SSP3-7.0",86)
mpi_ssp370_avg$year<- seq(2015,2100)
mpi_fit_ssp370<- lm(mpi_ssp370_avg$CWD ~ yr)
mpi_slope_370<- mpi_fit_ssp370$coefficients[2]
setwd("C:/Users/tamee/Downloads/new_runs/MPI/ssp585")
mpi_ssp585<- read.csv("CWD_s6_8.csv")
mpi_ssp585_avg<- data.frame(apply(mpi_ssp585[,1:5],1,mean))
colnames(mpi_ssp585_avg)<- "CWD"
mpi_ssp585_avg$Timeline<- rep("SSP5-8.5",86)
mpi_ssp585_avg$year<- seq(2015,2100)
mpi_fit_ssp585<- lm(mpi_ssp585_avg$CWD ~ yr)
mpi_slope_585<- mpi_fit_ssp585$coefficients[2]
mpi_full<- rbind(mpi_hist_avg,mpi_ssp370_avg,mpi_ssp585_avg)
mpi_full$Model<- rep("MPI",208)

#MRI
setwd("C:/Users/tamee/Downloads/new_runs/MRI/historical")
mri_hist<- read.csv("cwd_s6_8.csv")
mri_hist_avg<- data.frame(apply(mri_hist[,1:5],1,mean))
colnames(mri_hist_avg)<- "CWD"
mri_hist_avg$year<- seq(1979,2014,1)
mri_hist_avg$Timeline<- rep("Historical",36)
intercept_mri<- rep(mean(mri_hist_avg$CWD),2)
setwd("C:/Users/tamee/Downloads/new_runs/MRI/ssp370")
mri_ssp370<- read.csv("CWD_s6_8.csv")
mri_ssp370_avg<- data.frame(apply(mri_ssp370[,1:5],1,mean))
colnames(mri_ssp370_avg)<- "CWD"
mri_ssp370_avg$Timeline<- rep("SSP3-7.0",86)
mri_ssp370_avg$year<- seq(2015,2100)
mri_fit_ssp370<- lm(mri_ssp370_avg$CWD ~ yr)
mri_slope_370<- mri_fit_ssp370$coefficients[2]
setwd("C:/Users/tamee/Downloads/new_runs/MRI/ssp585")
mri_ssp585<- read.csv("CWD_s6_8.csv")
mri_ssp585_avg<- data.frame(apply(mri_ssp585[,1:5],1,mean))
colnames(mri_ssp585_avg)<- "CWD"
mri_ssp585_avg$Timeline<- rep("SSP5-8.5",86)
mri_ssp585_avg$year<- seq(2015,2100)
mri_fit_ssp585<- lm(mri_ssp585_avg$CWD ~ yr)
mri_slope_585<- mri_fit_ssp585$coefficients[2]
mri_full<- rbind(mri_hist_avg,mri_ssp370_avg,mri_ssp585_avg)
mri_full$Model<- rep("MRI",208)
cwd_all<- rbind(cpc_all,access_full,ec_full,miroc_full,mpi_full,mri_full)

slope_all<-c(ec_slope_370,ec_slope_585,mpi_slope_370,mpi_slope_585,mri_slope_370,mri_slope_585,access_slope_370,access_slope_585,miroc_slope_370,miroc_slope_585)
pvalue_all<- c(summary(ec_fit_370)$coefficients[,4][2],summary(ec_fit_585)$coefficients[,4][2],summary(mpi_fit_ssp370)$coefficients[,4][2],summary(mpi_fit_ssp585)$coefficients[,4][2],summary(mri_fit_ssp370)$coefficients[,4][2],summary(mri_fit_ssp585)$coefficients[,4][2],summary(acess_fit_370)$coefficients[,4][2],summary(acess_fit_585)$coefficients[,4][2],summary(miroc_fit_ssp370)$coefficients[,4][2],summary(miroc_fit_ssp585)$coefficients[,4][2])
slope_all<- data.frame(slope_all)
pvalue<- data.frame(pvalue_all)
colnames(slope_all)<- c('slope')
colnames(pvalue)<- c('p_value')
slope_all$Model<- c("EC_EARTH","EC_EARTH","MPI","MPI","MRI","MRI","ACCESS","ACCESS","MIROC","MIROC")
slope_all$Timeline<-c("SSP3-7.0","SSP5-8.5","SSP3-7.0","SSP5-8.5","SSP3-7.0","SSP5-8.5","SSP3-7.0","SSP5-8.5","SSP3-7.0","SSP5-8.5")
slope_all$CWD<-c(3,25,3,25,3,25,3,25,3,25)
slope_all$year<- rep(2020,10)
slope_all$intercept<- c(intercept_ec,intercept_mpi,intercept_mri,intercept_access,intercept_miroc)
pvalue$Model<- c("EC_EARTH","EC_EARTH","MPI","MPI","MRI","MRI","ACCESS","ACCESS","MIROC","MIROC")
pvalue$Timeline<-c("SSP3-7.0","SSP5-8.5","SSP3-7.0","SSP5-8.5","SSP3-7.0","SSP5-8.5","SSP3-7.0","SSP5-8.5","SSP3-7.0","SSP5-8.5")
pvalue$CWD<-c(1,23,1,23,1,23,1,23,1,23)
pvalue$year<- rep(2020,10)
library(ggplot2)
ggplot(data = cwd_all, aes(x = year, y = CWD)) +
  geom_line(aes(colour = Timeline)) +
  facet_wrap(~factor(Model, levels = c('EC_EARTH', 'MPI', 'MRI', 'ACCESS', 'MIROC'))) +
  geom_segment(data = slope_all,(aes(x=2014,xend=2100,y=intercept,yend=(intercept+slope*86),color=Timeline)),size=1)+
  #geom_smooth(data = subset(cwd_all, year > 2014), aes(colour = Timeline), method = "lm", se = FALSE) +
  geom_vline(xintercept = 2014, linetype = "solid", color = "grey", size = 1) +
  geom_text(
    data = slope_all, 
    aes(
      x = year,  # Fixed position to maintain consistency across facets
      y = CWD,  # Adjusted Y-position to avoid overlap
      
      label = paste0("slope: ", round(slope, 4), "days/year"),
      color= Timeline
    ),
    
    size = 4, 
    hjust = 0, 
    vjust = 0, 
    
    check_overlap = TRUE
    
  ) +
  geom_text(
    data = pvalue, 
    aes(
      x = year,  # Fixed position to maintain consistency across facets
      y = CWD,  # Adjusted Y-position to avoid overlap
      
      label = paste0("p_value: ", round(p_value, 4)),
      color= Timeline
    ),
    
    size = 4, 
    hjust = 0, 
    vjust = 0)+
  
  #check_overlap = TRUE)+
  scale_x_continuous(limits = c(1979, 2100)) +
  scale_y_continuous(limits = c(0, 30)) +
  ylab("CWD(Days)")+
  ggtitle("Cumulative Wet Days(CWD)")+
  theme_bw()+
  theme(plot.background = element_blank(),
        panel.grid.major =element_blank(),
        panel.grid.minor = element_blank(),
        axis.line = element_line(),
        strip.background = element_rect(fill='white'),
        strip.text = element_text(face='bold',size = 16),
        axis.title.y = element_text(face = 'bold',size=16),
        plot.title=element_text(size=16,face='bold'),legend.title = element_text(size = 16,face='bold'),legend.text = element_text(size=16,face='bold'))
setwd("C:/Users/tamee/Downloads/new_runs")
ggsave("cwd_detrend_slope_p_new.jpeg",width = 12, height=8)
