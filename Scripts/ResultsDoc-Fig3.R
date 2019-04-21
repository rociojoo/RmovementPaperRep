library(tidyverse)
library(ggplot2)
library(ggrepel)
library(dplyr)
library(reshape)
library(RColorBrewer)

data_dir <- "./Data/"

# loading the data from the survey and filter only surveys that were complete
data <- read.csv(paste0(data_dir,"Rpackages_survey_responses.csv"),stringsAsFactors = FALSE) 
data_all <- data %>% 
  filter(completion == 100)

# standardizing names for packages
packages <- read_csv(paste0(data_dir,'packages_survey_names.csv'))

# question 1
data_question_1 <- data_all[,grep("q1", colnames(data_all))]
colnames(data_question_1) <- t(packages)

# I'm dropping trajr that was added in the end and only got 1 response
data_question_1 <- data_question_1[,-grep("trajr",colnames(data_question_1))]
packages_new <- packages[-which(packages=="trajr"),]

# only considering completed surveys
Total <- sapply(1:dim(data_question_1)[1],function(x){
  sum(as.numeric(data_question_1[x,]!="Never"))
})
discard_rows <- which(Total == 0)
data_all <- data_all[-discard_rows,]

# question about documentation
data_question <- data_all[,grep("q2", colnames(data_all))]
colnames(data_question) <- t(packages)
# I'm dropping trajr that was added in the end and only got 1 response
data_question <- data_question[,-grep("trajr",colnames(data_question))]
packages_new <- packages[-which(packages=="trajr"),]

categories <- c("Not enough","Basic","Good","Excellent", "Don't remember")
use_counts <- t(sapply(1:ncol(data_question),function(x){
  data_line <- factor(data_question[,x],levels=categories)
  count_p_use <- as.numeric(table(data_line))
  return(count_p_use)
}))
use_counts<-data.frame(use_counts)
colnames(use_counts) <- categories
rownames(use_counts) <- t(packages_new)
total_package <- rowSums(use_counts)
use_counts$Package<-row.names(use_counts)
use_counts <- use_counts[total_package > 0,]

# Table with information of all packages from the survey
funciones <- read.csv(paste0(data_dir,"RmovementPackagesInformation.csv"))
# only keeping columns that we will use
funciones <- funciones[,c("Package","Standard.manual","Vignettes","Papers")]

matrix_fun <- left_join(use_counts,funciones)

# not all of the packages from the survey are included in the review
packages_paper <- read.csv(paste0(data_dir,"packages_paper.csv"))
matrix_fun <- inner_join(packages_paper,matrix_fun)

# clarifying documentation options
matrix_fun$documentation <- c("Manual")
matrix_fun$documentation[matrix_fun$Vignettes == "Yes" & matrix_fun$Papers == "No"] <- c("Manual+Vignette")
matrix_fun$documentation[matrix_fun$Vignettes == "Yes" & matrix_fun$Papers == "Yes"] <- c("Manual+Vignette+Paper")

matrix_fun$num_answers <- rowSums(matrix_fun[2:5])
matrix_fun$Good_Exc <- (rowSums(matrix_fun[4:5]))/matrix_fun$num_answers*100

# discarding the packages we did not get users from:
matrix_fun_2 <- matrix_fun[matrix_fun$num_answers > 0,] # missing: "feedR" "smam"            
matrix_fun_3 <- matrix_fun[matrix_fun$num_answers >= 10,] 
theme1<-function() {theme(text = element_text(size=20),axis.text.x = element_text(angle=0, hjust=0),legend.position = "none")}


### Rating vs Package Use
# Create a custom palette thats darker so its better for print quality
color.pallete<-brewer.pal(3,'Dark2')
COL2 <- col2rgb(color.pallete)
COL2 <- COL2/1.25  # you can use of course other values than 2. Higher values the darker the output.
color.pallete <- rgb(t(COL2), maxColorValue=255)

plot1<-ggplot(matrix_fun_3,aes(x=num_answers, y=Good_Exc, col=documentation)) + 
  geom_point(size=3) +
  geom_text_repel(label=matrix_fun_3$Package,segment.size=1,force=1,segment.alpha=.4,hjust=0,box.padding=0.4,min.segment.length=.25,size=6) + 
  xlab('Number of respondents') + ylab("Good or Excellent Rating")+ 
  theme_classic() + theme1()+ 
  scale_colour_manual(values=color.pallete)
plot1
# ggsave('Rating_V_Use1.png',plot=plot1, width=14, height=8,units='in')

