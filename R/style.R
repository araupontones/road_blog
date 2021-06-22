
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
  plot.caption = element_markdown(size = 10),
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
fecha_zestoa = ymd("2020-09-06")
fecha_bemposta = ymd("2020-10-11")
fecha_canos = ymd("2020-10-25")
fecha_hortichuelas = ymd("2020-11-06")
fecha_panticosa = ymd("2021-01-06")


fechas = c(fecha_uncastillo, fecha_pinheiro, fecha_zestoa,
           fecha_bemposta, fecha_canos, fecha_hortichuelas,
           fecha_panticosa)

