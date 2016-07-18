rm(dt)
rm(query1,query2,query,tran,tran_all)
rm(q)
setwd("/home/cloudera/output_R")
dt <- read.csv("/home/cloudera/output_R/date.csv")
dt <- dt[1,1]
stat <- "Cancelled"
if(dt == "ALL")
{
  query <- paste0("select * from file where status != '", stat,"'")
  print(query)
}else
{
  query <- paste0("select * from file where date = '",dt,"' and status != '", stat,"'")
  print(query)
}

#system("hadoop fs -get /user/aml_project/data/transaction/transactionDetailsFinal_A.csv .")
tran_all <- read.csv("/home/cloudera/Desktop/AML/transactionDetailsDemoFinal2.csv")
tran <- subset(tran_all,status!="Cancelled")

#tran$date <- as.Date(tran$date,format="%d-%B-%y")


print(nrow(tran))
print(head(tran)[,1:5])
print(tail(tran)[,1:5])





# Sys.setenv(HIVE_HOME='/usr/lib/hive')
# Sys.setenv(HADOOP_HOME='/usr/lib/hadoop')
# setwd("/home/cloudera/output_R")
# library(RHive)


# dt <- read.csv("/home/cloudera/output_R/date.csv")
# dt <- dt[1,1]
# print(dt)
# stat <- "Cancelled"
# if(dt == "ALL")
# {
#   query1 <- paste0(" where status != '", stat,"'")
#   print(query1)
# }else
# {
#   query1 <- paste0(" where date = '",dt,"' and status != '", stat,"'")
#   print(query1)
# }

# query2 <- "select 
# transactionid,
# fromcustomerid,
# fromaccountno,
# tocustomerid,
# toaccountno,
# transactionsource,
# debitcreditindicator,
# amount,
# timeoftransaction,
# date,
# status,
# chequeid,
# wireid,
# onlineid,
# branchcode,
# description
# from syne_aml.aml_transaction"
# 
# q <- paste(query2,query1)
# print(q)
# 
# rm(tran)
# # Initialize Hive connection
# rhive.init()
# rhive.connect()
# 
# tran = rhive.query(query = q)
# 
# rhive.close()
# #tran$date <- as.Date(tran$date,format="%d-%B-%y")
