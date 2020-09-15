library(hexSticker)
library(tidyverse)
library(babynames)
library(streamgraph)
library(httr)
library(zoo)      
library(hrbrmisc) 
library(viridis)
library(wesanderson)
library(showtext)
font_add("Jost* Semi", "Jost-600-Semi.otf")
font_add("Jost* Semi Italic", "Jost-600-SemiItalic.otf")
font_add("Jost* Black", "Jost-900-Black.otf")
font_add("Jost* Medium", "Jost-500-Medium.otf")
font_add("Jost* Light", "Jost-300-Light.otf")
font_add("Jost* Bold", "Jost-700-Bold.otf")
font_add("Jost* Heavy", "Jost-800-Heavy.otf")
showtext_auto()


URL <- "https://www.metoffice.gov.uk/hadobs/hadcrut4/data/current/time_series/HadCRUT.4.6.0.0.monthly_ns_avg.txt"

global_temps <- read_table(URL, col_names=FALSE) %>%
        select(year_mon=1, median=2, lower=11, upper=12) %>%
        mutate(year_mon=as.Date(as.yearmon(year_mon, format="%Y/%m")),
               year=as.numeric(format(year_mon, "%Y")),
               decade=(year %/% 10) * 10,
               month=format(year_mon, "%b")) %>%
        mutate(month=factor(month, levels=month.abb)) %>%
        filter(year != 2016) 


pal <- wes_palette("GrandBudapest1", 100, type = "continuous")

#+ hadcrut, fig.retina=2, fig.width=12, fig.height=6
steam <- ggplot(global_temps) + 
         geom_segment(aes(x=year_mon, 
                          xend=year_mon, 
                          y=lower, 
                          yend=upper, 
                          color=year), 
                          size=0.1,
                          show.legend = FALSE) + 
    #     geom_point(aes(x=year_mon, 
     #                   y=median), 
     #               color="#E5EEED", 
     #               size=0.00001) + 
         scale_shape_manual(values=c(1)) +
         scale_size_continuous(range = c(0.000001)) +
         scale_x_date(expand=c(0,0.2)) +
         scale_y_continuous(name=NULL, breaks=c(0, 1.5, 2),
                            limits=c(-2, 2.25)) + 
         scale_color_gradientn(colours = pal) 
        

 
steam_preview <- steam +
                 theme_minimal() +
                 theme_transparent() +
                 theme(panel.background=element_rect(fill="#292A30", 
                                                     color="#292A30", 
                                                     size=1),
                 panel.grid=element_blank(),
                 axis.text=element_blank(),
                 axis.title=element_blank())

steam_preview

steam_trans <- steam + 
               theme_void() + 
               theme_transparent()  

steam_trans

sticker(steam_trans, 
        package="EDP 611", 
        p_size=8, 
        s_x=1, 
        s_y=1.0, 
        s_width=2.2, 
        s_height=2.2,
        h_fill="#292A30",
        h_color="#293840",
        p_family = "Jost* Bold",
        filename="steamhex.png")

