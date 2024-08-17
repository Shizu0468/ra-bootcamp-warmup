# (a) Shaping of Semester Data
# (a-1) Reading raw data
# (a-2) For semester_dummy_1.csv, the first row is the column name
setwd("C:/Users/shizu/Documents/warmup training package/01_data/raw/semester_dummy")

sm_df1 = read.csv("semester_data_1.csv", skip = 1)
sm_df2 = read.csv("semester_data_2.csv", col.names = colnames(sm_df1))

# (a-3) Combining two data
sm_df = rbind(sm_df1,sm_df2)
# (a-4) Deleting 'Y' column
sm_df = sm_df[,colnames(sm_df) !="Y"]
# (a-5) Creating a column for the year in which the Semester system was introduced
# I couldn't solve this problem
intro_sm_df = sm_df[sm_df[,"semester"]==1,]

# (a-6) Creating dummy variable
# I couldn't solve this problem

# (b) Shaping of Gradrate Data
# (b-1) Reading raw data and Combining data
library(openxlsx)
setwd("C:/Users/shizu/Documents/warmup training package/01_data/raw/outcome")

flist = list.files(".")
oc_df = data.frame()
for (fn in flist) {
  tdf = read.xlsx(fn)
  oc_df = rbind(oc_df,tdf)
}
# (b-2) Changing women_gradrate_4yr scale from 0 to 1
oc_df[,"women_gradrate_4yr"] = oc_df[,"women_gradrate_4yr"]* 0.01
# (b-3) Creating new columns named "total_gradrate_4yr", "men_gradrate_4yr"
oc_df[,"totcohortsize"] = as.numeric(oc_df[,"totcohortsize"])
oc_df[,"total_gradrate_4yr"] = oc_df[,"tot4yrgrads"] / oc_df[,"totcohortsize"]
oc_df[,"m_4yrgrads"] = as.numeric(oc_df[,"m_4yrgrads"])
oc_df[,"men_gradrate_4yr"] = oc_df[,"m_4yrgrads"] / oc_df[,"m_cohortsize"]
# (b-4) Adjusting significant figures to 3 digits
oc_df[,"total_gradrate_4yr"] = round(oc_df[,"total_gradrate_4yr"], digits = 3)
oc_df[,"men_gradrate_4yr"] = round(oc_df[,"men_gradrate_4yr"], digits = 3)
# (b-5) Transforming into a data frame from 1991 to 2010
oc_df = oc_df[oc_df[,"year"] <= 2010,]

# (c) Shaping of Covariates Data
# (c-1) Reading raw data
setwd("C:/Users/shizu/Documents/warmup training package/01_data/raw/covariates")

cv_df = read.xlsx("covariates.xlsx")
# (c-2) Changing column name 'university_id' to 'unitid'
library(dplyr)
cv_df = rename(cv_df,unitid = university_id)
# (c-3) Deleting the chracter “aaaa” in 'unitid'
library(stringr)
cv_df[,"unitid"] = str_remove_all(cv_df[,"unitid"], "aaaa")
# (c-4) Changing data frame to a Wide type
library(tidyr)
cv_df = pivot_wider(cv_df, names_from = category, values_from = value)
# (c-5) Arranging year of covariates data with others
cv_df = cv_df[(cv_df[,"year"]>= 1991) & (cv_df[,"year"]<= 2010),]
# (c-6) Arranging unitid of covariates data with outcome data
unitid_list = unique(oc_df[,"unitid"])
cv_df = filter(cv_df, unitid %in% unitid_list)

# (D) Creating Master Data
# I couldn't solve this problem
