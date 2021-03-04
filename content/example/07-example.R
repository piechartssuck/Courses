----message=FALSE----------------------------------------------------------------------------
library(tidyverse)
library(patchwork) # Used to plot things in a grid
library(RColorBrewer) # A coloring package with multiple palettes
library(scales) # Used to manipulate applications of colors
library(ggpubr)







rm(list = ls())



load(election2016.RData)



election2016_rdata <- here("static", "data", "election2016.RData")

load(election2016_rdata)



# Input your Census key
census_api_key("YOUR CENSUS API KEY", install = TRUE)

# Reload the .Renviron marker
readRenviron("~/.Renviron")



names(election2016)



View(election2016)



partyColors <- c("#2E74C0", "#CB454A") 



scales::show_col(partyColors)



ggplot(data = subset(election2016, !st %in% "DC"), 
       mapping = aes(x = r_points,
                     xend=r_points,
                     y = reorder(state, r_points),
                     color = party)) +
  geom_vline(xintercept = 0, color = "gray30") +
  geom_point(size = 3) +
  scale_color_manual(values = partyColors)



ggplot(data = subset(election2016, !st %in% "DC"), 
       mapping = aes(x = r_points,
                     xend=r_points,
                     y = reorder(state, r_points),
                     color = party)) + 
  geom_vline(xintercept = 0, color = "gray30") +
  geom_segment(aes(x = 0, y = state, xend = r_points, 
                   yend = state), color = "grey70") +
  geom_point(shape = 21, size = 3, fill="white", stroke = 1) + 
  scale_color_manual(values = partyColors) +
  scale_x_continuous(labels = function(x) paste0(abs(x), "%"), limits = c(-35, 50)) +
  theme_minimal() +
  theme(
    legend.position = "none",
    panel.border = element_blank(),
    axis.ticks = element_blank()
  ) +
  xlab(NULL) +
  ylab("State")



ggplot(data = subset(election2016, !st %in% "DC"),  
       mapping = aes(x = r_points,  
                     xend=r_points,  
                     y = reorder(state, r_points),  
                     color = party)) +  
  geom_vline(xintercept = 0, color = "gray30") +  
  geom_segment(aes(x = 0, y = reorder(state, r_points), xend = r_points, 
                   yend = reorder(state, r_points)), color = "grey70") +  
  # Here is the fix but what do you think happened?  
  geom_point(shape = 21, size = 3, fill="white", stroke = 1) +  
  scale_color_manual(values = partyColors) +  
  scale_x_continuous(labels = function(x) paste0(abs(x), "%"), limits = c(-35, 50)) +  
  theme_minimal() +  
  theme(  
    legend.position = "none",  
    panel.border = element_blank()  
  ) +  
  xlab("Party Affiliation") +  
  ylab("State")



library(ggthemes)



ggplot(data = subset(election2016, !st %in% "DC"),
       mapping = aes(x = r_points,
                     xend = r_points,
                     y = reorder(state, r_points),
                     color = party)) + 
  geom_vline(xintercept = 0, color = "gray30") +
  geom_segment(aes(x = 0, y = reorder(state, r_points), xend = r_points, 
                   yend = reorder(state, r_points)), color = "#5e3c58") +
  geom_point(shape = 21, size = 3, fill="white", stroke = 1) + 
  scale_x_continuous(labels = function(x) paste0(abs(x), "%"), 
                     expand = c(0, 0), limits = c(-35, 50)) +
  theme(
    legend.position = "none",
    panel.border = element_blank(),
    panel.grid.major = element_blank(), 
    panel.grid.minor = element_blank()
  ) +
  xlab("Party Affiliation") +
  ylab("State") + 
  scale_color_fivethirtyeight() +
  theme_fivethirtyeight() 



library(maps)



state <- map_data("state")



head(state)



dim(state)



ggplot(data = state,
            aes(x = long, y = lat,
                group = group, fill = region)) +
  geom_polygon(color = "gray90", size = 0.1) +
  coord_map(projection = "albers", lat0 = 39, lat1 = 45) +
  guides(fill = FALSE)



election2016$region <- tolower(election2016$state) # 



state_elec <- left_join(state, election2016) 



head(state_elec)



ggplot(data = state_elec,
            aes(x = long, y = lat,
                group = group, fill = party)) +
      geom_polygon(color = "gray90", size = 0.1) +
      coord_map(projection = "albers", lat0 = 39, lat1 = 45) 



ggplot(data = state_elec,
             mapping = aes(x = long, y = lat,
                           group = group, fill = party)) +
        geom_polygon(color = "gray90", size = 0.1) +
        coord_map(projection = "albers", lat0 = 39, lat1 = 45) +
        scale_fill_manual(values = partyColors) +
        labs(title = "2016 Presidential Election Results", fill = NULL) +
        theme_map() 



ggplot(data = state_elec,
       mapping = aes(x = long, y = lat,
                     group = group, fill = party)) +
  geom_polygon(color = "gray90", size = 0.1) +
  coord_map(projection = "albers", lat0 = 39, lat1 = 45) +
  scale_fill_manual(values = partyColors) +
  labs(title = "2016 Presidential Election Results", fill = NULL) +
  theme_map()+
  theme_fivethirtyeight() 



tr1 <- ggplot(data = state_elec,
    mapping = aes(x = long, y = lat, group = group, fill = pct_trump)) +
    geom_polygon(color = "gray90", size = 0.1) +
    coord_map(projection = "albers", lat0 = 39, lat1 = 45) +
    theme_map() + 
    theme_fivethirtyeight() +
    scale_fill_gradient(low = "white", high = "#CB454A") +
    labs(title = "Trump vote") + 
    guides(fill = FALSE)



cl1 <- ggplot(data = state_elec,
             mapping = aes(x = long, y = lat, group = group, fill = pct_clinton)) +
  geom_polygon(color = "gray90", size = 0.1) +
  coord_map(projection = "albers", lat0 = 39, lat1 = 45) + 
  theme_map() + 
  theme_fivethirtyeight() +
  scale_fill_gradient(low = "white", high = "#2E74C0") +
  labs(title = "Clinton vote") +
  guides(fill = FALSE) 



tr1 + cl1



tr2 <- ggplot(data = state_elec,
             mapping = aes(x = long, y = lat, group = group, fill = pct_trump)) +
  geom_polygon(color = "gray90", size = 0.1) +
  coord_map(projection = "albers", lat0 = 39, lat1 = 45) + 
  theme_map() + 
  theme_fivethirtyeight() +
   theme(
    axis.ticks = element_blank(),
    axis.text = element_blank(),
    panel.border = element_blank(),
    panel.grid.major = element_blank(), 
    panel.grid.minor = element_blank(),
    panel.background = element_rect(fill = "#FFFFFF", color = "#FFFFFF"),
    plot.background = element_rect(fill = "#FFFFFF"),
    legend.background = element_rect(fill = "#FFFFFF")) +
  labs(title = "Trump vote", fill = "Percent") + 
  scale_fill_gradient(low = "white", high = "#CB454A")



# Clinton's winnings
cl2 <- ggplot(data = state_elec,
             mapping = aes(x = long, y = lat, group = group, fill = pct_clinton)) +
  geom_polygon(color = "gray90", size = 0.1) +
  coord_map(projection = "albers", lat0 = 39, lat1 = 45) + 
  theme_map() + 
  theme_fivethirtyeight() +
  theme(
    axis.ticks = element_blank(),
    axis.text = element_blank(),
    panel.border = element_blank(),
    panel.grid.major = element_blank(), 
    panel.grid.minor = element_blank(),
    panel.background = element_rect(fill = "#FFFFFF", color = "#FFFFFF"),
    plot.background = element_rect(fill = "#FFFFFF"),
    legend.background = element_rect(fill = "#FFFFFF")) +
  labs(title = "Clinton vote", fill = "Percent") + 
  scale_fill_gradient(low = "#FFFFFF", high = "#2E74C0")



tr2 + cl2



trrange <- range(election2016$pct_trump, na.rm = TRUE) # Check the range of Trump's percentages



clrange <- range(election2016$pct_clinton, na.rm = TRUE) # Check the range of Clinton's percentages



range(trrange, clrange) # Check the range of both



tr3 <- ggplot(data = state_elec,
              mapping = aes(x = long, y = lat, group = group, fill = pct_trump)) +
  geom_polygon(color = "gray90", size = 0.1) +
  coord_map(projection = "albers", lat0 = 39, lat1 = 45) + 
  theme_map() + 
  theme_fivethirtyeight() +
  theme(
    axis.ticks = element_blank(),
    axis.text = element_blank(),
    panel.border = element_blank(),
    panel.grid.major = element_blank(), 
    panel.grid.minor = element_blank(),
    panel.background = element_rect(fill = "#FFFFFF", color = "#FFFFFF"),
    plot.background = element_rect(fill = "#FFFFFF"),
    legend.background = element_rect(fill = "#FFFFFF")) +
  labs(title = "Trump vote", fill = "Percent") + 
  scale_fill_gradient(limits=c(0, 100), low = "#FFFFFF", high = "#CB454A")



cl3 <- ggplot(data = state_elec,
                mapping = aes(x = long, y = lat, group = group, fill = pct_clinton)) +
  geom_polygon(color = "gray90", size = 0.1) +
  coord_map(projection = "albers", lat0 = 39, lat1 = 45) + 
  theme_map() + 
  theme_fivethirtyeight() +
   theme(
    axis.ticks = element_blank(),
    axis.text = element_blank(),
    panel.border = element_blank(),
    panel.grid.major = element_blank(), 
    panel.grid.minor = element_blank(),
    panel.background = element_rect(fill = "#FFFFFF", color = "#FFFFFF"),
    plot.background = element_rect(fill = "#FFFFFF"),
    legend.background = element_rect(fill = "#FFFFFF")) +
  labs(title = "Clinton vote", fill = "Percent") + 
  scale_fill_gradient(limits=c(0, 100), low = "#FFFFFF", high = "#2E74C0")




# Plot them both
tr3 + cl3



tr2 + cl2 + tr3 + cl3 + plot_layout(nrow = 2)



lighter_map <- 
  ggplot(data = state_elec,
         mapping = aes(x = long, y = lat, group = group, fill = d_points)) + 
  geom_polygon(color = "gray90", size = 0.1) +
  coord_map(projection = "albers", lat0 = 39, lat1 = 45) + 
  scale_fill_gradient2(
    low = "#CB454A", mid = scales::muted("purple"),
    high = "#2E74C0", breaks = c(-100, -75, -50,-25, 0, 25, 50, 75, 100), 
    labels = c(100, 75, 50, 25, 0, 25, 50, 75, 100)) +
  theme_map() +
  theme_fivethirtyeight() +
  theme(
    axis.ticks = element_blank(),
    axis.text = element_blank(),
    panel.border = element_blank(),
    panel.grid.major = element_blank(), 
    panel.grid.minor = element_blank()
  ) +
  labs(title = "Winning margins",
       subtitle = "(The Lighter Map)",
       fill = "Percent")



lighter_map



darker_map <- 
ggplot(data = state_elec,
       mapping = aes(x = long, y = lat, group = group, fill = d_points)) + 
  geom_polygon(color = "gray90", size = 0.1) +
  coord_map(projection = "albers", lat0 = 39, lat1 = 45) + 
  scale_fill_gradient2(low = "red", mid = scales::muted("purple"),
                       high = "blue", breaks = c(-100, -75, -50,-25, 0, 25, 50, 75, 100), 
                       labels = c(100, 75, 50, 25, 0, 25, 50, 75, 100)) +
  theme_map() +
  theme_fivethirtyeight() +
  theme(
    axis.ticks = element_blank(),
    axis.text = element_blank(),
    panel.border = element_blank(),
    panel.grid.major = element_blank(), 
    panel.grid.minor = element_blank(),
    panel.background = element_rect(fill = "#FFFFFF", color = "#FFFFFF"),
    plot.background = element_rect(fill = "#FFFFFF"),
    legend.background = element_rect(fill = "#FFFFFF")) +
  labs(title = "Winning margins",
       subtitle = "(The Darker Map)",
       fill = "Percent")



darker_map



# Grab the outliers
outliers = boxplot(election2016$d_points, plot=FALSE)$out 



# Extract the row information from the original data frame
election2016[election2016$d_points %in% outliers,] 



darker_map_NODC <- ggplot(data = subset(state_elec,
                           !region %in% "district of columbia"),
             aes(x = long, y = lat, group = group, fill = d_points)) +
  geom_polygon(color = "gray90", size = 0.1) +
  coord_map(projection = "albers", lat0 = 39, lat1 = 45) + 
  scale_fill_gradient2( low = "red", mid = scales::muted("purple"),
                        high = "blue", breaks = c(-100, -75, -50,-25, 0, 25, 50, 75, 100), 
                        labels = c(100, 75, 50, 25, 0, 25, 50, 75, 100)) +
  theme_map() +
  theme_fivethirtyeight() +
  theme(
    axis.ticks = element_blank(),
    axis.text = element_blank(),
    panel.border = element_blank(),
    panel.grid.major = element_blank(), 
    panel.grid.minor = element_blank(),
    panel.background = element_rect(fill = "#FFFFFF", color = "#FFFFFF"),
    plot.background = element_rect(fill = "#FFFFFF"),
    legend.background = element_rect(fill = "#FFFFFF")) +  
  labs(title = "Winning margins",
                subtitle =str_wrap("(The Darker Map without Washington D.C.)",30),
       fill = "Percent")



---- out.width = "100%"----------------------------------------------------------------------
darker_map + darker_map_NODC



library(devtools)
library(statebins)
library(RColorBrewer)



library(statebins)



display.brewer.all()



statebins(election2016, value_col="pct_trump", palette = "Reds", round=TRUE) +
  theme_statebins()



basicRedBrews <- brewer.pal("all", "Reds")



show_col(basicRedBrews)



trumpNineRed <- ggplot(election2016, aes(state=state, fill=pct_trump)) +
             geom_statebins() +
             coord_equal() +
             theme_statebins() +
             scale_fill_gradientn(limits = c(0, 100), colors = brewer.pal("all", "Reds")) + 
             labs(title = str_wrap("Trump 2016 Popular Vote Percent Distribution", 30), 
             # Notice the text wrap via thge stringr package.
             subtitle ="(Nine Shades of Red)", 
             # cough cough proper APA formatting cough cough
             fill = NULL)



trumpNineRed



# Define a range of 50 colors based on the RColorBrewer Reds palette.
fiftyRedBrews <- colorRampPalette(basicRedBrews)(50) 



show_col(fiftyRedBrews)



trumpFiftyRed <- ggplot(election2016, aes(state=state, fill=pct_trump)) +
  geom_statebins() +
  coord_equal() +
  theme_statebins() +
  scale_fill_gradientn(limits = c(0, 100), colors = fiftyRedBrews) +     
  labs(title = str_wrap("Trump 2016 Popular Vote Percent Distribution", 30),
       subtitle ="(50 Shades of Red)",
       fill = NULL)



trumpFiftyRed



trumpNineRed + trumpFiftyRed



threeRedBrews <- brewer.pal(3, "Reds") # We're taking three evenly distributed colors



show_col(threeRedBrews)



trumpThreeRed <- ggplot(election2016, aes(state=state, fill=pct_trump)) +
  geom_statebins() + 
  coord_equal() + # If you run the ggplot and geom_statbins line, it looks rectangular.
  theme_statebins() + # This is akin to the base ggplot2 theme_minimal()
  scale_fill_gradientn(limits = c(0, 100), colors = threeRedBrews) +
  labs(title = str_wrap("Trump 2016 Popular Vote Percent Distribution",30),
       subtitle ="(Three Shades of Red)",
       fill = NULL) 



trumpThreeRed



basicBlueBrews <- brewer.pal("all", "Blues")



show_col(basicBlueBrews)



fiftyBlueBrews <- 
  colorRampPalette(basicBlueBrews)(50)



show_col(fiftyBlueBrews)



clintonFiftyBlue <- 
  ggplot(election2016, aes(state=state, fill=pct_clinton)) +
  geom_statebins() +
  coord_equal() +
  theme_statebins() +
  scale_fill_gradientn(limits = c(0, 100), colors = fiftyBlueBrews) +
  labs(title = str_wrap("Clinton 2016 Popular Vote Percent Distribution", 30),
       subtitle ="(50 Shades of Blue)",
       fill = NULL)



clintonFiftyBlue



threeBlueBrews <- brewer.pal(3, "Blues")



show_col(threeBlueBrews)



clintonThreeBlue <- ggplot(election2016, aes(state=state, fill=pct_clinton)) +
  geom_statebins() +
  coord_equal() +
  theme_statebins() +
  scale_fill_gradientn(limits = c(0, 100), colors = threeBlueBrews) +
  labs(title = str_wrap("Clinton 2016 Popular Vote Percent Distribution", 30),
       subtitle ="(Three Shades of Blue)",
       fill = NULL)



clintonThreeBlue



trumpFiftyRed + clintonFiftyBlue + trumpThreeRed + clintonThreeBlue + plot_layout(ncol = 2)



trumpThreeRed + clintonFiftyBlue



ggplot(election2016) +
  geom_bar(mapping = aes(x=state, y=pct_trump, fill = pct_trump), stat = "identity") +
  scale_fill_gradientn(limits = c(0, 100), colors = threeRedBrews) +
  facet_grid(~ census, drop = TRUE, scales = "free_x") +
  theme_bw() +
  theme(
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    panel.grid.major = element_blank(), 
    panel.grid.minor = element_blank(),
    legend.position = "bottom"
  ) +
  xlab("Regions") +
  ylab("") + 
  labs(title = "2016 Presidential Results for Trump", 
       subtitle ="Distribution by US Region",
       fill = NULL)




ggplot(election2016) +
        geom_bar(mapping = aes(x=state, y=pct_clinton, fill = pct_clinton), stat = "identity") +
  scale_fill_gradientn(limits = c(0, 100), colors = fiftyBlueBrews) +
  facet_grid(~ census, drop = TRUE, scales = "free_x") +
  theme_bw() +
  theme(
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    panel.grid.major = element_blank(), 
    panel.grid.minor = element_blank(),
    legend.position = "bottom"
  ) +
  xlab("Regions") +
  ylab("") + 
  labs(title = "2016 Presidential Results for Clinton", 
       subtitle ="Distribution by US Region",
       fill = NULL)




ggplot(data = subset(election2016,
                       !region %in% "district of columbia"),
         aes(state = state, fill = d_points)) +
  geom_statebins() +
  coord_equal() +
  theme_statebins() +
  scale_fill_gradient2(low = "red", mid = scales::muted("purple"),
                        high = "blue", breaks = c(-100, -75, -50,-25, 0, 25, 50, 75, 100), 
                        labels = c(100, 75, 50, 25, 0, 25, 50, 75, 100)) +
  labs(fill = NULL)



sum(election2016$clinton_vote)



sum(election2016$trump_vote)



sum(election2016$clinton_vote)-sum(election2016$trump_vote)



mapbase <- map_data("state.vbm") %>% 
rename(state = region)  %>% # Rename the column region to state
  select_if(~sum(!is.na(.)) > 0) # Drop any columns where the entire set is NA



head(mapbase) # or View(mapbase)



map("state.vbm", fill=T, col="white")



RViridisD <- viridis_pal(option = "D")(50) # To view use show_col(RViridis)



map("state.vbm", fill=T, col=RViridisD)



data(state.vbm.center) # This is a list. Do View(state.vbm.center) to see it.



truncated_map <- state.vbm.center %>% 
                    as.data.frame() %>% 
                    mutate(state = unique(mapbase$state))



head(truncated_map) # or View(truncated_map)



merged_electoral <- 
  election2016 %>% 
    filter(!st == "DC") %>% 
# Since DC is not a state, it is not included in the map data set so we need to get rid
# of it.
      right_join(mapbase) %>% 
# Its a right join since the mapbase data has the coordinates to draw our map
          select_if(~sum(!is.na(.)) > 0) 
# Drop any columns where the entire set is NA



head(merged_electoral) # or View(merged_electoral)



merged_map <- merged_electoral %>% 
                left_join(truncated_map) # Its a left join since again the 
                                         # merged_electoral data has the coordinates
                                         # to draw our map



head(merged_map) # or View(merged_map)



ggplot(merged_map, aes(long, lat, group = group, fill=state)) + 
  geom_polygon(fill="#FFFFFF", color="#000000") +
  coord_fixed() + 
  theme_minimal() +
  theme(
    axis.ticks = element_blank(),
    axis.text = element_blank(),
    panel.border = element_blank(),
    panel.grid.major = element_blank(), 
    panel.grid.minor = element_blank()
  ) +
  guides(fill = FALSE) +  
  xlab(NULL) +
  ylab(NULL)



ggplot(merged_map, aes(x, y, group = group, fill=state)) + 
  geom_point(color="#8b0a50", size=1) +
  coord_fixed() + 
  theme_minimal() +
  theme(
    axis.ticks = element_blank(),
    axis.text = element_blank(),
    panel.border = element_blank(),
    panel.grid.major = element_blank(), 
    panel.grid.minor = element_blank()
  ) +
  guides(fill = FALSE) +  
  xlab(NULL) +
  ylab(NULL)



ggplot(merged_map, aes(group = group, fill=state)) + 
  geom_polygon(aes(long, lat), fill="#FFFFFF", color="#000000") +
  geom_point(aes(x, y), color="#8b0a50", size=1) +
  coord_fixed() + 
  theme_minimal() +
  theme(
    axis.ticks = element_blank(),
    axis.text = element_blank(),
    panel.border = element_blank(),
    panel.grid.major = element_blank(), 
    panel.grid.minor = element_blank()
  ) +
  guides(fill = FALSE) +  
  xlab(NULL) +
  ylab(NULL)



Trump_rescaledByEC <- merged_map %>% 
                  group_by(state) %>% 
                  filter(party == "Republican") %>% # Only include where Republicans won
                  mutate(longscale = (votes*10/538)*(long - x) + x, # number of electoral votes x 10 divided by the total electoral votes
                  latscale = (votes*10/538)*(lat - y) + y) 



head(Trump_rescaledByEC) # or View(Trump_rescaledByEC)



TrumpByState_EC <- ggplot(Trump_rescaledByEC, aes(long, lat, group = group, fill = pct_trump)) + 
#  geom_path() + # Enable if you want to see the original outline
  geom_polygon(aes(longscale, latscale)) +
  coord_fixed() + 
  theme_void() + 
  scale_fill_gradientn(limits = c(0, 100), colors = threeRedBrews) +
  labs(title = str_wrap("Trump 2016 Popular Vote Resized by Electoral Vote For States Won", 30),
       fill = "Percent") 



TrumpByState_EC



Clinton_rescaledByEC <- merged_map %>% 
  group_by(state) %>% 
  filter(party == "Democrat") %>% # Only include where Democrats won
  mutate(longscale = (votes*10/538)*(long - x) + x,
         latscale = (votes*10/538)*(lat - y) + y) 



head(Clinton_rescaledByEC) # or View(Clinton_rescaledByECp)



ClintonByState_EC <- ggplot(Clinton_rescaledByEC, aes(long, lat, group = group, fill = pct_clinton)) + 
  #  geom_path() + # Enable if you want to see the original outline
  geom_polygon(aes(longscale, latscale)) +
  coord_fixed() + 
  theme_void() + 
  scale_fill_gradientn(limits = c(0, 100), colors = fiftyBlueBrews) +
  labs(title = str_wrap("Clinton 2016 Popular Vote Resized by Electoral Vote by State", 30),
       fill = "Percent")



ClintonByState_EC



TrumpByState_EC + ClintonByState_EC



All_rescaledByEC <- merged_map %>% 
  group_by(state) %>% 
  mutate(longscale = (votes*10/538)*(long - x) + x,
         latscale = (votes*10/538)*(lat - y) + y)



head(All_rescaledByEC) # or View(All_rescaledByEC)



AllByState_EC <- ggplot(All_rescaledByEC, aes(long, lat, group=group, fill=winner)) + 
  #  geom_path() + # Enable if you want to see the original outline
  geom_polygon(aes(longscale, latscale)) +
  coord_fixed() + 
  theme_void() + 
  scale_fill_manual(values= partyColors) +
  labs(title = "States Won by Each Party",
       subtitle ="with each resized by electoral votes",
       fill = NULL) +
  theme_map()+
  theme_statebins() +
  theme(
    axis.ticks = element_blank(),
    axis.text = element_blank(),
    panel.border = element_blank(),
    panel.grid.major = element_blank(), 
    panel.grid.minor = element_blank()
  ) +
  xlab("") +
  ylab("")



AllByState_EC



MarginsByState_EC <- ggplot(data = All_rescaledByEC, aes(long, lat, group=group, fill = d_points)) + 
  geom_polygon(aes(longscale, latscale)) +
 # geom_polygon(color = "gray90", size = 0.1) +
  coord_fixed() + 
# coord_map(projection = "albers", lat0 = 39, lat1 = -20) + 
  scale_fill_gradient2( low = "red", mid = scales::muted("purple"),
                        high = "blue", breaks = c(-100, -75, -50,-25, 0, 25, 50, 75, 100), 
                        labels = c(100, 75, 50, 25, 0, 25, 50, 75, 100)) +
  theme_map() +
  theme_statebins() +
  theme(
    axis.ticks = element_blank(),
    axis.text = element_blank(),
    panel.border = element_blank(),
    panel.grid.major = element_blank(), 
    panel.grid.minor = element_blank()
  ) +      
  labs(title = "Winning margins by Popular Vote",
       subtitle ="with each state resized by electoral votes",
       fill = "Percent")  +
  xlab("") +
  ylab("")



MarginsByState_EC



AllByState_EC + MarginsByState_EC

