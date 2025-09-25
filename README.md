# Accuracy and realism of CMIP6 candidate models in capturing dry, moist, and extreme precipitation anomalies in the Laurentian Great Lakes.

### Tasmeem Jahan Meem1, Elizabeth K. Carter1,2*, Tripti Bhattacharya2, Stephen B Shaw3 

Accurate precipitation predictions over the Great Lakes basin have critical global and local implications for water resources management, particularly under intensifying climate change. Projecting pan-Great Lakes hydro climatological shifts in the twenty-first century requires a diagnostic assessment model fidelity in capturing both thermodynamical and dynamical drivers of hydro climatological change, specifically 1) earth system model fidelity in capturing a range of mechanisms of precipitation delivery and 2) earth system model skill in representing the relationships between regionally significant hydroclimatic circulation patterns and modeled precipitation variability. In this study, precipitation simulations from 12 CMIP6 models representing the full range of variability in numeric representation of North American climate are evaluated. Each model’s accuracy in capturing historic seasonal wet and dry anomalies in the Great Lakes region are quantified, and models are selected that show consistency with historically observed precipitation variability. The physical realism of accurate models is evaluated by exploring relationships between hydrologically important circulation anomalies in observed and historical observations over the summer months. All models show strong wet bias in Great Lakes summer precipitation, associated with overestimation of precipitation intensity. Historic observations suggest that North Atlantic subtropical high is an important driver of variability in summertime hydroclimatic circulation in the region but even models with historic precipitation accuracy fail to replicate this pattern in their circulation. 

Use this repository to replicate our analysis:

## Raw Data:
Data files used in this repository can be directly accessed at: 
Meem, T., Meem, T. J., Meem, T. J., Carter, E., Shaw, S., & Bhattacharya, T. (2025). Accuracy and realism of CMIP6 candidate models in capturing dry, moist, and extreme precipitation anomalies in the Laurentian Great Lakes. Zenodo. https://doi.org/10.5281/zenodo.17034063

## processed_data:
Note to Meem: create as subfolder and save processed data objects here so that folks don't always have to read in your raw data. Depending on the size of your datasets, this might need to also go in the Zenodo repository, in which case make sure you are reading in these processed datasets from the zenodo url in code below. 

Example R code: nc <- nc_open("https://dapds00.nci.org.au/thredds/dodsC/uc0/Test_pixel_count.nc")

## Code:
Note to Meem: update all lines of code where you read in data to link directly to a URL in Zenodo repository or to the corresponding processed data folder in github repository. Assume the repository itself is the working directory, so an example file path would be "./processed_data/filename.txt"
### Function
1.	PI.R – Calculates CDD,CWD,TP,EPD,MDP and SAI (Standard Precipitation Anomaly)
2.	ivss.R – Calculates the IVSS
   
### Data Pre-processing and Precipitation Index Calculation
1.	Spatial PI Historical- Reads netcdf files cited in Raw data, extracts daily precipitation in each grid cell for all models, calculates precipitation index functions using PI.R
2.	Avg Precip.R –  Reads netcdf files cited in Raw Data, extracts daily precipitation in each lake basin for all models, calculates precipitation index functions using PI.R
3.	Zg_extraction.R – Reads netcdf files cited in Raw Data, calculates geopotential height anomaly for each grid point.
4.	EC_extraction.R,mpi_extraction.R,mri_extraction.R,ac_extraction.R,miroc_extraction.R – Reads from netcdf files cited in Raw Data to calculate average precipitation for historical,ssp370 and ssp585 scenario and calculate the precipitation index functions using PI.R from function

### Figures
Note to Meem: make sure these figures correspond to figures 
1.	Figure1.R reads the outputs from Avg_Precip.R ,aggregates yearly precipitation and generate figure1 
2.	Figure2.R- reads the outputs from Avg_Precip.R, calculates ensemble mean and generate figure2
3.	Figure3.R - reads the outputs from Avg_Precip.R ,aggregates monthly precipitation, performs hypothesis testing and generate figure3
4.	Figure4.R – Reads outputs from Spatial PI Historical.R, calculates IVSS using ivss.R from function, calculates NIVSS, MVI and generates figure4
5.	Figure5.ipnyb – Reads outputs from zg_extraction.R, conducts PCA, correlate precipitation from Precip_avg.R  output , find pattern correlation and generate figure 5. 
6.	Figure6.R to Figure10.R – reads output from EC-extraction.R,mpi_extraction.R,mri_extraction.R,ac_extraction.R,miroc_extraction.R, does Mann-Kendal trend test and generate figure 6-figure10. 


