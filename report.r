# write.csv(alerts,"E:/R/AML_4/Outputs/alerts.csv")
# write.csv(kyc_cluster_list[[3]],"E:/R/AML_4/Outputs/kyc_cluster3.csv")
# write.csv(kyc_cluster_list[[2]],"E:/R/AML_4/Outputs/kyc_cluster2.csv")
# write.csv(kyc_cluster_list[[1]],"E:/R/AML_4/Outputs/kyc_cluster1.csv")
# write.csv(tran_cluster_list[[3]],"E:/R/AML_4/Outputs/tran_cluster3.csv")
# write.csv(tran_cluster_list[[2]],"E:/R/AML_4/Outputs/tran_cluster2.csv")
# write.csv(tran_cluster_list[[1]],"E:/R/AML_4/Outputs/tran_cluster1.csv")

system("hadoop fs -rm /user/aml_project/SAM/output/aler*")
system("hadoop fs -rm /user/aml_project/SAM/output/*cluster*")
write.table(lapply(alerts, as.character), 'alerts.csv', sep=",", row.names = FALSE, quote = FALSE)
system("hadoop fs -put alerts.csv /user/aml_project/SAM/output/")

write.table(lapply(kyc_cluster_list[[3]], as.character), 'kyc_cluster3.csv', sep=",", row.names = FALSE, quote = FALSE)
system("hadoop fs -put kyc_cluster3.csv /user/aml_project/SAM/output/")

write.table(lapply(kyc_cluster_list[[2]], as.character), 'kyc_cluster2.csv', sep=",", row.names = FALSE, quote = FALSE)
system("hadoop fs -put kyc_cluster2.csv /user/aml_project/SAM/output/")

write.table(lapply(kyc_cluster_list[[1]], as.character), 'kyc_cluster1.csv', sep=",", row.names = FALSE, quote = FALSE)
system("hadoop fs -put kyc_cluster1.csv /user/aml_project/SAM/output/")

write.table(lapply(tran_cluster_list[[3]], as.character), 'tran_cluster3.csv', sep=",", row.names = FALSE, quote = FALSE)
system("hadoop fs -put tran_cluster3.csv /user/aml_project/SAM/output/")

write.table(lapply(tran_cluster_list[[2]], as.character), 'tran_cluster2.csv', sep=",", row.names = FALSE, quote = FALSE)
system("hadoop fs -put tran_cluster2.csv /user/aml_project/SAM/output/")

write.table(lapply(tran_cluster_list[[1]], as.character), 'tran_cluster1.csv', sep=",", row.names = FALSE, quote = FALSE)
system("hadoop fs -put tran_cluster1.csv /user/aml_project/SAM/output/")