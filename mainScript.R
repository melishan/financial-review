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

#filtering: using is.na() for missing data
is.na(fin$Expenses)

#removing records with missing data
fin_backup <- fin 

fin[!complete.cases(fin),]
fin[is.na(fin$Industry),]
fin[!is.na(fin$Industry),] #opposite
fin <- fin[!is.na(fin$Industry),]
fin

#resetting the dataframe index
rownames(fin) <- 1:nrow(fin)

rownames(fin) <- NULL
fin
#Factual Data Analysis
fin[!complete.cases(fin),]
fin[is.na(fin$State),]
fin[is.na(fin$State) & fin$City == "New York",]
fin[is.na(fin$State) & fin$City == "New York","State"] <- "NY"
#check
fin[c(11,377),]
fin[is.na(fin$State) & fin$City =="San Francisco",]
fin[is.na(fin$State) & fin$City =="San Francisco","State"] <- "CA"
#check again
fin[c(82,265),]

#Replacing Missing Data: Median Imputation Method
fin[!complete.cases(fin),]
med_emp_ret <- median(fin[fin$Industry=="Retail","Employees"], na.rm = TRUE)
mean(fin[,"Employees"], na.rm = TRUE)
mean(fin[fin$Industry=="Retail","Employees"], na.rm = TRUE)
med_emp_ret
fin[is.na(fin$Employees) & fin$Industry =="Retail","Employees"] <- med_emp_ret
median(fin[fin$Industry=="Retail","Employees"])
#check
fin[c(3),]
#Replacing Missing Data: Median Imputation Method - Employees
fin[!complete.cases(fin),]
mean(fin[,"Employees"], na.rm =TRUE)
median(fin[,"Employees"], na.rm =TRUE)
mean(fin[fin$Industry =="Financial Services","Employees"], na.rm =TRUE)
median(fin[fin$Industry =="Financial Services","Employees"], na.rm =TRUE)
med_emp_fin <- median(fin[fin$Industry == "Financial Services","Employees"], na.rm =TRUE)
fin[is.na(fin$Employees) & fin$Industry == "Financial Services","Employees"] <- med_emp_fin
#check
fin[330,]

#Replacing Missing Data: Median Imputation Method - Growth
fin[!complete.cases(fin),]
mean(fin[,"Growth"], na.rm = TRUE)
median(fin[,"Growth"], na.rm = TRUE)
mean(fin[fin$Industry== "Construction","Growth"], na.rm = TRUE)
median(fin[fin$Industry== "Construction","Growth"], na.rm = TRUE)
med_growth_cons <- median(fin[fin$Industry== "Construction","Growth"], na.rm = TRUE)
med_growth_cons
fin[is.na(fin$Growth) & fin$Industry =="Construction", "Growth"] <- med_growth_cons
#check
fin[8,]

fin[!complete.cases(fin),]

#Replacing Missing Data - Revenue
median(fin[,"Revenue"], na.rm = TRUE)
mean(fin[fin$Industry =="Construction","Revenue"], na.rm = TRUE)
med_rev_cons <- median(fin[fin$Industry =="Construction","Revenue"], na.rm = TRUE)
fin[is.na(fin$Revenue) & fin$Industry =="Construction", "Revenue"] <- med_rev_cons
#check
fin[c(8,42),]

#Replacing Missing Data - Expenses
median(fin[,"Expenses"], na.rm = TRUE)
mean(fin[,"Expenses"], na.rm = TRUE)
median(fin[fin$Industry=="Construction","Expenses"], na.rm = TRUE)
mean(fin[fin$Industry=="Construction","Expenses"], na.rm = TRUE)
med_exp_cons <- median(fin[fin$Industry=="Construction","Expenses"], na.rm = TRUE)
fin[is.na(fin$Expenses) & fin$Industry == "Construction","Expenses"] <- med_exp_cons
#check
fin[c(8,42),]
fin[!complete.cases(fin),]
#To prevent to overwrite data which has value in particular column
#add a filter
#in this case IT Services has NA in Expenses however it is already a calculated variable 
#which we know revenue and profit parameters
fin[is.na(fin$Expenses) & fin$Industry == "Construction" & is.na(fin$Profit),]

#Replacing Missing Data - deriving values
fin[is.na(fin$Profit),"Profit"] <- fin[is.na(fin$Profit),"Revenue"] - fin[is.na(fin$Profit),"Expenses"]
#check
fin[c(8,42),]

fin[!complete.cases(fin),]

fin[is.na(fin$Expenses), "Expenses"] <- fin[is.na(fin$Expenses), "Revenue"] - fin[is.na(fin$Expenses), "Profit"]
fin[15,]

#Visualization
install.packages("ggplot2")
library(ggplot2)

#Scatterplot 1
p <- ggplot(data=fin)
p
p + geom_point(aes(x=Revenue, y=Expenses, colour=Industry, size=Profit))

#Scatterplot 2
fancy_plot <- ggplot(data=fin, aes(x=Revenue, y= Expenses,
                                              colour=Industry))
fancy_plot + geom_point() +
              geom_smooth(fill=NA, size=2)
#Boxplot
fancy_bplot <- ggplot(data=fin, aes(x=Industry, y=Growth, 
                                    colour=Industry))
fancy_bplot + geom_boxplot()

#Boxplot 2
fancy_bplot + geom_jitter() +
              geom_boxplot(size=0.5, alpha=0.5, 
                           outlier.color = NA)
