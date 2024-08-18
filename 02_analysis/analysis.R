# I used Intermediate Data that had already been provided in this analysis

# (a) Descriptive Statistics
# (a-1) Counting number of NA in each column of Master Data
setwd("C:/Users/shizu/Documents/warmup training package/01_data/intermediate")
ms_df = read.csv("master.csv", row.names=1)
count_na = function(x) {
  return(sum(is.na(x)))
}
na_count_per_column = sapply(ms_df, count_na)
print(na_count_per_column)
# (a-2) Creating Descriptive Statistics
sdf = unique(ms_df[ms_df[,"year"]==2010 & ms_df[,"semester"]==1,])
n_sdf = unique(ms_df[ms_df[,"year"]==2010 & ms_df[,"semester"]==0,])

# install.packages("summarytools")
library(summarytools)
sdf_sum = descr(sdf, stats = c("mean", "sd"), transpose = TRUE)
sdf_sum = tb(sdf_sum)
# (a-3) Showing the average four-year graduation rate
# (a-4) Showing Semester system introduction rate
# (a-5) Creating Scatter Diagram
# (b) Regression Analysis
