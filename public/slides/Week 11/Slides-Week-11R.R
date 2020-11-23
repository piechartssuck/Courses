# install.packages("compareGroups")

library(compareGroups)
library(tidyverse)

# load the predimed data set
# you can download a copy of the study from Pubmed: https://pubmed.ncbi.nlm.nih.gov/29897866/
data("predimed")

# take a look
predimed %>%
  head()

# take a look in a descriptive table
tab <- descrTable(group ~ ., predimed)
tab
class(tab)

comparison <- compareGroups(group ~ ., predimed)
comparison

# check for the compareGroups class
class(comparison)

# subsetting: looking at some variables: the impact of age, smoking, waist size, and hypercholesterol together
compareGroups(group ~ age + smoke + waist + hyperchol, data = predimed)

# subsetting: looking at some variables: the impact of age, smoking, waist size, and hypercholesterol together on females
compareGroups(group ~ age + smoke + waist + hyperchol, data = predimed, 
              subset = sex == "Female")

# get the p-values
pvals <- getResults(comparison, "p.overall")

# create an APA formatted table
export_comparison <- createTable(comparison) # Same as the descrTable but for exporting!

# take a look at some descriptive statistics
plot(export_comparison["sex"]) # barplot
plot(export_comparison["age"]) # histogram and normality plot

# some common ways to export
export2csv(export_comparison, file = "comparison.csv") # as a csv file
export2word(export_comparison, file = "comparison.docx") # as a word file
export2xls(export_comparison, file = "comparison.xls") # as a word file
export2pdf(export_comparison, file = "comparison.pdf") # as a pdf file

# GUI
cGroupsGUI(predimed)
