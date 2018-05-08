#Observing the data
getwd()
setwd("/Users/melis/Desktop/R")
getwd()

fin <- read.csv("Future-500.csv")
fin
head(fin)
tail(fin)
summary(fin)
str(fin)
#Changing from non-factor to factor
fin$ID <- factor(fin$ID) #to keep id as integer is pointless
summary(fin)
str(fin)

fin$Inception <- factor(fin$Inception)
summary(fin)
str(fin)

#Factor Variable Trap 
a <- c("12","13","14", "12", "12")
a
typeof(a)