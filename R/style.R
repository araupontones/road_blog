
light_purple = "#B64D8B"
grey = "grey"
light_grey = "#eeeeee"
dark_purple = "#554D89"


tema = theme(
  #Legend
  legend.title = element_blank(),
  legend.position = "top", 
  legend.key = element_rect(fill = "white") ,
  
  
  #Panel
  panel.background = element_blank(),
  panel.grid.major.y = element_blank(),
  panel.grid.minor.x = element_blank(),
  panel.grid = element_line(linetype = 1, color = light_grey, size = .1),
  
  #Text
  text = element_text(family = "Verdana"),
  plot.caption = element_text(15),
  axis.title.y = element_text(size = 14, face = "bold", margin = margin(0,15,0,0), colour = "black"),
  axis.text = element_text(size = 12, color = "black"),
  
  #Axis
  axis.ticks = element_blank(),
  axis.line = element_line(color="black", size = 1),
  axis.line.x.top = element_line(linetype = 1, color = light_grey, size = .1)
)


### track of cases 

casos_uncastillo = 6391
fecha_uncastillo = ymd("2020-03-14")
fecha_pinheiro = ymd("2020-07-04")


fechas = c(fecha_uncastillo, fecha_pinheiro)

