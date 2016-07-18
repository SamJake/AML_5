#package install
install.packages("devtools")
packages <- c("devtools","factoextra","cluster","NbClust","ggplot2","sqldf")
#packages <- c("devtools","factoextra","cluster","NbClust","ggplot2","sqldf","RHive")
if(length(setdiff(packages,rownames(installed.packages())))>0)
{
  install.packages(setdiff(packages,rownames(installed.packages())))
}
sapply(packages,library,character.only=TRUE)

#install.packages("devtools", lib="~/R/lib")

# install.packages("factoextra")
# install.packages("cluster")
# install.packages("NbClust")
# install.packages("ggplot2")
# install.packages("sqldf")

# installed.packages()[,1]
