source("R/set_up.R")
source("R/style.R")




exit_folder = file.path(dir_charts, "Hortichuelas")
location = "Hortichuelas Bajas"
date_start = ymd("2020-11-06") #Date that the trip started to this location
date_post = ymd("2020-12-13") #Date when you wrote the post


##Autofill
label_dot = paste("When we got to", location)
#File to export
exfile = file.path(exit_folder,paste0("chart_",location,".png"))



sum(clean_data$casos_nuevos[clean_data$before_got_here==T], na.rm = T)

#read data: from  https://cnecovid.isciii.es/covid19/resources/datos_ccaas.csv

raw_data = import("https://cnecovid.isciii.es/covid19/resources/datos_ccaas.csv")

#Clean
clean_data = raw_data %>%
  group_by(fecha) %>%
  summarise(casos_nuevos = sum(num_casos), .groups = 'drop') %>%
  mutate(fecha = ymd(fecha)) %>%
  arrange(fecha) %>%
  mutate(casos_7 = rollmean(casos_nuevos, 7, NA),
         before_got_here = fecha <= date_start) # TRUE if date is before the date we got to this location)


## data for dots in chart
data_puntos = clean_data %>%
  ## keep relevant dates (when post is written, when we got to this place, and when we got to other places)
  filter(fecha %in% c(date_start,date_post, fechas)) %>%
  #create factor for plotting dots in the chart 
  mutate(key_dates = factor(case_when(fecha %in% fechas ~ "other_stops",
                                      fecha == date_start ~ "got_to_location",
                                      fecha == date_post ~ "Post_was_written"),
                            levels=c("other_stops", "got_to_location","Post_was_written" )
  )
  )


chart_for_blog = ggplot(
  data = subset(clean_data, before_got_here ==T), 
  aes(
    
    x= fecha,
    y = casos_nuevos
    
  )) +
  
  #bars ------------------------------------------------------------------------
geom_col(width = .3,
         fill = light_purple
         ) +
  
  geom_col(
    data = subset(clean_data, before_got_here ==F),
    aes(
      
      x= fecha,
      y = casos_nuevos
      
    ),
    fill = "grey",
    width = .3
  ) +

  #lines --------------------------------------------------------------
  geom_line(
    
    aes(x = fecha,
        y = casos_7),
    color = dark_purple,
    size = 1
  ) +
  
  geom_line(
    data = subset(clean_data, before_got_here ==F),
    aes(x = fecha,
        y = casos_7),
    color = "grey",
    size = 1
  ) +
  
#labels -----------------------------------------------------------------
  geom_text_repel(
    data = subset(data_puntos, fecha %in% fechas),
    aes(label = c("Uncastillo", "Cinfaes", "Etorraberri", "Bemposta", "Caños de Meca"),
        x = fecha,
        y = casos_7),
    nudge_x = -50,
    nudge_y = 1000,
    segment.size  = .5,
    family = "Roboto",
    size = 4
  ) +
  #point ----------------------------------------------------------------------
  geom_point(data= subset(data_puntos, key_dates == "got_to_location"),
             aes(x = fecha-1,
                 y = casos_7,
                 color = dark_purple),
             size = 4,
  ) +
  #colours ---------------------------------------------------------------------
  scale_color_manual(values = c(dark_purple),
                     labels = c(label_dot)) +
  #Caption ---------------------------------------------------------------------
  labs(x = "",
       y = "Daily confirmed COVID-19 cases in Spain",
       caption = '**Chart:** @AndresArau | **Data:**_https//cnecovid.isciii.es/covid19_  | **13 Dec,2020**') +
  
  #Axis -------------------------------------------------------------------------
  scale_x_date(date_breaks = "1 month", date_labels =  "%b") +
  scale_y_continuous(labels = comma) +
  
  #theme -------------------------------------------------------------------------
  theme(
    #panel
    panel.border = element_rect(color  = light_grey, fill = NA),
    panel.grid.minor  = element_blank(),
    panel.grid.major  = element_line(linetype = 1, color = light_grey, size = .1),
    panel.background = element_blank(),
    
    #Legend
    legend.title = element_blank(),
    legend.text = element_markdown(family = "Roboto", size = 12, colour = dark_purple),
    legend.position = "top",
    legend.key = element_rect(fill = "white") ,
    
    
    #Plot
    plot.background = element_blank(),
    plot.caption = element_markdown(size = 12, family = "Roboto"),
    
    #Axis
    axis.ticks = element_blank(),
    axis.text = element_markdown(family = "Roboto", size = 10),
    axis.title.y = element_markdown(margin = margin(r = 10), family = "Roboto", size =14)
    
    
  )




chart_for_blog

#Export chart 
ggsave(exfile, chart_for_blog)

exfile
