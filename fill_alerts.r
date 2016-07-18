#alerts <- data.frame(transactionId=numeric(0),fromAccountNo=numeric(0),amount=numeric(0),status=character(0))
alerts <- data.frame(internal_id=integer(0),alert_date=character(0),alert_time=character(0),alert_type=character(0),status_id=character(0),
                     details=character(0),user_id=integer(0),alert_score=integer(0),transactionid=integer(0),customerid=integer(0),customeraccountid=integer(0))

alerts$alert_date <- as.character(alerts$alert_date)
alerts$alert_time <- as.character(alerts$alert_time)
alerts$alert_type <- as.character(alerts$alert_type)
alerts$details <- as.character(alerts$details)
alerts$status_id <- as.character(alerts$status_id)

print(nrow(flag))
if (nrow(flag)>0)
{
  k <- 1
  for(i in 1:nrow(flag))
  {
    acc <- flag[i,1]
    clust <- flag[i,2]
    temp.clust <- tran_cluster_list[[clust]]
    temp.flag <- subset(temp.clust,fromAccountNo==acc)
    for (n in 1:nrow(temp.flag))
    {
      alerts[k,1] <- k + 20000
      #print(temp.flag[n,10])
      #print(temp.flag[n,9])
      alerts[k,2] <- as.character(format(as.Date(as.character(temp.flag[n,10]),format='%d-%b-%y'),'%d-%b-%y'))
      #alerts[k,2] <- as.character(format(as.Date((temp.flag[n,10])),'%d-%b-%y'))
      #alerts[k,2]
      alerts[k,3] <- as.character(format(strptime(as.character(temp.flag[n,9]),format='%H:%M:%S'),'%I:%M %p'))
      #alerts[k,3] <- as.character(format(strptime((temp.flag[n,9]),format='%H:%M:%S'),'%I:%M %p'))
      
      alerts[k,4] <- "SUS_EFT"
      alerts[k,5] <- 1
      alerts[k,6] <- "Suspisious Excessive Fund Transfer Activity"
      alerts[k,7] <- 101 + n%%4
      alerts[k,8] <- 90
      alerts[k,9] <- temp.flag[n,1]
      alerts[k,10] <- temp.flag[n,2]
      alerts[k,11] <- temp.flag[n,3]
      k <- k+1
    }
  }
}

print(head(alerts))
setwd("/home/cloudera/output_R")

write.table(lapply(alerts, as.character), "Alerts_Demo.csv", sep=",", row.names = FALSE, quote = FALSE)


# Write to Hive
#system("hadoop fs -rm /user/aml_project/data/alerts/aler*")
#system("hadoop fs -rm /user/aml_project/alerts_144-Jul-2016.csv")
system("hadoop fs -put Alerts_Demo.csv /user/aml_project/data/alerts/")


