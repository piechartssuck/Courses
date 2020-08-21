# Graphic for the bottom of the main page 

# Set the working directory as source ----
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# Remove objects ----
rm(list = ls())

# Libraries
library(ggraph)
library(igraph)
library(tidyverse)
library(RColorBrewer)
library(hexSticker)

library(showtext)
font_add("Jost* Light", "Jost-300-Light.otf")
font_add("Jost* Medium", "Jost-500-Medium.otf")
font_add("Jost* Semi", "Jost-600-Semi.otf")
font_add("Jost* Semi Italic", "Jost-600-SemiItalic.otf")
font_add("Jost* Bold", "Jost-700-Bold.otf")
font_add("Jost* Heavy", "Jost-800-Heavy.otf")
font_add("Jost* Black", "Jost-900-Black.otf")
font_add("No Tears", "No Tears.ttf")
font_add("No Tears Bold", "No Tears Bold.ttf")
showtext_auto()

# create a data frame giving the hierarchical structure of your individuals
set.seed(1234)
d1 <- data.frame(from="origin", to=paste("group", seq(1,10), sep=""))
d2 <- data.frame(from=rep(d1$to, each=10), to=paste("subgroup", seq(1,100), sep="_"))
hierarchy <- rbind(d1, d2)

# create a dataframe with connection between leaves (individuals)
all_leaves <- paste("subgroup", seq(1,100), sep="_")
connect <- rbind( 
  data.frame( from=sample(all_leaves, 100, replace=T) , to=sample(all_leaves, 100, replace=T)), 
  data.frame( from=sample(head(all_leaves), 30, replace=T) , to=sample( tail(all_leaves), 30, replace=T)), 
  data.frame( from=sample(all_leaves[25:30], 30, replace=T) , to=sample( all_leaves[55:60], 30, replace=T)), 
  data.frame( from=sample(all_leaves[75:80], 30, replace=T) , to=sample( all_leaves[55:60], 30, replace=T)) )
connect$value <- runif(nrow(connect))

# create a vertices data.frame. One line per object of our hierarchy
vertices  <-  data.frame(
  name = unique(c(as.character(hierarchy$from), as.character(hierarchy$to))) , 
  value = runif(111)
) 
# Let's add a column with the group of each name. It will be useful later to color points
vertices$group  <-  hierarchy$from[ match( vertices$name, hierarchy$to ) ]


# Create a graph object
mygraph <- graph_from_data_frame( hierarchy, vertices=vertices )

# The connection object must refer to the ids of the leaves:
from  <-  match( connect$from, vertices$name)
to  <-  match( connect$to, vertices$name)

# Basic usual argument
circos <- ggraph(mygraph, layout = 'dendrogram', circular = TRUE) + 
             geom_conn_bundle(data = get_con(from = from, 
                                             to = to,
                                             tension=0.3), 
                   width=0.15, 
                   alpha=0.25, 
                   aes(color=..index..)) +
  scale_edge_color_viridis(option = "D",
                           direction = -1) +
#  scale_edge_colour_distiller(palette = "RdPu") +
  theme_void() +
  theme(legend.position = "none") + 
  geom_node_point(aes(filter = leaf, x = x*1.05, y=y*1.05, colour=group, size=value, alpha=0.2)) +
  scale_colour_viridis_d(option = "D",
                         direction = 1) +
  scale_size_continuous( range = c(0.1,0.5) ) 

circos

sticker(circos, 
        package="EDP 619", 
        p_size=7, 
        s_x=1.0, 
        s_y=1.0, 
        s_width=1.6, 
        s_height=1.6,
        h_fill="#292A30",
        h_color="#293840",
        p_family = "No Tears Bold",
        filename="circoshex.png")

