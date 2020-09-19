source("R/set_up.R")
source("R/style.R")


#Set parameters MANUALLY FOR EACH post
location = "Pinheiro"
date_start = ymd("2020-07-04") #Date that the trip started to this location
date_post = ymd("2020-09-19") #Date when you wrote the post









##label chart -------------------------------------------------------------------------------------------
label_dot = paste("Cases when we got to", location)
label_dot2 = paste("Cases on", month(date_post,label = T, abbr = F), day(date_post))

#File to export
exfile = file.path(dir_charts,"Cinfaes",paste0("chart_",location,".png"))



#Load data

data <- covid19()



#Clean data
data_clean = data %>%
  rename(country = administrative_area_level_1) %>%
  filter(country == "Spain") %>%
  ungroup() %>%
  select(date, confirmed) %>%
  mutate(before_start = date <= date_start)



## casos dia que llegamos
casos_start = data_clean$confirmed[data_clean$date==date_start]
casos_post = data_clean$confirmed[data_clean$date==date_post]




## data for dots in chart
data_puntos = data_clean %>%
  filter(date %in% c(date_start,date_post)) %>%
 mutate(before_start = factor(before_start,
                              levels = c(TRUE, FALSE)))





chart_for_blog =  ggplot(data = data_clean,
                        aes(x = date,
                            y = confirmed)) +
  ## Line of cases before we got to town
  geom_line(data = data_clean %>%
              filter(before_start == T),
            color = light_purple,
            size = 1.2
            ) +
##Line after
  geom_line(data = data_clean %>%
              filter(before_start == F),
            color = grey,
            linetype = "dashed",
            size = 1.3)+
  
    geom_point(data= data_puntos,
               aes(x = date,
                   y = confirmed,
                   color = before_start),
               size = 5,
    ) +
  scale_color_manual(values = c(dark_purple, grey),
                     labels = c(label_dot,
                                label_dot2))+
  
  labs(x = "",
       y = "Cummulative COVID-19 cases in Spain",
       caption = 'Chart by @AndresArau\nData:Guidotti, E., Ardia, D., (2020), "COVID-19 Data Hub"') +
  
  
  scale_x_date(date_breaks = "1 month", date_labels =  "%b") +
  scale_y_continuous(labels = comma) +
  tema







#Export chart 
ggsave(exfile, chart_for_blog)

                  

