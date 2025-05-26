## author_data  including Country Community

Homophily<- function(author_data,la){
  
  colnames(author_data)<- c('Author','Community','Country')
  
  country<- unique(author_data$Country)
  country_num<- author_data[,.(.N),Country]
  country_num<- country_num[match(country,country_num$Country),]
  
  combine_num<- ddply(author_data,.(Community,Country),nrow)
  
  community_country<- matrix(0,nrow = la,ncol = length(country))
  row.names(community_country)<- community_max
  for(i in 1:la){
    id<- which(combine_num$Community==community_max[i])
    id1<- match(combine_num$Country[id],country)
    
    community_country[i,id1]<- combine_num$V1[id]/country_num$N[id1]
  }
  
  dt<- community_country
  Homophily <- vector()
  for (i in 1: dim(dt)[2]){
    Homophily[i]<- 1-sum(dt[,i]*log2(dt[,i]),na.rm = T)/log2(1/dim(dt)[1])
  }
  
  Homophily<- data.table(country,Homophily)
  return(list(community_country,Homophily))
}