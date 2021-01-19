spiral <- data.frame(date = seq.Date(from = as.Date("2018-01-01"), 
                                     to = as.Date("2020-12-31"), 
                                     by = 1),
                     day_num = 1:1096,
                     temp = rnorm(1096, 5, 5)) %>%
          mutate(inv_temp = 1/temp)

ggplot(spiral, aes(x = day_num %% 365, 
                   y = 0.07*day_num + temp/2,
                   height = temp,
                   fill = temp, 
                   color = inv_temp)) + 
  geom_tile() + 
  scale_y_continuous(limits = c(-20, NA)) +
  scale_x_continuous(breaks = 100*0:11, 
                     minor_breaks = NULL) +
  coord_polar() + 
  scale_fill_viridis_c(option = "D") + 
  theme_void() +
  guides(fill = FALSE,
         color = FALSE)
