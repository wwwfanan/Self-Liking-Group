# This code is the main function of the SLG calculation
# Created by Dr. Fan Wang, 19.5.2025
# All files and data can be found in
# https://github. com/wwwfanan/Self-Liking-Group/tree/main
# This code produces the image of the map for the clustering of countries, noted as Fig. 4E.

# All *.CSV and all *.R files, which needs to be located at the same directory.
# Put in this path the input file
path<- '***' 
setwd (path)


library(data.table)
library(dplyr)
library(ggplot2)

source('FUN_theme_Publication.R')

## read data
country_cluster<- fread('AuthorNode_CountryHomophily_Cluster_k=4new2.csv')

## create the map
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
ggsave(paste(path,'/Fig4E.png',sep=''),plot = img,width = 25,height = 15,units = 'cm',dpi = 300)
