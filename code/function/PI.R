#Calculates seasonal precipitation indices from a data frame of daily precipitation values:
#TP_s is cumulative P for each season/year
#SAI_s is standardized anomaly in TP for each season/year
#CDD_s is cumumlative dry days (maximum number of consecutive days where P < 0.1mm)
#CWD_s is cumumlative wet days (maximum number of days where P >= 0.1mm)
#EPD_s is extreme precipitation days (total number of days where daily P exceeded 90th percentile of daily P for the season)
#MDP_s is maximum daily precipitation for the season/year



precip_trace<-function(Pdat, m_c, time, out_path){
  require(lubridate)
  require(data.table)
  #Calculates seasonal precipitation indices for a matrix of gage-based precipitation:
  #Inputs:
  #calculate precipitation indices for which months?
  #first complete year of daily precipitation record
  #last complete year of daily precipitation record
  #filepath for output data
  
  #Daily precipitation (rows) for collection of precipitation gages (columns) with as few NA days as possible (all functions calculate na.rm=T, no statistical interpolation of P values for NA days)
  
  #Saves the following csv files to out_path:
  #TP_s is cumulative P for each season/year
  #SAI_s is standardized anomaly in TP for each season/year
  #CDD_s is cumulative dry days (maximum number of consecutive days where P < 0.1mm)
  #CWD_s is cumulative wet days (maximum number of days where P >= 0.1mm)
  #EPD_s is extreme precipitation days (total number of days where daily P exceeded 90th percentile of daily P for the season)
  #MDP_s is maximum daily precipitation for the season/year
  #reg_PI is the regional mean value for each of the above indices
  #each file name is appended by m_c
  
  #returns reg_PI to working directory
  #total cumulative precipitation (by station) 
  
  
  yr<- year(time)
  min_yr<- min(yr)
  max_yr<- max(yr)
  fnmth<-month(time)
  fnyr<-year(time)
  
  TP_s<-matrix(NA, ncol=dim(Pdat)[2],nrow=length(min_yr:max_yr))
  for(i in 1:length(min_yr:max_yr)){
    date_sub<-which(fnmth %in% m_c & fnyr %in% (i+min_yr-1)) #date range to consider for each row
    TP_s[i,]<-apply(Pdat[date_sub,],2,sum, na.rm=T)
  }
  
  TP_s<-as.data.frame(TP_s)
  names(TP_s)<-colnames(Pdat)
  write.csv(TP_s, file=paste(out_path, "TP_s", m_c[1],"_",m_c[3],".csv", sep=""),
            quote=F,
            row.names=F)
  
  
  #standardized precipitation anomaly (by station)
  SAI_s<-apply(TP_s, 2, function(x)(x-mean(x))/sd(x))
  
  SAI_s<-as.data.frame(SAI_s)
  names(SAI_s)<-colnames(Pdat)
  write.csv(SAI_s, file=paste(out_path, "SAI_s", m_c[1],"_",m_c[3],".csv", sep=""),
            quote=F,
            row.names=F)
  
  
  #cumulative dry days (CDD) and cumulative wet days (CWD) (by station), where "Dry Day" is a day with < 0.1 mm P
  
  DWD_bi<-as.data.frame(apply(Pdat, 2, function(x) ifelse(x<=0.25,1,0))) #create binary matrix with 0 for wet day, 1 for dry day
  DWD_bi[is.na(DWD_bi)]<-1
  CDD_s<-CWD_s<-matrix(NA, nrow=length(min_yr:max_yr), ncol=dim(Pdat)[2]) #generate run-length of type 0 for wet day, 1 for dry day
  for(i in 1:nrow(CDD_s)){
    for(j in 1:ncol(CDD_s)){
      date_sub<-which(fnmth %in% m_c & fnyr %in% (i+min_yr-1)) #date range to consider for each row
      CDD_s[i,j]<-max(table(rleid(DWD_bi[date_sub,j])[which(DWD_bi[date_sub,j]==1)]))
      CWD_s[i,j]<-max(table(rleid(DWD_bi[date_sub,j])[which(DWD_bi[date_sub,j]==0)]))
      CDD_s[CDD_s == -Inf]<-0
      CWD_s[CWD_s == -Inf]<-0
    }
  }
  
  CDD_s<-as.data.frame(CDD_s)
  names(CDD_s)<-colnames(Pdat)
  write.csv(CDD_s, file=paste(out_path, "CDD_s", m_c[1],"_",m_c[3],".csv", sep=""),
            quote=F,
            row.names=F)
  
  CWD_s<-as.data.frame(CWD_s)
  names(CWD_s)<-colnames(Pdat)
  write.csv(CWD_s, file=paste(out_path, "CWD_s", m_c[1],"_",m_c[3],".csv", sep=""),
            quote=F,
            row.names=F)
  
  #Extreme Precipitation days (EPD) (by station), where extreme precipitaiton is a value above the 90th percentile for the month period over the study period
  EPD_bi<-as.data.frame(apply(Pdat[which(fnmth %in% m_c),], 2, function(x) ifelse(x>=quantile(x, 0.9, na.rm=T),1,0))) #create binary matrix with 0 for days when daily P is below 95th percentile of all daily P in m_c, 1 for days when daily P is above 95%
  EPD_bi[is.na(EPD_bi)]<-0
  EPD_s<-matrix(NA, nrow=length(min_yr:max_yr), ncol=dim(Pdat)[2]) 
  Eyr<-yr[fnmth %in% m_c]
  for(i in 1:length(min_yr:max_yr)){
    EPD_s[i,]<-colSums(EPD_bi[Eyr %in% (i+(min_yr-1)),], na.rm=T)
  }
  EPD_s<-as.data.frame(EPD_s)
  names(EPD_s)<-colnames(Pdat)
  write.csv(EPD_s, file=paste(out_path, "EPD_s", m_c[1],"_",m_c[3],".csv", sep=""),
            quote=F,
            row.names=F)
  
  
  #Maximum daily Precipitation (MDP) (by station)
  MDP_s<-matrix(NA, nrow=length(min_yr:max_yr), ncol=dim(Pdat)[2]) 
  for(i in 1:length(min_yr:max_yr)){
    date_sub<-which(fnmth %in% m_c & fnyr %in% (i+min_yr-1)) #date range to consider for each row
    MDP_s[i,]<-apply(Pdat[date_sub,], 2, function(x) max(x, na.rm=T))
  }
  MDP_s[MDP_s == -Inf] <-0
  MDP_s<-as.data.frame(MDP_s)
  names(MDP_s)<-colnames(Pdat)
  write.csv(MDP_s, file=paste(out_path, "MDP_s", m_c[1],"_",m_c[3],".csv", sep=""),
            quote=F,
            row.names=F)
  
  
  #averages over all stations in record TP, SAI, CDD, CWD, EPD, MDP 
  reg_PI<-data.frame(TP=rowMeans(TP_s),
                     SAI=rowMeans(SAI_s),
                     CDD=rowMeans(CDD_s),
                     CWD=rowMeans(CWD_s),
                     EPD=rowMeans(EPD_s),
                     MDP=rowMeans(MDP_s))
  
  write.csv(reg_PI, file=paste(out_path, "reg_PI", m_c[1],"_",m_c[3],".csv", sep=""),
            quote=F,
            row.names=F)
  
  
  
  
  PI<-list(com_month=m_c, com_yr=min_yr:max_yr,
           TP=TP_s, 
           SAI=SAI_s,
           CDD=CDD_s,
           CWD=CWD_s,
           EPD=EPD_s,
           MDP=MDP_s,
           regPI=reg_PI)
  
  
  return(PI)
}

