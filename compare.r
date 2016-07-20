print("*****************************************************************")
print("Running compare.r")
print(paste("Script start time:", Sys.time()))
print("*****************************************************************")

rm(flag)

flag <- data.frame(ACC_ID=integer(0),cluster=integer(0))
n <- 0
print("Comparing records across clusters to find suspicious transactions....")
for(x in 1:(length(kyc_cluster_list_ord)-1))#x=#clusters-1 --2
{
  for(y in 1:length(kyc_cluster_list_ord[[x]]$primaryaccountnumber))#y=#accounts in kyc cluster --4
  {
    for(z in 1:length(tran_cluster_list_agg_ord[[x+1]]$Group.1))#z=#accounts in next tran cluster (agg) --5
    {
      if (kyc_cluster_list_ord[[x]][y,2] == tran_cluster_list_agg_ord[[x+1]][z,1])
      {
        n <- n+1
        #print(paste("Account_id", kyc_cluster_list_ord[[x]][y,2],"from kyc cluster", kyc_cluster_list_ord[[x]][y,46], "is also present in tran cluster", tran_cluster_list_agg_ord[[x+1]][z,4]))
        #print(paste("Account_id", kyc_cluster_list_ord[[x]][y,2], "has transactions outside of his home cluster."))
        print(paste("Account_id", kyc_cluster_list_ord[[x]][y,2],"from kyc cluster", x, "is also present in tran cluster", tran_cluster_list_agg_ord[[x+1]][z,4]))
        flag[n,1] <- tran_cluster_list_agg_ord[[x+1]][z,1]
        flag[n,2] <- tran_cluster_list_agg_ord[[x+1]][z,4]
      }
    }
  }
}

print("Printing flagged records....")
print(flag)


print(paste("Script end time:", Sys.time()))
print("*****************************************************************")