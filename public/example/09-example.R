library(igraph)

edges <- read_csv("star-wars-network-edges.csv")

nodes <- read_csv("star-wars-network-nodes.csv")

head(edges)

head(nodes)



g <- graph_from_data_frame(d=edges, 
                           vertices=nodes,
                           directed=FALSE)



g 


V(g)



V(g)$name



V(g)$weight



vertex_attr(g)



E(g)



E(g)$weight



edge_attr(g)



g[]



g[1,]



plot(g)



plot(g,
     vertex.color = "grey", # change color of nodes
     vertex.label.color = "black", # change color of labels
     vertex.label.cex = 0.75, # change size of labels to 75% of original size
     edge.curved = 0.25, # add a 25% curve to the edges
     edge.color = "#333333") # change edge color to grey20



V(g)$size <- strength(g)
plot(g)

# taking the log to improve it
V(g)$size <- log(strength(g)) * 4 + 3
plot(g)

V(g)$label <- ifelse( strength(g)>=10, 
                      V(g)$name, 
                      NA )

plot(g)

# Think about what `ifelse()` does
nodes$name=="R2-D2"
ifelse(nodes$name=="R2-D2", "yes", "no")
ifelse(grepl("R", nodes$name), "yes", "no")



# create vectors with characters in each side
dark_side <- c("DARTH VADER", "MOTTI", "TARKIN")
light_side <- c("R2-D2", "CHEWBACCA", "C-3PO", "LUKE", "CAMIE", "BIGGS",
                "LEIA", "BERU", "OWEN", "OBI-WAN", "HAN", "DODONNA",
                "GOLD LEADER", "WEDGE", "RED LEADER", "RED TEN", "GOLD FIVE")
other <- c("GREEDO", "JABBA")

# node we'll create a new color variable as a node property
V(g)$color <- NA
V(g)$color[V(g)$name %in% dark_side] <- "red"
V(g)$color[V(g)$name %in% light_side] <- "gold"
V(g)$color[V(g)$name %in% other] <- "grey20"
vertex_attr(g)
plot(g)

# Think about what `%in%` does
1 %in% c(1,2,3,4)
1 %in% c(2,3,4)



plot(g)
legend(x = 0.75, 
       y = 0.75, 
       legend = c("Dark side", "Light side", "Other"), 
       pch=21, 
       pt.bg = c("red", "gold", "grey20"), 
       pt.cex = 2, 
       bty = "n")



E(g)$width <- log(E(g)$weight) + 1

edge_attr(g)

plot(g)

par(mfrow=c(2, 3), mar=c(0,0,1,0))
plot(g, layout=layout_randomly, main="Random")
plot(g, layout=layout_in_circle, main="Circle")
plot(g, layout=layout_as_star, main="Star")
plot(g, layout=layout_as_tree, main="Tree")
plot(g, layout=layout_on_grid, main="Grid")
plot(g, layout=layout_with_fr, main="Force-directed")


l <- layout_randomly(g)
str(l)


par(mfrow=c(1,2))

set.seed(777)
fr <- layout_with_fr(g, niter=1000)

par(mar=c(0,0,0,0)); plot(g, layout=fr)

set.seed(666)
fr <- layout_with_fr(g, niter=1000)

plot(g, layout=fr)



sort(degree(g))



sort(strength(g))



sort(closeness(g, normalized=TRUE))



sort(betweenness(g))



sort(eigen_centrality(g)$vector)



sort(page_rank(g)$vector)



sort(authority_score(g)$vector)



neighbors(g, v=which(V(g)$name=="DARTH VADER"))
ego(g, order=2, nodes=which(V(g)$name=="DARTH VADER"))



diameter(g, directed=FALSE, weights=NA)
get_diameter(g, directed=FALSE, weights=NA)
mean_distance(g, directed=FALSE)
dist <- distances(g, weights=NA)
dist[1:5, 1:5]



edge_density(g)
# 22*21 possible edges / 2 because it's undirected = 231 possible edges but only 60 exist
60/((22*21)/2)



reciprocity(g)
# Why is it 1?



transitivity(g)



components(g)
par(mar=c(0,0,0,0)); plot(g)



giant <- decompose(g)[[1]]



cluster_walktrap(giant)
cluster_walktrap(giant, steps=10)



cluster_fast_greedy(giant)
cluster_edge_betweenness(giant)
cluster_infomap(giant)
cluster_label_prop(giant)



comm <- cluster_infomap(giant)
modularity(comm) # modularity score
par(mar=c(0,0,0,0)); plot(comm, giant)



V(giant)$color <- membership(comm)
par(mar=c(0,0,0,0)); plot(giant)


coreness(g)
which(coreness(g)==6) # what is the core of the network?
which(coreness(g)==1) # what is the periphery of the network?

# Visualizing network structure
V(g)$coreness <- coreness(g)

par(mfrow=c(2, 3), mar=c(0.1,0.1,1,0.1))

set.seed(777); fr <- layout_with_fr(g)

for (k in 1:6){
  V(g)$color <- ifelse(V(g)$coreness>=k, "orange", "grey")
  plot(g, main=paste0(k, '-core shell'), layout=fr)
}



library(tidyverse)



nodes



edges



library(network)



starwars_network <- 
  network(edges, 
          vertex.attr = nodes,
          matrix.type = "edgelist",
          ignore.eval = FALSE)



class(starwars_network)



summary(starwars_network)



plot(starwars_network)



plot(starwars_network,
     vertex.cex = 3)



plot(starwars_network,
     vertex.cex = 3,
     mode = "circle")



plot(starwars_network,
     vertex.cex = 3,
     mode = "kamadakawai")



library(tidygraph)
library(ggraph)



detach(package:network)



rm(starwars_network)



starwars_tidy <- 
  tbl_graph(nodes = nodes, 
            edges = edges, 
            directed = FALSE)



class(starwars_tidy)



starwars_tidy



starwars_tidy %>% 
  activate(edges) %>% 
  arrange(desc(weight))



ggraph(starwars_tidy) + 
  geom_edge_link() + 
  geom_node_point() + 
  theme_graph()



ggraph(starwars_tidy, 
       layout = "graphopt") + 
  geom_edge_link(aes(width = weight), 
                 alpha = 0.5,
                 show.legend = FALSE) + 
  scale_edge_width(range = c(0.2, 1.2)) +
  geom_node_point(aes(size = centrality_pagerank(),
                      fill = centrality_degree()),
                  shape = 21,
                  stroke = 1.4,
                  color = "#4d194d",
                  show.legend = FALSE) +
  scale_size(range = c(1, 14)) +
  scale_fill_gradient(low = "#81b29a", high = "#3d405b") +
  geom_node_label(aes(label = name),
                 repel = TRUE) +
  coord_fixed() +
  theme_graph()



ggraph(starwars_tidy, 
       layout = "linear",
       circular = TRUE) + 
  geom_edge_arc(aes(width = weight,
                    color = weight), 
                alpha = 0.8,
                show.legend = FALSE) + 
  scale_edge_width(range = c(0.2, 2)) +
  scale_edge_color_gradient(low = "#b7094c", high = "#0091ad") +
  geom_node_label(aes(label = name,
                      size = centrality_betweenness()),
                  show.legend = FALSE) +
  scale_size(range = c(3, 6)) +
  theme_graph()



library(visNetwork)
library(networkD3)



edge_list <-
  starwars_tidy %>%
    activate(edges) %>%
    data.frame()



edge_list



node_list <-
  starwars_tidy %>%
    activate(nodes) %>%
    data.frame() %>%
    rename(label = name) %>%
    rename(group = allegiance)



node_list



visNetwork(node_list,
           edge_list)



new_node_list <- node_list %>%
                  mutate(borderWidth = 1.5) %>%
                  mutate(color.background = 
                           case_when(
                             group == "Galactic Republic" ~ "#CF6728",
                             group == "Jedi Order" ~ "#4BA1F0",
                             group == "Galactic Empire" ~ "#741D2F",
                             group == "Sith Order" ~ "#912721",
                             group == "Hutt Cartel" ~ "#c3cb71",
                             group == "Unknown" ~ "#5a5255"
                           )
                  ) %>%
                  mutate(color.border = "#43675a") %>%
                  mutate(color.highlight.border = "#3a95a7") %>%
                  mutate(font.color = "#FFFFFF")



weighted_edges <- mutate(edge_list, 
                         width = weight/4 + 1)



weighted_edges 



visNetwork(new_node_list, 
           weighted_edges, 
           height = "700px", 
           width = "100%") %>%
  visEdges(color = "#c7bbc9") %>%
  visNodes(shape = "circle", 
           color = list(hover = "#5cb85c",
                        highlight = "#449d44"), 
           shadow = list(enabled = TRUE, 
                         size = 5))  %>%
  visInteraction(navigationButtons = TRUE, 
                 hover = TRUE) %>%
  visOptions(selectedBy = "group",
             highlightNearest = TRUE, 
             nodesIdSelection = TRUE,
             collapse = TRUE) %>%
  visPhysics(solver = "repulsion", 
             repulsion = list(nodeDistance = 400, 
                              springlength = 300, 
                              centralGravity = 0.2),
             timestep = 0.75, 
             stabilization = TRUE) %>%
  visPhysics(stabilization = FALSE)   %>%
  visLayout(randomSeed = 12)



node_list_byside <-
        starwars_tidy %>%
          activate(nodes) %>%
          data.frame() %>%
          rename(label = name) 



nodes_d3 <- mutate(node_list, 
                   id = id - 1)

edges_d3 <- mutate(edge_list, 
                   from = from - 1, 
                   to = to - 1)



forceNetwork(Links = edges_d3, 
             Nodes = nodes_d3, 
             Source = "from", 
             Target = "to", 
             NodeID = "label", 
             Group = "id", 
             Value = "weight", 
             opacity = 1, 
             fontSize = 16, 
             zoom = TRUE)



sankeyNetwork(Links = edges_d3, 
              Nodes = nodes_d3, 
              Source = "from",
              Target = "to", 
              NodeID = "label", 
              Value = "weight", 
              fontSize = 16, 
              unit = "Letter(s)")

