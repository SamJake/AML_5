print("*****************************************************************")
print("Running kyc_clustering.r")
print(paste("Script start time:", Sys.time()))
print("*****************************************************************")

set.seed(123)
rm(dist1,clust1,kyc_cluster,kyc_cluster_list,kyc_cluster_means,kyc_cluster_list_ord,kyc.c)
#Hierarchial Clustering
dist1 <- dist(kyc[3], method="euclidean")
clust1 <- hclust(dist1, method="ward.D2")

print("Plotting KYC Clusters")
#plot(clust1)
jpeg("/home/cloudera/Desktop/codes/SAM/images/Kyc_Clusters_Hier.jpeg")
plot(clust1, labels=FALSE, hang = -1)
rect.hclust(clust1, k=3, border = 2:4)
dev.off()

kyc_cluster <- cutree(clust1,k=3)
#print(kyc_cluster)
# jpeg("/home/cloudera/Desktop/codes/SAM/images/Kyc_Clusters_Elbow.jpeg")
# fviz_nbclust(kyc,hcut,method = "wss") + geom_vline(xintercept = 3, linetype = 2)
# dev.off()

kyc.c <- cbind(kyc,kyc_cluster)
############################
# install.packages("lubridate")
# library(lubridate)
# as.Date(kyc$dateofbirth,format="%d-%B-%y")
###############################

rm(g1)
#ll <- as.numeric(kyc$customerid)*as.numeric(kyc$primaryaccountnumber)+as.numeric(kyc$balance)+as.numeric(kyc$dateofbirth)*100
ll <- as.numeric(kyc$customerid)*as.numeric(kyc$primaryaccountnumber)*as.numeric(kyc$dateofbirth)/100

g1 <- ggplot(kyc.c,aes(x=ll,y=kyc.c$balance,color=factor(kyc.c$kyc_cluster),group=kyc.c$kyc_cluster)) + geom_point(size=1.2)
g1 <- g1 + ggtitle("Customer Segmentation") + xlab("Customers") + ylab("Clustering parameters") + scale_x_log10(limits= c(100, 10000000))
g1 <- g1 + scale_color_manual(values=c("orange","green2","skyblue2"),name="Customer Profiles",label=c("Low Profile","High Profile","Mid Profile"))
g1
# g1 <- ggplot(kyc.c,aes(x=c(1:nrow(kyc.c)),y=kyc.c$balance,color=factor(kyc.c$kyc_cluster),group=kyc.c$kyc_cluster)) + geom_point(size=1)
# g1 <- g1 + ggtitle("AML : KYC Clusters") + xlab("Customers") + ylab("Annual Remuneration") 
# g1 <- g1 + scale_color_manual(values=c("aquamarine","darkolivegreen1","darkorchid2"),name="Customer Profiling")
# g1
ggsave("/home/cloudera/Desktop/codes/SAM/images/Kyc_Clusters_kmeans.jpeg")

kyc_cluster_list <- list()
k <- 3
for(i in 1:k)
{
  kyc_cluster_list[[i]] <- subset(kyc.c,kyc_cluster==i)
}
print("Printing KYC sample clusters")
print(paste("Count of records in kyc cluster 1:",nrow(kyc_cluster_list[[1]])))
print(head(kyc_cluster_list[[1]][,1:5]))
print(paste("Count of records in kyc cluster 2:",nrow(kyc_cluster_list[[2]])))
print(head(kyc_cluster_list[[2]][,1:5]))
print(paste("Count of records in kyc cluster 3:",nrow(kyc_cluster_list[[3]])))
print(head(kyc_cluster_list[[3]][,1:5]))

print(paste("Script end time:", Sys.time()))
print("*****************************************************************")
