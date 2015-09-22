library(ggplot2)

#read table
k <- read.table("kmer-plot.tsv")

#add column names 
colnames(k) <- c("Kmer", "ROI1", "All1", "ROI2", "All2", "RND")

#plot
ggplot(k, aes(x=ROI1, y=RND)) +geom_point() +
    ylim(0,0.45) +xlim(0,0.45) #

ggsave("rnd-ROI-kmerplot.svg")
ggsave("rnd-ROI-kmerplot.png")

#plot
ggplot(k, aes(x=All1, y=RND)) +geom_point() +
    ylim(0,0.45) +xlim(0,0.45) #

ggsave("rnd-All1-kmerplot.svg")
ggsave("rnd-All1-kmerplot.png")


