#Observing the data
getwd()
setwd("/Users/melis/Desktop/R/financialReviewUpdated")
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
summary(fin) 

#characters to numerics
a <- c("12","13","14", "12", "12")
a
typeof(a)
b <- as.numeric(a)
typeof(b)
b
#numerics to factor - factor is used to categorized vectors
m <- factor(a)
m
z  <- as.numeric(m) #converting factors to numerics. It shows categories as numerics so we have 3 categories and 3 numbers.
z #if you want to get categories names then don't convert factors to numbers like we did in this example.,

#Converting fin dataset to the right type of variables.
#sub() gsub()
fin$Expenses <- gsub(" Dollars", "", fin$Expenses)
fin$Expenses <- gsub(",", "", fin$Expenses)
head(fin)
