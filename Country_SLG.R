# This code is the main function of the SLG calculation
# Created by Dr. Fan Wang, 19.5.2025
# All files and data can be found in
# https://github. com/wwwfanan/Self-Liking-Group/tree/main
# This code produces the calculating of SLG.

# All *.CSV and all *.R files, which needs to be located at the same directory.
# Put in this path the input file
path<- '***' 
setwd (path)

library(data.table)
library(plyr)
library(dplyr)

source('FUN_Homophily.R')

author_country<- fread('Data_AuthorAffiliationCountry_AllYear.csv')
author_country$authors.id<- as.character(author_country$authors.id)
country_continent<- fread('Country_Continent.csv')

iyear<- 1980
gap<- 3
r<- 1
LA<- 'Max'

## community of the author and choose the top largest communities
author_community<- fread(paste(path1,iyear,'/Data_AuthorEdge_GC_',iyear,'_Gap',gap,'_Community_LouvainP_r=',r,'.csv',sep=''))[V1!='',]
colnames(author_community)<- c('Author','Community')
community_size<- author_community[,.(.N),Community]
setorder(community_size,-N)
la<- dim(community_size)[1]
community_max<- head(community_size$Community,la)
author_community_top<- author_community[which(author_community$Community%in%community_max),]
author_community_top$Author<- as.character(author_community_top$Author)

## country of the author and combine them with community
## to create the two paramaters of SLG
author_data<- merge(author_community_top,author_country,by.x='Author',by.y='authors.id')[year==iyear] 
author_data<- author_data[Country!='']
author_data<- unique(author_data[,c('Author','Community','Country')])

## SLG, deltails in FUN_Homophily.R
homophily<- Homophily(author_data,la)[[2]]
homophily$Continent<- country_continent$Continent[match(homophily$country,country_continent$Country)]
