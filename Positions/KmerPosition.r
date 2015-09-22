library(ggplot2)

d <- read.table("mmu-roio+200.out")
g <- read.table("mmu-roio+200.ggag")

colnames(d) <- c("miRNA", "gpos", "Kmer", "start", "end")
colnames(g) <- c("miRNA", "gpos", "Kmer", "start", "end")

ggplot(g, aes(x=start, fill=Kmer)) +
    geom_bar() + facet_wrap(~miRNA) +
    theme_bw() +
    theme(panel.grid.major = element <- line(colour = "black"))
ggsave("pos_ggag.pdf")

ggplot(d, aes(x=start, fill=Kmer)) +
    geom_bar() + facet_wrap(~miRNA) +
    guides(fill=FALSE) + theme_bw() +
    theme(panel.grid.major = element_line(colour = "black"))
ggsave("pos_all.pdf")
