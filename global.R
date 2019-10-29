library(DT)
library(shiny)
library(shinydashboard)
library(tidyr)
library(dplyr)
library(ggplot2)
library(RColorBrewer)
library(plotly)
library(shinyWidgets)
library(tibble)

# library(highcharter)
# library(lubridate)
# library(openxlsx)
# library(officer)
# library(flextable)



# path = "~/NYCDS/Shiny/data"
# path = "./data"
# setwd(path)

df <- read.csv("./data/googleplaystore_Kwak.csv")
df$App <- as.character(df$App)

choice <- colnames(df$App)

# 
# ##################################
# # 1. General Analysis
# ##################################
# # 1.1  Overall analysis
# ##################################
# 
# # (1) Number of Apps

nb.by.categ <- df %>%
  group_by(., Category) %>%
  summarise(., count_1.2.1 = n()) %>%
  arrange(., desc(count_1.2.1))


nb.by.categ_simp <- df %>%
  group_by(., Category.simple.new) %>%
  summarise(., count_1.1.1 = n()) %>%
  arrange(., desc(count_1.1.1))


colors <- c('rgb(114,147,203)', 'rgb(211,94,96)', 'rgb(171,104,87)', 'rgb(128,133,133)', 'rgb(144,103,167)')

nb.by.categ_simp$Category.simple.new <-
  factor(nb.by.categ_simp$Category.simple.new, levels = rev(as.character(nb.by.categ_simp$Category.simple.new)))


# (2) Apps by Payment type
apps.by.pay <- df %>%
  group_by(., Type) %>%
  summarise(., count_1.1.2=n()) %>%
  arrange(., desc(count_1.1.2))


# (3) Paid Apps by Price range
price.range <- df %>%
  group_by(., Price.range.new) %>%
  filter(., Price.range.new != 0) %>%
  summarise(., count_1.1.3=n()) %>%
  arrange(., desc(count_1.1.3))


# (4) Apps by Adroid version
and.ver <- df %>%
  group_by(., Android.Ver.update) %>%
  summarise(., count_1.1.4=n()) %>%
  arrange(., desc(count_1.1.4))


##################################
# 1.2 Apps by Category

# (1) Nb. Of apps by category



# 2) App Payment type by Category
type.by.categ <- df %>%
  group_by(., Category, Type) %>%
  summarise(., count_1.2.2 = n())

sum.by.categ <- type.by.categ %>% group_by(., Category) %>% summarise(., sum=sum(count_1.2.2))
pay.ratio <- left_join(type.by.categ, sum.by.categ, by="Category")
pay.ratio$ratio = pay.ratio$count_1.2.2/pay.ratio$sum
pay.ratio <- pay.ratio %>% filter(., Type=="Paid") %>% select(., Category, sum, ratio)
type.by.categ.pay <- left_join(type.by.categ, pay.ratio, by="Category") %>% arrange(., desc(ratio))
type.by.categ.pay$ratio[is.na(type.by.categ.pay$ratio)] <- 0


#################################################


## valueBox data ##
nb.of.app.total <- nb.by.categ_simp %>% summarise(., total_cnt = sum(count_1.1.1))
nb.of.category <- nb.by.categ %>% summarise(., category_cnt = nrow(nb.by.categ))
nb.of.paid.app <- apps.by.pay %>% summarise(., paid_cnt = 800, total = 10839)
colors <- c('rgb(114,147,203)', 'rgb(211,94,96)', 'rgb(171,104,87)', 'rgb(128,133,133)', 'rgb(144,103,167)')



########## 새로 추가 ###########3
categ_choices <- as.character(unique(nb.by.categ$Category))
rating <- unique(nb.by.categ$Rating)
pay.type <- as.character(unique(df$Type))
installed <- as.character(unique(df$Installs.update))

df.rm.na.rate <- df[df$Rating!="NaN",]
fit <- density(df.rm.na.rate$Rating)
df_rate.over3 <- df %>% filter(., Rating >= 3)


window_height <- JS('window.innerHeight') 
window_width <- JS('window.innerWidth') 


