path<- '***'
setwd(path)

path1<- paste(path,'/3_Edge/AuthorEdge_GC_Year_Gap3/',sep='')

library(data.table)
library(plyr)
library(RColorBrewer)
library(gridBase)
library(ggplot2)
library(scales)
library(dplyr)
library(brainGraph)
library(ggrepel)
library(tools)
library(ggbump)
library(ggforce)

source('FUN_Homophily.R')
source('FUN_theme_Publication.R')
source('FUN_TimeseriesCLuster.R')
my.summary <- function(x) list(Ave = mean(x,na.rm=T), SD = sd(x,na.rm = T))

country_continent<- fread('Country_Continent.csv')

country_continent$Color<- country_continent$Continent

gap<- 3
r<- 1
LA<- 50 ##'Max'
la<- LA

# annual country GH-------------------------------------------------------------------------
year<- 1980:2017
r<- format(1, nsmall = 1)

homophily_all<- data.table()
for(iyear in year){
  
  homophily<- fread(paste(path,'/Result/AuthorNode_CountryHomophily_year',iyear,'_Gap',gap,'_r=',r,'_LA',LA,'_p0.csv',sep=''))
  homophily_all<- rbind(homophily_all,data.table(homophily,Time=iyear))
}

homophily_all[country=='United Republic of Tanzania']$Continent<- 'AFRICA'
homophily_all[country=='South Korea']$Continent<- 'ASIA'
homophily_all[country=='North Korea']$Continent<- 'ASIA'
homophily_all[country=='Republic of Serbia']$Continent<- 'EUROPE'

homophily_all[country=='Macedonia']$country<- 'North Macedonia'
homophily_all[country=='Republic of Serbia']$country<- 'Serbia'
homophily_all[country=='United Republic of Tanzania']$country<- 'Tanzania'

homophily_all$Time<- homophily_all$Time+1

country_rm<- c("Aland","American Samoa","Barbados","Belize",
               "Bermuda","Brunei","Burundi","Chad","El Salvador",
               "French Guiana","Gambia","Guyana","Kosovo",
               "Mali","Northern Mariana Islands",
               "Republic of the Congo","Saint Kitts and Nevis",
               "Sierra Leone","Somalia","Somaliland",
               "Suriname","Aruba","Curacao","Guinea","Jersey",
               "Montserrat","Seychelles","The Bahamas",
               "United States Virgin Islands","Vanuatu",
               "Cayman Islands","Greenland","French Polynesia","Guam",
               "Ivory Coast",'Antigua and Barbuda','Northern Cyprus','Gaza',
               'Trinidad and Tobago')
homophily_all<- homophily_all[country%in%setdiff(unique(homophily_all$country),country_rm)]
homophily_country_all<- homophily_all

## fit GH
homophily_fit<- homophily_all[,c(1,2,8)]
homophily_all1<- data.table()
for(i in unique(homophily_fit$country)){
  
  homophily_fit1<- homophily_fit[country==i]
  colnames(homophily_fit1)[2:3]<- c('y','x')
  
  r2<- data.table()
  for(j in 1:90){
    fit<- lm(y~poly(x,j,raw=TRUE), data=homophily_fit1)
    # plot(homophily_fit1$x,homophily_fit1$y, xlab='x', ylab='y')
    # x_axis <- 1980:2017
    # lines(x_axis, predict(fit, data.frame(x=x_axis)), col='green')
    r2<- rbind(r2,data.table(j=j,r2=summary(fit)$adj.r.squared))
  }
  
  if(i=='Austria'){
    fit<- lm(y~poly(x,r2$j[50],raw=TRUE), data=homophily_fit1)
  }else{
    fit<- lm(y~poly(x,r2$j[which.max(r2$r2)],raw=TRUE), data=homophily_fit1)
  }
  homophily_all1<- rbind(homophily_all1,
                         homophily_all[country==i]%>%
                           mutate(Gh.pre=predict(fit, data.frame(x=homophily_fit1$x))))
}


### Clustering 
country_cluster<- fread('AuthorNode_CountryHomophily_Cluster_k=4new2.csv')

##
map <- data.table(map_data("world"))%>%
  mutate(fill='grey90')
map[region=='Taiwan']$subregion<- 'Taiwan'
map[region=='Taiwan']$region<- 'China'
map[region%in%country_cluster[Cluster==1]$Country]$fill<- "#80b1d3"
map[region%in%country_cluster[Cluster==2]$Country]$fill<- "#b3de69"
map[region%in%country_cluster[Cluster==3]$Country]$fill<- "#fdb462"
map[region%in%country_cluster[Cluster==4]$Country]$fill<- "#fb8072" 
map<- merge(map,country_cluster,by.x='region',by.y='Country',all.x=T)

dff <- map %>%
  group_by(region) %>%
  summarise(long = mean(long, na.rm = T), 
            lat = mean(lat, na.rm = T),
            group=group)
dff<- data.table(unique(dff))[region%in%country_cluster$Country][ , .SD[which.min(group)], by = region]

img<- ggplot(map, aes(long, lat, group=group)) + 
  geom_polygon(aes(fill = fill),
               colour="black",size = 0.2,alpha=0.8) + 
  labs(x='Longitude',y='Latitude')+
  theme_Publication()+
  scale_fill_identity(guide='legend', 
                      labels=paste('Cluster',1:4), 
                      breaks = c("#80b1d3","#b3de69","#fdb462","#fb8072"))+
  theme(panel.grid.major = element_blank(),
        legend.position= c(0,0.1), 
        legend.justification = c(0, 0.1),
        legend.title = element_blank())
img
ggsave(paste(path,'/Fig/AuthorNode_CountryHomophily_Allyear_Gap',gap,'_r=',r,'_LA',LA,'_ClusterMap_k=4new1.png',sep=''),plot = img,width = 25,height = 15,units = 'cm',dpi = 300)
