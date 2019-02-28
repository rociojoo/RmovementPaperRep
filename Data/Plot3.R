#
# Changing colors on Rating versus package use graph

knitr::opts_chunk$set(echo = TRUE,fig.width=16, fig.height=10)
library(tidyverse)
library(ggplot2)
library(ggrepel)
library(RColorBrewer)
setwd('/home/matt/Dropbox/mablab/Rocio/MovementReview')
matrix_all <- read.csv("Survey_Processed.csv")
names(matrix_all) <- c("package",names(matrix_all)[2:ncol(matrix_all)])
funciones <- read.csv("packages_newlist_20180830_help.csv")


matrix_fun <- left_join(matrix_all,funciones)
matrix_fun <- matrix_fun[!is.na(matrix_fun$Number_Functions),]

matrix_fun$documentation <- c("Manual")
matrix_fun$documentation[matrix_fun$Vignettes == "Yes" & matrix_fun$Others == "No"] <- c("Manual+Vignette")
matrix_fun$documentation[matrix_fun$Vignettes == "Yes" & matrix_fun$Others == "Yes"] <- c("Manual+Vignette+Extra")

# discarding the packages we did not get users from:
matrix_fun_2 <- matrix_fun[matrix_fun$Use_Counts > 0,] # missing: "feedR"            "GGIR"             "nparACT"          "PhysicalActivity" "smam"            
matrix_fun_3 <- matrix_fun[matrix_fun$Use_Counts >= 10,] 
theme1<-function() {theme(text = element_text(size=20),axis.text.x = element_text(angle=0, hjust=0),legend.position = "none")}

### Rating vs Package Use


color.pallete<-brewer.pal(3,'Dark2')
COL2 <- col2rgb(color.pallete)
COL2 <- COL2/1.25  # you can use of course other values than 2. Higher values the darker the output.
color.pallete <- rgb(t(COL2), maxColorValue=255)

plot1<-ggplot(matrix_fun_2,aes(x=Use_Counts, y=Good_Exc, col=documentation)) + 
  geom_point(size=3) +
  geom_text_repel(label=matrix_fun_2$package,segment.size=1,force=1,segment.alpha=.4,hjust=0,box.padding=0.4,min.segment.length=.25,size=4) + 
  xlab('Package Use Count') + ylab("Good or Excellent Rating")+ 
  theme_classic() + theme1()+ 
  scale_colour_manual(values=color.pallete)
plot1
ggsave('Rating_V_Use1.png',plot=plot1, width=14, height=8,units='in')
