install.packages(c("mice", "naniar"), dependencies = TRUE)

library("tidyverse")
library("mice")
library("naniar")
library("reactable")


setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

nerdy_data <- read_csv("NerdyDataMissing.csv")

nerdy_pm_codebook <- read_csv("NerdyCodebook_PM.csv")

nerdy_pm_measures <- read_csv("NerdyMeasures_PM.csv")


nerdy_data %>%
  head()

reactable(nerdy_data,
          searchable = TRUE, 
          defaultPageSize = 5,
          showPageSizeOptions = TRUE,
          highlight = TRUE)


nerdy_pm_codebook

nerdy_pm_measures


mcar_test(nerdy_data)

n_var_miss(nerdy_data)


gg_miss_var(nerdy_data)

gg_miss_upset(nerdy_data,
              nsets = n_var_miss(nerdy_data))

gg_miss_upset(nerdy_data,
              nsets = 5)



nerdy_data_rowid <- nerdy_data %>% 
                    rowid_to_column("respondent")

nerdy_data_rowid



ggplot(data = nerdy_data_rowid, 
       aes(x = respondent,
       y = Q1)) +
  geom_miss_point()


ggplot(data = nerdy_data_rowid, 
       aes(x = respondent,
       y = Q1)) +
  geom_miss_point(size = 2) +
  theme_minimal()


nerdy_data_imputed <- mice(nerdy_data, 
                              m = 15, 
                              method = 'pmm')  %>%
                           complete(1) %>%
                           as_tibble()

nerdy_data_imputed


n_var_miss(nerdy_data_imputed)

gg_miss_var(nerdy_data_imputed)

gg_miss_upset(nerdy_data_imputed)

