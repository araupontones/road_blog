source("R/set_up.R")
source("R/style.R")


#Set parameters MANUALLY FOR EACH post
location = "Bemposta"
date_start = ymd("2020-10-11") #Date that the trip started to this location
date_post = ymd("2020-10-30") #Date when you wrote the post



exit_folder = file.path(dir_charts, "Bemposta")


##label chart -------------------------------------------------------------------------------------------
label_dot = paste("When we got to", location)
label_dot2 = paste("On", month(date_post,label = T, abbr = F), day(date_post))
label_dot_pas = "On previous stops"

#File to export
exfile = file.path(exit_folder,paste0("chart_",location,".png"))

exfile

#LOAD AND CLEAN DATA ----------------------------------------------------------------------------------------

data <- covid19()

ss_duplicates = function(x){ 
  ## identify duplicates
  x %in% x[duplicated(x)]
}

'%!in%' <- function(x,y)!('%in%'(x,y))
#Clean data
data_clean = data %>%
  rename(country = administrative_area_level_1) %>%
  filter(country == "Spain") %>%
  ungroup() %>%
  select(date, confirmed) %>%
  mutate(before_got_here = date <= date_start, # TRUE if date is before the date we got to this location
         duplicado = ss_duplicates(confirmed),
         duplicado = if_else(date %in% c(fechas,date_start, date_post), F, duplicado)) %>%
  filter(duplicado == F) 




## casos dia que llegamos
casos_start = data_clean$confirmed[data_clean$date==date_start]
casos_post = data_clean$confirmed[data_clean$date==date_post]



## data for dots in chart
data_puntos = data_clean %>%
  ## keep relevant dates (when post is written, when we got to this place, and when we got to other places)
  filter(date %in% c(date_start,date_post, fechas)) %>%
 #create factor for plotting dots in the chart 
  mutate(key_dates = factor(case_when(date %in% fechas ~ "other_stops",
                                        date == date_start ~ "got_to_location",
                                        date == date_post ~ "Post_was_written"),
                            levels=c("other_stops", "got_to_location","Post_was_written" )
                              )
        )




### Draw chart

chart_for_blog =
  ggplot(data = data_clean,
                        aes(x = date,
                            y = confirmed)) +
  ## Line of cases before we got to town
  geom_line(data = data_clean %>%
              filter(before_got_here == T),
            color = light_purple,
            size = 1.2
            ) +
##Line after
  geom_line(data = data_clean %>%
              filter(before_got_here == F),
            color = grey,
            linetype = "dashed",
            size = 1.3)+
  
    geom_point(data= data_puntos,
               aes(x = date,
                   y = confirmed,
                   color = key_dates),
               size = 5,
    ) +
  

  geom_text_repel(
    data = subset(data_puntos, date %in% fechas),
    aes(label = c("Uncastillo", "Cinfaes", "Zestoa")),
    nudge_x = 30,
    nudge_y = -15000,
    segment.size  = .5,
    segment.color = "grey50",
    direction     = "x",
    fontface = 'bold',
    point.padding = .8
  ) +
 
  scale_color_manual(values = c(light_purple,dark_purple, grey),
                     labels = c(label_dot_pas,
                                label_dot,
                                label_dot2
                                ))+
  
  labs(x = "",
       y = "Cummulative COVID-19 cases in Spain",
       caption = '**Chart:** @AndresArau | **Data:** Guidotti, E., Ardia, D., (2020), "COVID-19 Data Hub"') +
  
  
  scale_x_date(date_breaks = "1 month", date_labels =  "%b") +
  scale_y_continuous(labels = comma) +
  theme_light()+
  tema 
  



chart_for_blog

exfile
#Export chart 
ggsave(exfile, chart_for_blog)

exfile
                  

