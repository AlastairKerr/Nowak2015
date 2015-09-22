library(ggplot2)

#read table
k <- read.table("kmer-plot.tsv")

#add column names 
colnames(k) <- c("Kmer", "ROI1", "All1", "ROI2", "All2", "RND")

#create a regression model
r <- glm(k$ROI1~ k$All1)

#save residuals to data frame
k$rs <- resid(r)

#plot data
# change scale_colour_gradient2 to change colours
# you can use scale_colour_gradient instead if needed
ggplot(k, aes(x=ROI1, y=All1, colour=rs)) +geom_point() +
    ylim(0,0.45) +xlim(0,0.45) +
    scale_colour_gradient2(mid ="darkgrey", low="darkblue", high="darkred") +
    geom_smooth(method=lm)

ggsave("kmerplot.svg")
ggsave("kmerplot.png")
