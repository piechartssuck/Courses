# ----
library(tidyverse)


# ----
prices <- read_csv("2014-average-ticket-price.csv", 
                   na = "NA")


# ----
prices


# ----
head(prices)


# ----
hist(prices$`Avg TP, $`)


# ----
unique(prices$Division)


# ----
afc_north <- filter(prices, Division == "AFC North")
afc_east <- filter(prices, Division == "AFC East")
afc_west <- filter(prices, Division == "AFC West")
afc_south <- filter(prices, Division == "AFC South")
nfc_north <- filter(prices, Division == "NFC North")
nfc_east <- filter(prices, Division == "NFC East")
nfc_west <- filter(prices, Division == "NFC West")
nfc_south <- filter(prices, Division == "NFC South")


# ----
afc_north 


# ----
hist(afc_north$`Avg TP, $`)


# ----
hist(afc_east$`Avg TP, $`)


# ----
hist(afc_west$`Avg TP, $`)


# ----
hist(afc_south$`Avg TP, $`)


# ----
hist(nfc_north$`Avg TP, $`)


# ----
hist(nfc_east$`Avg TP, $`)


# ----
hist(nfc_west$`Avg TP, $`)


# ----
hist(nfc_south$`Avg TP, $`)


# ----
median(afc_north$`Avg TP, $`, na.rm = TRUE)


# ----
median(afc_east$`Avg TP, $`, na.rm = TRUE)


# ----
median(afc_west$`Avg TP, $`, na.rm = TRUE)


# ----
median(afc_south$`Avg TP, $`, na.rm = TRUE)


# ----
median(nfc_north$`Avg TP, $`, na.rm = TRUE)


# ----
median(nfc_east$`Avg TP, $`, na.rm = TRUE)


# ----
median(nfc_west$`Avg TP, $`, na.rm = TRUE)


# ----
median(nfc_south$`Avg TP, $`, na.rm = TRUE)


# ----
x = 100
mu_afc_north = mean(afc_north$`Avg TP, $`)
sigma_afc_north = sd(afc_north$`Avg TP, $`)


# ----
z_score_afc_north = (x - mu_afc_north)/sigma_afc_north
z_score_afc_north

pnorm(z_score_afc_north)


# ----
mu_afc_north

pnorm(x, mu_afc_north, sigma_afc_north)


# ----
pnormGC(x, 
        region = "below",
        mean = mu_afc_north,
        sd = sigma_afc_north,
        graph = TRUE)


# ----
ggplot(afc_north, aes(x = str_wrap(Event, 30), y = `Avg TP, $`, fill = `Avg TP, $`)) +
  geom_col(show.legend = FALSE) +
  geom_hline(aes(yintercept = median(`Avg TP, $`)), color = "#ee4035", size = 2, alpha = 0.5) +
  geom_hline(aes(yintercept = mean(`Avg TP, $`)), color = "#0392cf", size = 2, alpha = 0.5) +
  scale_fill_gradient(low = "#e5c3c6", high ="#bcd2d0") +
  ggtitle("Histogram of Average AFC North Ticket Prices by Event") +
  xlab("Event") +
  ylab("Price") +
  theme_minimal()  +
  theme(axis.text.x = element_text(angle = 90),
        panel.grid.major.x = element_blank(),
        panel.grid.minor = element_blank())


# ----
ggplot(afc_north, aes(x = str_wrap(Event, 30), y = `Avg TP, $`, fill = `Avg TP, $`)) +
  geom_col(show.legend = FALSE) +
  geom_hline(aes(yintercept = median(`Avg TP, $`)), color = "#ee4035", size = 2, alpha = 0.5) +
  geom_hline(aes(yintercept = mean(`Avg TP, $`)), color = "#0392cf", size = 2, alpha = 0.5) +
  scale_fill_gradient(low = "#e5c3c6", high ="#bcd2d0") +
  ggtitle("Histogram of Average AFC North Ticket Prices by Event") +
  xlab("Event") +
  ylab("Price") +
  theme_minimal()  +
  theme(axis.text.x = element_text(angle = 90),
        panel.grid.major.x = element_blank(),
        panel.grid.minor = element_blank())

