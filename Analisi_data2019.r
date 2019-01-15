#studio tumor burden
setwd("~/Desktop/LAVORO_CRO/2019/TCGA/LIHC/")
library(ggplot2)


tumor_LIH_maf=read.table("pippo.csv",sep="\t",header=T)
tumor_LIH_maf$total = as.numeric(as.character(tumor_LIH_maf$total))
tumor_load_maftols=data.frame(Name=tumor_LIH_maf$Tumor_Sample_Barcode, TMB=tumor_LIH_maf$total/50,TMB_LOG=log10(tumor_LIH_maf$total/50),cohort=tumor_LIH_maf$cohort)


#tumor_load_maftols.med = tumor_LIH_maf[,.(.N, median(total)),cohort][order(V2, decreasing = TRUE)]
pt_all<-tumor_load_maftols[order(tumor_load_maftols$TMB,decreasing = T),]

tcga.cohort.gg = ggplot(data = pt_all, aes(x = cohort, y = TMB, group = Name))+
  geom_point(position = position_jitter(width = 0.3), size = 0.2, alpha = 0.8)+ theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1, face = "bold"), legend.position = 'none', axis.text.y = element_text(face="bold", size = 10), axis.title.y = element_text(face="bold", size = 12))
tcga.cohort.gg + scale_y_log10(breaks = c(0.01, 0.1, 1, 10, 100, 1000, 10000))+
  ylab('log10 (Mutations per sample)')


pt_all_log<-tumor_load_maftols[order(tumor_load_maftols$TMB_LOG,decreasing = T),]


tcga.cohort.gg = ggplot(data = pt_all_log, aes(x = cohort, y = TMB_LOG, group = Name))+
  geom_point(position = position_jitter(width = 0.3), size = 0.2, alpha = 0.8)+ theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1, face = "bold"), legend.position = 'none', axis.text.y = element_text(face="bold", size = 10), axis.title.y = element_text(face="bold", size = 12))
tcga.cohort.gg 
