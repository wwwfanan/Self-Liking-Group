library(ggthemes)

theme_Publication <- function(base_size = 18, base_family = 'Times New Roman') {
  (theme_foundation(base_size = base_size, base_family = '')
   + theme(plot.title = element_text(size = rel(1.2), face = 'bold', hjust = 0.5),
           # text = element_text(),
           plot.background = element_blank(),
           panel.grid.major=element_line(colour="snow3", linetype = 'dashed'),
           panel.grid.minor = element_blank(),
           panel.background = element_rect(fill = "white", colour = "red", size = 1),
           panel.border = element_rect(fill=NA,color="black", size=2, linetype="solid"),
           axis.title = element_text(size = 20,face = 'bold'),
           axis.text.y = element_text(size = 18,face = 'bold'),
           axis.text.x = element_text(size = 18,face = 'bold',angle = 0),
           legend.title = element_text(size = 15,face = 'bold'),
           legend.text=element_text(size=15,face = 'bold'),
           legend.position= c(0.85,0.5),
           # legend.position= 'right',
           legend.background = element_rect(fill = alpha("white", 0), size = 1),
           legend.key = element_rect(fill = alpha("white", 0), color = NA),
           legend.key.size = unit(0.8, 'cm')
           # plot.margin=unit(c(2.5,5,2.5,5),'mm'),
           # strip.background=element_rect(colour='#F0F0F0',fill='#F0F0F0')
           # strip.text = element_text(face='bold')
   )
  )
}


