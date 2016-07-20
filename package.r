print("*****************************************************************")
print("Running package.r")
print(paste("Script start time:", Sys.time()))
print("*****************************************************************")

#package install
# install.packages("devtools")
# packages <- c("devtools","factoextra","cluster","NbClust","ggplot2","sqldf")
# #packages <- c("devtools","factoextra","cluster","NbClust","ggplot2","sqldf","RHive")
# if(length(setdiff(packages,rownames(installed.packages())))>0)
# {
#   install.packages(setdiff(packages,rownames(installed.packages())))
# }
# sapply(packages,library,character.only=TRUE)

#install.packages("devtools", lib="~/R/lib")

# install.packages("factoextra")
# install.packages("cluster")
# install.packages("NbClust")
# install.packages("ggplot2")
# install.packages("sqldf")


library("devtools")
library("factoextra")
library("cluster")
library("NbClust")
library("ggplot2")
library("sqldf")

# installed.packages()[,1]
print(paste("Script end time:", Sys.time()))
print("*****************************************************************")