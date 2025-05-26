TimeserieCluster<- function(homophily_all){
  
  year<- 1981:2018
  
  library(dtwclust)
  library(imputeTS)
  
  homophily_time<- list()
  for(i in 1:length(unique(homophily_all$country))){
    
    h<- rep(NA,length(year))
    h_ch<- homophily_all[country==unique(homophily_all$country)[i]]
    h[match(h_ch$Time,year)]<- h_ch$Homophily
    
    homophily_time[[i]]<- na_mean(h)
  }
  names(homophily_time)<- unique(homophily_all$country)
  
  k<- 2:10
  homophily_cluster <- tsclust(homophily_time,
                               type="partitional", k=k, distance="dtw", centroid="pam")
  
  method<- c('Sil','CH','D','SF','COP','DB','DBstar')
  cvi_p<- sapply(homophily_cluster, cvi, type = method)
  
  homophily_clusterk<- data.table(p=as.vector(cvi_p),Label=rep(method,length(k)),k=rep(k,each=length(method)))
  homophily_clusterk$Label<- factor(homophily_clusterk$Label,levels = method)
  homophily_clusterk[Label=='CH']$p<- homophily_clusterk[Label=='CH']$p/100
  
  img<- ggplot(homophily_clusterk,
               aes(x=k,y=p,color=Label))+
    labs(x='k',y='p')+
    theme_Publication()+
    geom_point(size=3,alpha=1)+
    geom_line(aes(group=Label),linewidth=2,alpha=1)+
    scale_color_manual(values =c("#80b1d3","#8dd3c7","#b3de69","#ccebc5",
                                 "#fccde5","#bebada","#bc80bd"),
                       labels=c('Sil','CH*100','D','SF','COP','DB','DBstar'))+
    theme(legend.title = element_blank(),
          legend.position= c(1,.25),
          legend.justification = c(1, .25))
  img
  ggsave(paste(path,'/Fig/AuthorNode_CountryHomophilyCluster_kChoose.png',sep=''),plot = img,width = 15,height = 15,units = 'cm',dpi = 300)
  # 
  homophily_cluster <- tsclust(homophily_time,
                               type="partitional", k=3, 
                               distance="dtw", centroid="pam")
  plot(homophily_cluster, type = "sc")
  
  country_cluster<- data.table(Country=unique(homophily_all$country),
                               Cluster=homophily_cluster@cluster)
  
  return(country_cluster)
}

