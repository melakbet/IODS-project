#sysstem("wget https://archive.ics.uci.edu/ml/machine-learning-databases/00320/student.zip")
#system("unzip student.zip")

#Mealk Weldenegodguad
#dd.mm.yyy
#Logestic regression

#setwd()

library(dplyr)


por <- read.table("/home/melak/Open_Data/IODS-project/data/student-por.csv", sep = ";" , header=TRUE)

math <-read.table("/home/melak/Open_Data/IODS-project/data/student-mat.csv", sep = ";" , header=TRUE)

str(por)
str(math)
summary(por)
summary(math)

dim(por)
dim(math)


join_by <- c("school", "sex", "age", "address", "famsize", "Pstatus", "Medu", "Fedu", "Mjob", "Fjob", "reason", "nursery","internet")
#join_by <- c("school", "sex", "age", "address", "famsize", "Pstatus", "Medu", "Fedu", "Mjob", "Fjob", "reason", "nursery", "internet")


math_por <- inner_join(math, por, by = join_by, suffix = c(".math", ".por"))


#Keeping only the students present in both data sets. 

alc <- select(math_por, one_of(join_by))

str(alc)
dim(alc)
summary(alc)


# the columns in the datasets which were not used for joining the data
notjoined_columns <- colnames(math)[!colnames(math) %in% join_by]


# for every column name not used for joining...
for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(math_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]

  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- two_columns[1]
  }
}


# define a new column alc_use by combining weekday and weekend alcohol use
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)


# define a new logical column 'high_use'
alc <- mutate(alc, high_use = alc_use > 2)


glimpse(alc)
dim(alc)

write.table(alc,"/home/melak/Open_Data/IODS-project/data/modified_data.txt", sep="\t")

