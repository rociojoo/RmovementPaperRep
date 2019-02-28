
library(tidyverse)
library(dplyr)
library(reshape)
library(RColorBrewer)
library(kableExtra)
setwd('~/r_programs/RmovementPaperRep/SurveyPosts')
data <- read.csv("survey_responses_20190130.csv",stringsAsFactors = FALSE) 
metadata<-read.csv('../SuppMatt/RmovementPackagesMetadata.csv')
data_all <- data %>% 
  filter(completion == 100)

packages <- read_csv('packages_survey_names.csv')
data_question <- data_all[,grep("q1", colnames(data_all))]
colnames(data_question) <- t(packages)
# I'm dropping trajr that was added in the end and only got 1 response
data_question <- data_question[,-grep("trajr",colnames(data_question))]
packages_new <- packages[-which(packages=="trajr"),]

categories <- c("Never","Rarely","Sometimes","Often")
use_counts <- t(sapply(1:ncol(data_question),function(x){
  data_line <- factor(data_question[,x],levels=categories)
  count_p_use <- as.numeric(table(data_line))
  return(count_p_use)
}))
use_counts<-data.frame(use_counts)
colnames(use_counts) <- categories
rownames(use_counts) <- t(packages_new)
use_counts$package<-row.names(use_counts)
use_counts<-merge(use_counts, metadata, by.x='package',by.y='Package',all.x=T)
use_counts$url<-as.character(use_counts$url)
use_counts$url2<-as.character(use_counts$url2)
use_counts$url_real<-NA
use_counts$link<-NA
for(i in seq_along(use_counts$url)){
  #i<-2
  url_real<-use_counts$url[i]
  if(any(grepl('cran',use_counts[i,c('url','url2')]))) { url_real<-use_counts[,c('url','url2')][i,grepl('cran',use_counts[i,c('url','url2')])]}else
  if(any(grepl('github',use_counts[i,c('url','url2')]))) { url_real<-use_counts[,c('url','url2')][i,grepl('github',use_counts[i,c('url','url2')])]}
  use_counts$url_real[i]<-url_real
  use_counts$link[i]<-paste0('[',use_counts$package[i],'](',url_real,')')
  
  #"<a href='url'>link text</a>"
  
  }
colnames(use_counts)
#use_counts$link<-paste0('[here](www.google.com)')
use_counts$package<-use_counts$link
table_out<-kable(use_counts[,c('package','Never','Rarely','Sometimes','Often')]) %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed", "responsive"))
write(paste0("## Package Use \n ", table_out), 'usage_tbl')
#########3
#PT2
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
use_counts$package<-row.names(use_counts)
use_counts <- use_counts[total_package > 0,]
table_out2<-kable(use_counts[,1:length(categories)])%>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed", "responsive"))
write(table_out2, 'documentation_tbl')
#############
#pt3
data_question <- data_all[,grep("q3", colnames(data_all))]
colnames(data_question) <- t(packages)
# I'm dropping trajr that was added in the end and only got 1 response
data_question <- data_question[,-grep("trajr",colnames(data_question))]
packages_new <- packages[-which(packages=="trajr"),]

categories <- c("Not relevant","Slightly relevant","Important","Essential")
use_counts <- t(sapply(1:ncol(data_question),function(x){
  data_line <- factor(data_question[,x],levels=categories)
  count_p_use <- as.numeric(table(data_line))
  return(count_p_use)
}))
use_counts<-data.frame(use_counts)
colnames(use_counts) <- categories
rownames(use_counts) <- t(packages_new)
total_package <- rowSums(use_counts)
use_counts$package<-row.names(use_counts)
use_counts <- use_counts[total_package > 0,]
table_out3<-kable(use_counts[,1:length(categories)])%>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed", "responsive"))
write(table_out3, 'relevance_tbl')
#############