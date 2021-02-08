## -----------------------------------------------------------------------------------------
library(ggplot2)
library(cowplot)
library(RColorBrewer)


## -----------------------------------------------------------------------------------------
ggplot() +
  layer(
    data = diamonds, 
    mapping = aes(x = carat, y = price),
    geom = "point",  
    stat = "identity", 
    position = "identity" ) +
  scale_y_continuous() +
  scale_x_continuous() +
  coord_cartesian()


## -----------------------------------------------------------------------------------------
ggplot(data = diamonds, 
  mapping = aes(x = carat, y = price)) +
  geom_point()


## -----------------------------------------------------------------------------------------
ggplot(diamonds, aes(carat, price)) +
  geom_point()


## -----------------------------------------------------------------------------------------
data <- structure(list(V1 = c(34.88372093, 
                              35.07751938, 
                              35.27131783, 
                              35.46511628, 
                              35.65891473, 
                              35.85271318), 
                       V2 = c(0.00029997, 
                              0.00019998, 
                              0.00029997, 
                              0.00029997, 
                              0.00069993, 
                              0.00069993)), 
                      .Names = c("Perc", "Prop"), 
                  row.names = c(NA, 6L), 
                  class = "data.frame")



## ----eval=FALSE---------------------------------------------------------------------------
## View(data)


## -----------------------------------------------------------------------------------------
barplot(data$Perc, 
        data$Perc, 
        xlab="Percentage", 
        ylab="Proportion")


## -----------------------------------------------------------------------------------------
ggplot(data, aes(x=Perc, y=Prop)) + 
  geom_bar(stat="identity") + 
  labs(x="Percentage", y="Proportion")


## -----------------------------------------------------------------------------------------
ggplot(data, aes(x=Perc, y=Prop, fill = Perc)) + 
  geom_bar(stat="identity") + 
  labs(x="Percentage", y="Proportion") +
  scale_color_brewer()


## ----message=FALSE------------------------------------------------------------------------
library(xlsx)           # for reading in Excel data
library(magrittr)       # for easier syntax in one or two areas
library(gridExtra)      # old method for generating some comparison plots
library(patchwork)      # new method for generating some comparison plots
library(ggplot2)        # for generating the visualizations
library(viridis)        # because colors are fun!


## -----------------------------------------------------------------------------------------
head(mtcars)


## -----------------------------------------------------------------------------------------
# x-axis as continuous
p1 <- ggplot(mtcars, aes(x = cyl)) +
  geom_bar() +
  ggtitle("Fig. A: x-axis as a continuous variable")

# x-axis as discrete
p2 <- ggplot(mtcars, aes(x = factor(cyl))) +
  geom_bar() +
  ggtitle("Fig B: x-axis as a discrete (factor) variable")


## -----------------------------------------------------------------------------------------
grid.arrange(p1, p2, ncol = 2)


## -----------------------------------------------------------------------------------------
p1 + p2


## -----------------------------------------------------------------------------------------
e1 <- ggplot(mtcars, aes(x = factor(cyl))) +
  geom_bar(width = .5) +
  ggtitle("bar width = 0.5")

e2 <- ggplot(mtcars, aes(x = factor(cyl))) +
  geom_bar(width = .75) +
  ggtitle("bar width = 0.75")

e3 <- ggplot(mtcars, aes(x = factor(cyl))) +
  geom_bar(width = .9) +
  ggtitle("bar width = 0.9")

e4 <- ggplot(mtcars, aes(x = factor(cyl))) +
  geom_bar(width = .99) +
  ggtitle("bar width = 0.99")


## -----------------------------------------------------------------------------------------
e1 + e2 + e3 + e4


## -----------------------------------------------------------------------------------------
e1 + e2 + e3 + e4 + plot_layout(ncol = 1)


## -----------------------------------------------------------------------------------------
e1 + e2 + e3 + e4 + plot_layout(nrow = 1)


## -----------------------------------------------------------------------------------------
ggplot(mtcars, aes(x = factor(cyl))) +
  geom_bar(fill = "dodgerblue", 
           color = "grey40", 
           alpha = 0.5)


## -----------------------------------------------------------------------------------------
t1 <- ggplot(mtcars, aes(x = row.names(mtcars), y = mpg)) +
  geom_bar(stat = "identity") +
  ggtitle("Fig. A: Default x-axis")

t1

t2 <- ggplot(mtcars, aes(x = row.names(mtcars), y = mpg)) +
  geom_bar(stat = "identity") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = .5)) +
  ggtitle("Fig. B: Rotated x-axis")

t2

t1 + t2 + plot_layout(ncol = 1)


## -----------------------------------------------------------------------------------------
r1 <- ggplot(mtcars, aes(x = row.names(mtcars), mpg)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  ggtitle("Fig. A: Default rotated x-axis")

# order bars
r2 <- ggplot(mtcars, aes(x = reorder(row.names(mtcars), mpg), y = mpg)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  ggtitle("Fig. B: Rotated ordered x-axis")

r1 + r2 + plot_layout(nrow = 1)


## -----------------------------------------------------------------------------------------
m1 <- ggplot(mtcars, aes(x = reorder(row.names(mtcars), mpg), y = mpg, fill = factor(cyl))) +
  geom_bar(stat = "identity") +
  coord_flip() +
  theme_minimal() +
  ggtitle("Fig. A: Default fill colors")

m2 <- ggplot(mtcars, aes(x = reorder(row.names(mtcars), mpg), y = mpg, fill = factor(cyl))) +
  scale_fill_manual(values = c("#e5f5e0", "#a1d99b", "#31a354")) +
  geom_bar(stat = "identity") +
  coord_flip() +
  theme_minimal() +
  ggtitle("Fig. B: Manually set fill colors")


m1 + m2 + plot_layout(ncol = 2)


## -----------------------------------------------------------------------------------------
t1 <- ggplot(mtcars, aes(factor(cyl), mpg, fill = factor(am))) +
  geom_bar(stat = "identity", position = "dodge") +
  ggtitle("Default color comparison")

# more pleasing colors
t2 <- ggplot(mtcars, aes(factor(cyl), mpg, fill = factor(am))) +
  geom_bar(stat = "identity", position = "dodge") +
  scale_fill_brewer(palette = "Pastel1") +
  ggtitle("Adjusted color comparison")

t1 + t2 + plot_layout(ncol = 2)


## -----------------------------------------------------------------------------------------
l1 <- ggplot(mtcars, aes(factor(cyl), mpg, fill = factor(am))) +
  geom_bar(stat = "identity", position = "dodge") +
  ggtitle("Default dodge positioning") +
  theme(legend.position = "none")

l2 <- ggplot(mtcars, aes(factor(cyl), mpg, fill = factor(am))) +
  geom_bar(stat = "identity", position = position_dodge(width = .5)) +
  ggtitle("Overlap of side-by-side bars") +
  theme(legend.position = "none")

l3 <- ggplot(mtcars, aes(factor(cyl), mpg, fill = factor(am))) +
  geom_bar(stat = "identity", position = position_dodge(width = 1)) +
  ggtitle("Spacing between side-by-side bars") +
  labs(fill = "AM") +
  theme(legend.position = c(1,1), legend.justification = c(1,1),
        legend.background = element_blank())


l1 + l2 + l3 + plot_layout(ncol = 3)


## -----------------------------------------------------------------------------------------
ggplot(mtcars, aes(factor(cyl), mpg, fill = factor(am))) +
  geom_bar(stat = "identity")


## -----------------------------------------------------------------------------------------
# reverse legend color coding layout
q1 <- ggplot(mtcars, aes(factor(cyl), mpg, fill = factor(am))) +
  geom_bar(stat = "identity") +
  guides(fill = guide_legend(reverse = TRUE)) +
  labs(fill = "am") +
  ggtitle("Fig A: Reverse legend")

# or reverse stacking order by changing the factor levels
q2 <- ggplot(mtcars, aes(factor(cyl), mpg, fill = factor(am, levels = c(1, 0)))) +
  geom_bar(stat = "identity") +
  labs(fill = "am") +
  ggtitle("Fig B: Specify levels")

q1 + q2 + plot_layout(ncol = 2)


## -----------------------------------------------------------------------------------------
ggplot(mtcars, aes(factor(cyl), mpg, fill = factor(am, levels = c(1, 0)))) +
  geom_bar(stat = "identity") +
  scale_fill_manual(values = c("#a1d99b", "#31a354")) +
  labs(fill = "AM")


## -----------------------------------------------------------------------------------------
p1 <- ggplot(mtcars, aes(reorder(row.names(mtcars), mpg), mpg)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  geom_text(aes(label = mpg), nudge_y = 2)

p2 <- ggplot(mtcars, aes(reorder(row.names(mtcars), mpg), mpg)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  geom_text(aes(label = mpg), nudge_y = -2, color = "white")

p1 + p2 + plot_layout(ncol = 2)


## -----------------------------------------------------------------------------------------
p1 <- ggplot(mtcars, aes(factor(cyl), mpg, fill = factor(am))) +
  geom_bar(stat = "identity", position = "dodge") +
  geom_text(aes(label = round(mpg, 1)), position = position_dodge(0.9)) +
  ggtitle("Fig A: Default text alignment")

p2 <- ggplot(mtcars, aes(factor(cyl), mpg, fill = factor(am))) +
  geom_bar(stat = "identity", position = "dodge") +
  geom_text(aes(label = round(mpg, 1)), position = position_dodge(0.9),
            vjust = 1.5, color = "white") +
  ggtitle("Fig B: Adjusted text alignment")

p1 + p2 + plot_layout(ncol = 2)


## ----eval=FALSE---------------------------------------------------------------------------
## p1 <- ggplot(mtcars, aes(factor(cyl), mpg, fill = factor(am))) +
##   geom_bar(stat = "identity", position = "dodge") +
##   geom_text(aes(label = round(mpg, 1)), position = position_dodge(0.9)) +
##   ggtitle("Fig A: Default text alignment")
## 
## p2 <- ggplot(mtcars, aes(factor(cyl), mpg, fill = factor(am))) +
##   geom_bar(stat = "identity", position = "dodge") +
##   scale_fill_viridis_c(option = "D") +
##   geom_text(aes(label = round(mpg, 1)), position = position_dodge(0.9),
##             vjust = 1.5, color = "white") +
##   ggtitle("Fig B: Adjusted text alignment")
## 
## p2


## -----------------------------------------------------------------------------------------
p2 <- ggplot(mtcars, aes(factor(cyl), mpg, fill = am)) +
  geom_bar(stat = "identity", position = "dodge") +
  scale_fill_viridis_c(option = "D") +
  geom_text(aes(label = round(mpg, 1)), position = position_dodge(0.9),
            vjust = 1.5, color = "white") +
  ggtitle("Fig B: Adjusted text alignment")

p2


## -----------------------------------------------------------------------------------------
p2 <- ggplot(mtcars, aes(factor(cyl), mpg, fill = factor(am))) +
  geom_bar(stat = "identity", position = "dodge") +
  scale_fill_viridis_d(option = "D") +
  geom_text(aes(label = round(mpg, 1)), position = position_dodge(0.9),
            vjust = 1.5, color = "white") +
  ggtitle("Fig B: Adjusted text alignment")

p2

