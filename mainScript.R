#Observing the data
getwd()
setwd("/Users/melis/Desktop/R/financialReviewUpdated")
getwd()

#First fin <- read.csv("Future-500.csv")
fin <- read.csv("Future-500.csv", na.strings = c(""))
fin
head(fin, 30)
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
fin$Revenue <- gsub("\\$", "", fin$Revenue)
head(fin)
fin$Revenue <- gsub(",", "", fin$Revenue)
head(fin)
fin$Growth <- gsub("\\%", "", fin$Growth)
fin$Expenses <- as.numeric(fin$Expenses)
fin$Revenue <- as.numeric(fin$Revenue)
fin$Growth <- as.numeric(fin$Growth)
str(fin)
summary(fin)
#dealing with missing data
head(fin, 24)
complete.cases(fin) #function returns FALSE if a row has at least one NA
fin[!complete.cases(fin),] #shows rows with NA

#empty strings don't count as NA in R so we import the dataset as fin <- read.csv("Future-500.csv", na.strings = c(""))

#filtering
fin$Industry == "Software" #logical vector to filter dataset
fin[fin$Industry == "Software", ] #it gives NA results as well
which(fin$Industry == "Software") #it gives row names that contains filtered variable
fin[which(fin$Industry == "Software"),] #it gives dataset which contains filtered variable without NA's



