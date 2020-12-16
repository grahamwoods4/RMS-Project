#R version 4.0.2 (2020-06-22)
#Platform: x86_64-w64-mingw32/x64 (64-bit)
#Running under: Windows 10 x64 (build 19042)
#stringr_1.4.0 readxl_1.3.1  dplyr_1.0.2

#load libraries
sessionInfo() # tells you the version of packages loaded
library(ggplot2) # ggplot2_3.3.2
library(psych) # psych v2.0.9
library(stringr) # stringr v1.4.0
library(fpp2) # fpp2 v2.4
library(tidyverse) #tidyverse v1.3.0
library(dplyr) #dplyr v1.0.2
library(readxl) #readxl v1.3.1
getRversion()
#R v4.0.3

#import cleaned data set from excel
RMSdata <- read_excel("C:/Users/Drose/iCloudDrive/RMS PROJECT/RMSdata.xlsx")
View(RMSdata)

#fixing dates in the WkStart column to the correct years.
RMSdata$WkStart <- stringr::str_replace(RMSdata$WkStart, '202', '201')

#saving the data to an object called mydata.
mydata1 <- RMSdata

#creating a separate data frame of just one store with a high average imputed sales
Store6145 <- mydata1 %>% filter(Store == 6145)

#creating a separate data frame of just one store with a low average imputed sales
Store103 <- mydata1 %>% filter(Store == 103)

#creating a separate data frame of just one store with an average around the average
Store349 <- mydata1 %>% filter(Store == 349)

#finding the average for each store
storeAVG <- aggregate.data.frame(mydata1[,3:6], list(mydata1$Store), mean)

#plotting a histogram of the average of all stores
ggplot(storeAVG, aes(Sales_Imp))+geom_histogram()

#splitting up our datasets into training and test sets
L <- 54L
train6145 <- head(Store6145, round(length(Store6145)- L))
test6145 <- tail(Store6145,L)

train103 <- head(Store103, round(length(Store103)- L))
test103 <- head(Store103,L)

train349 <- head(Store349, round(length(Store349)- L))
test349 <- head(Store349,L)

#creating histograms for the high, low and average stores
ggplot(Store6145, aes(Sales_Imp))+geom_histogram()

ggplot(Store103, aes(Sales_Imp))+geom_histogram()

ggplot(Store349, aes(Sales_Imp))+geom_histogram()

#creating traffic time series sets for our high, low, and average stores
Traffic6145_TS <- ts(Store6145$Traffic, frequency = 52)
Traffic6145_TS

Traffic103_TS <- ts(Store103$Traffic, frequency = 52)
Traffic103_TS

Traffic349_TS <- ts(Store349$Traffic, frequency = 52)
Traffic349_TS

#plotting our new traffic time series
plot.ts(Traffic6145_TS)
plot.ts(Traffic103_TS)
plot.ts(Traffic349_TS)

#creating and plotting sales time series for our high, low, and average stores
Sales6145_TS <- ts(Store6145$Sales, frequency = 52)
Sales6145_TS

Sales103_TS <- ts(Store103$Sales, frequency = 52)
Sales103_TS

Sales349_TS <- ts(Store349$Sales, frequency = 52)
Sales349_TS

plot.ts(Sales6145_TS)
plot.ts(Sales103_TS)
plot.ts(Sales349_TS)
