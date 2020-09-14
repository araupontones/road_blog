
light_purple = "#B64D8B"
grey = "grey"
dark_purple = "#554D89"


tema = theme(legend.title = element_blank(),
             legend.position = "top",
             panel.background = element_blank(),
             panel.grid.major.y = element_blank(),
             panel.grid = element_line(linetype = 3, color = "grey"),
             text = element_text(family = "Verdana"),
             plot.caption = element_text(15),
             axis.title.y = element_text(size = 14, face = "bold", margin = margin(0,15,0,0), colour = "black"),
             axis.text = element_text(size = 12, color = "black"),
             axis.ticks = element_blank(),
             legend.key = element_rect(fill = "white") ,
             axis.line = element_line(color="black", size = 1)
)