print("*****************************************************************")
print("Running tran_clustering.r")
print(paste("Script start time:", Sys.time()))
print("*****************************************************************")

set.seed(123)
rm(dist2,clust2,tran_cluster,tran_cluster_list,tran_cluster_means,tran_cluster_list_agg,tran_cluster_list_agg_ord)
#Hierarchial Clustering
dist2 <- dist(tran[8], method="euclidean")
clust2 <- hclust(dist2, method="ward.D2")

print("Plotting tran Clusters")
# plot(clust2)
jpeg("/home/cloudera/Desktop/codes/SAM/images/Tran_Clusters_Hier.jpeg")
plot(clust2, labels=FALSE, hang = -1.5)
rect.hclust(clust2,k=4,border = 2:4)
dev.off()

tran_cluster <- cutree(clust2,k=3)

# jpeg("/home/cloudera/Desktop/codes/SAM/images/Tran_Clusters_Elbow.jpeg")
# fviz_nbclust(tran,hcut,method = "wss") + geom_vline(xintercept = 3, linetype = 2)
# dev.off()

tran.c <- cbind(tran,tran_cluster)
tran_cluster_list <- list()
k <- 3
for(i in 1:k)
{
  tran_cluster_list[[i]] <- subset(tran.c,tran_cluster==i)
}

print("Printing tran sample clusters")
print(paste("Count of records in tran cluster 1:",nrow(tran_cluster_list[[1]])))
print(head(tran_cluster_list[[1]][,1:6]))
print(paste("Count of records in tran cluster 2:",nrow(tran_cluster_list[[2]])))
print(head(tran_cluster_list[[2]][,1:6]))
print(paste("Count of records in tran cluster 3:",nrow(tran_cluster_list[[3]])))
print(head(tran_cluster_list[[3]][,1:6]))


#Aggregation - count & means
tran_cluster_list_agg <- list()
for(m in 1:length(tran_cluster_list)) 
{
  acc <- tran_cluster_list[[m]][,3]
  bal <- tran_cluster_list[[m]][,8]
  c <- tran_cluster_list[[m]][,17]
  temp1 <- aggregate(bal,list(acc),mean)#meansdf
  temp2 <- aggregate(bal,list(acc),length)#countdf
  temp3 <- aggregate(c,list(acc),mean)#nth cluster
  temp4 <- cbind(temp1,temp2,temp3)
  temp4 <- temp4[,-3]
  temp4 <- temp4[,-4]
  tran_cluster_list_agg[[m]] <- temp4
}

print("Printing tran sample clusters, aggregrated based on account_id")
print(paste("Count of records in tran cluster aggregate 1:",nrow(tran_cluster_list_agg[[1]])))
print(tran_cluster_list_agg[[1]])
print(paste("Count of records in tran cluster aggregate 2:",nrow(tran_cluster_list_agg[[2]])))
print(tran_cluster_list_agg[[2]])
print(paste("Count of records in tran cluster aggregate 3:",nrow(tran_cluster_list_agg[[3]])))
print(tran_cluster_list_agg[[3]])


#ll <- as.numeric(tran$transactionId)*as.numeric(tran$fromAccountNo)/12000+tran$amount/622
ll <- as.numeric(tran$fromAccountNo)*as.numeric(tran$transactionId)/9800
rm(g2)
#g2 <- ggplot(tran.c,aes(x=ll,y=tran.c$amount*as.numeric(tran.c$fromAccountNo)/1.75,color=factor(tran.c$tran_cluster),group=tran.c$tran_cluster)) + geom_point(size=.01)
g2 <- ggplot(tran.c,aes(x=ll,y=tran.c$amount,color=factor(tran.c$tran_cluster),group=tran.c$tran_cluster)) + geom_point(size=.05)
g2 <- g2 + ggtitle("Transaction Segmentation") + xlab("Transactions") + ylab("Clustering Parameters") 
g2 <- g2 + scale_x_log10(limits= c(1, 1000000))
g2 <- g2 + scale_y_log10(limits=c(100,100000))
g2 <- g2 + scale_color_manual(values=c("skyblue1","darkolivegreen4","darkorchid2"),name="Transaction Types",label=c("High","Mid","Low"))
g2
ggsave("/home/cloudera/Desktop/codes/SAM/images/Tran_Clusters_kmeans.jpeg")


# rm(g2)
# g2 <- ggplot(tran.c,aes(x=c(1:nrow(tran.c)),y=tran.c$amount,color=factor(tran.c$tran_cluster),group=tran.c$tran_cluster)) + geom_point(size=1)
# g2 <- g2 + ggtitle("AML : Tran Clusters") + xlab("Customers") + ylab("Transactions")
# g2 <- g2 + scale_color_manual(values=c("aquamarine","darkolivegreen1","darkorchid2"),name="Customer Profiling based on transactions")
# g2
# ggsave("/home/cloudera/Desktop/codes/SAM/images/Tran_Clusters_kmeans.jpeg")


print(paste("Script end time:", Sys.time()))
print("*****************************************************************")