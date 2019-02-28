######### Packages help
library(ggplot2)

# data_help <- read.csv("packages_newlist_20181007_help.csv")[2:6]
# summary(data_help)
# data_help$all <- "No"
# data_help$all[data_help$Standard == "Yes" & data_help$Vignettes == "Yes" & data_help$Others == "Yes"] <- "Yes"
# data_help$all <- as.factor(data_help$all)
# data_help <- data_help[order(data_help$Number_Functions,decreasing = FALSE),]
# data_help <- data.frame(data_help)
# data_help$package <- factor(data_help$package,levels = data_help$package[1:length(data_help$package)])
# 
# 
# # barplot of function counts, with black for std help, blue for vignettes and green for all help
# 
# ind.vignettes <- which(data_help$Standard == "Yes" & data_help$Vignettes=="Yes" & data_help$Others == "No")
# ind.all <- which(data_help$all == "Yes")
# color.vector <- rep("black",nrow(data_help))
# color.vector[ind.vignettes] <- "darkblue"
# color.vector[ind.all] <- "darkgreen"
# 
# DepPlot <- ggplot(data=data_help,aes(x=package,y=Number_Functions)) +
#   geom_bar(stat="identity") + 
#   coord_flip() +
#   theme(axis.text.y = element_text(colour = color.vector))
# ggsave(filename = "Help-Barplot.pdf",plot = DepPlot,height = 14)
# 
# data_help_reduced <-data_help[data_help$Number_Functions >= 20,]
# data_help_reduced$package <- factor(data_help_reduced$package,levels = data_help_reduced$package[1:length(data_help_reduced$package)])
# DepPlot2 <- ggplot(data=data_help_reduced,aes(x=package,y=Number_Functions)) +
#   geom_bar(stat="identity") + 
#   coord_flip() +
#   theme(axis.text.y = element_text(colour = color.vector[data_help$Number_Functions >= 20]))
# ggsave(filename = "Help-Barplot-2.pdf",plot = DepPlot2,height = 6)
# 

# check http://kateto.net/networks-r-igraph
library(igraph)
library(scales)
library(Matrix)
library(ggplot2)
library(tidyverse)
# # library(reshape2)
# # m <- dcast(imports,Package~Dependency,fill=0)[-1]
# imports <- read.csv("RmovePackages-Import-20180830.csv",stringsAsFactors = FALSE)
# 
# # ## filter out 'non tracking packages': 
# # non.tracking <- c("acc","accelerometry","GGIR","nparACT","pawacc",
# #                   "PhysicalActivity","TrackReconstruction",
# #                   "drtracker","pathtrackr","SwimR","trackdem",
# #                   "diveMove")
# # imports <- imports[which(imports$Package %in% non.tracking == FALSE),]
# packages <- unique(c(imports$Package,imports$Dependency))
# 
# imports$Dependency[which(imports$Dependency=="-")] <- NA
# tableau_dep <- sort(table(imports$Dependency),decreasing=FALSE)
# Dep <- tableau_dep[tableau_dep>=5]
# DepDF <- data.frame(pkg=names(Dep),freq=as.numeric(Dep))
# DepDF$pkg <- factor(DepDF$pkg,levels = DepDF$pkg[1:length(DepDF$pkg)])
# 
# Mov.pack <- unique(imports$Package)
# ind.pack <- which(levels(DepDF$pkg) %in% DepDF$pkg[DepDF$pkg %in% Mov.pack])
# color.vector <- rep("black",nrow(DepDF))
# color.vector[ind.pack] <- "darkblue"
# DepPlot <- ggplot(data=DepDF,aes(x=pkg,y=freq)) +
#   geom_bar(stat="identity") + 
#   coord_flip() +
#   theme(axis.text.y = element_text(colour = color.vector))
# ggsave(filename = "Dependency-Barplot.pdf",plot = DepPlot)
# 
# 
# ind.empty <- which(packages=='-')
# if (length(ind.empty)>0){
#   packages <- packages[-which(packages=='-')]
# }
# pack.id <- 1:length(packages)
# # other.table <- as.data.frame(table(imports$Package,imports$Dependency))
# # test <- sparseMatrix(i=other.table$Var1,j=other.table$Var2,x=other.table$Freq)
# 
# # count_table <- imports %>%
# #   spread(key = Package, value = 1)
# # mov.pac <- unique(imports$Package)
# # package.names <- count_table$Dependency
# # ind.mov <- which(!is.na(match(package.names,mov.pac)))
# # ind.mov.no <- which(is.na(match(package.names,mov.pac)))
# # count_table <- count_table[ind.mov,]
# # 
# 
# table.counts <- as.data.frame.matrix(table(imports$Package,imports$Dependency))
# ind.no.mov <- which(!packages%in%row.names(table.counts))
# ind.no.dep <- which(!packages%in%colnames(table.counts))
# zero.matrix.rows <- matrix(0,ncol=dim(table.counts)[2],nrow=length(ind.no.mov))
# row.names(zero.matrix.rows) <- packages[ind.no.mov]
# colnames(zero.matrix.rows) <- colnames(table.counts)
# table.counts.2 <- rbind.data.frame(table.counts,zero.matrix.rows)
# zero.matrix.cols <- matrix(0,ncol=length(ind.no.dep),nrow=dim(table.counts.2)[1])
# row.names(zero.matrix.cols) <- row.names(table.counts.2)
# colnames(zero.matrix.cols) <- packages[ind.no.dep]
# table.counts.3 <- cbind.data.frame(table.counts.2,zero.matrix.cols)
# # making sure that the order is right
# col.names.df <- colnames(table.counts.3)
# row.names.df <- row.names(table.counts.3)
# table.counts.3 <- table.counts.3[order(row.names.df,decreasing = FALSE),order(col.names.df,decreasing = FALSE)]
# rm(table.counts.2,zero.matrix.rows,zero.matrix.cols)
# 
# mov.pac <- unique(imports$Package)
# # 
# 
# ################################
# 
# # Second network: mov packages import
# 
# ind.mov.table <- match(mov.pac,row.names(table.counts.3))
# table.mov <- table.counts.3[ind.mov.table,ind.mov.table]
# 
# # write.csv(table.mov,"mov_imports_table.csv")
# 
# g.matrix <- graph.adjacency(t(as.matrix(table.mov)), weighted=TRUE, mode = "directed",diag = FALSE)
# g <- simplify(g.matrix)
# # package.names <- V(g)$name
# # ind.mov <- which(!is.na(match(package.names,mov.pac)))
# 
# data <- read_csv('PkgYearCharacteristicsCran.csv')
# ind.mov.cran <- match(mov.pac,data$Packages)
# data <- data[ind.mov.cran,]
# # colors_text <- c("#5ab4ac","#d8b365")
# colors_text <- rep("#1b9e77",nrow(data))
# colors_text[data$CRAN == "No"] <- "#7570b3"
# font_text <- rep(1,nrow(data))
# font_text[data$Active == "Yes"] <- 4
# color_back <- "white" #alpha("snow3",data$downloads/max(data$downloads))
# 
# V(g)$label <- V(g)$name
# V(g)$degree <- degree(g)
# layout1 <- layout.fruchterman.reingold(g)
# V(g)$label.color <- colors_text #"purple4" # rgb(0, 0, .2, .8)
# V(g)$label.font <- font_text
# V(g)$frame.color <- alpha("black",0.7) #"#d95f02" #"snow3"
# V(g)$label.cex <- 1.5 # in cases of too many vessels
# # V(g)$label.cex[ind.mov] <- 0.9 # in cases of too many vessels
# V(g)$color <- color_back #alpha("#d95f02",V(g)$degree/ max(V(g)$degree))
# V(g)$size <- 20 * V(g)$degree / max(V(g)$degree)+ .2
# egam <- 3
# E(g)$width <- egam*2
# E(g)$arrow.size <- egam/2
# pdf('NetworkImportTrack.pdf',width = 18,height = 16)
# plot(g, layout=layout1,vertex.label.dist=0.5)
# dev.off()


### Import + Suggest
mov.pac <- read.csv("packages.csv",stringsAsFactors = FALSE,header=FALSE)
mov.pac[mov.pac == "SGAT/TripEstimation"] <- "SGAT"
mov.pac[mov.pac == "TwGeos/BAStag"] <- "TwGeos"
mov.pac[mov.pac == "ukfsst/kfsst"] <- "ukfsst"

imports <- read.csv("RmovePackages-ImportSuggest-20180830.csv",stringsAsFactors = FALSE)
# imports <- imports[which(imports$Package %in% non.tracking == FALSE),]

packages <- unique(c(imports$Package,imports$Dependency))
imports$Dependency[which(imports$Dependency=="-")] <- NA

tableau_dep <- sort(table(imports$Dependency),decreasing=FALSE)
Dep <- tableau_dep[tableau_dep>=5]
DepDF <- data.frame(pkg=names(Dep),freq=as.numeric(Dep))
DepDF$pkg <- factor(DepDF$pkg,levels = DepDF$pkg[1:length(DepDF$pkg)])
# 
# Mov.pack <- unique(imports$Package)
# ind.pack <- which(levels(DepDF$pkg) %in% DepDF$pkg[DepDF$pkg %in% Mov.pack])
# color.vector <- rep("black",nrow(DepDF))
# color.vector[ind.pack] <- "darkblue"
# DepPlot <- ggplot(data=DepDF,aes(x=pkg,y=freq)) +
#   geom_bar(stat="identity") + 
#   coord_flip()+
#   theme(axis.text.y = element_text(colour = color.vector))
# ggsave(filename = "DependencySuggest-Barplot.pdf",plot = DepPlot,width = 6,height=6)

packages <- packages[-which(packages=='-')]
pack.id <- 1:length(packages)
# other.table <- as.data.frame(table(imports$Package,imports$Dependency))
# test <- sparseMatrix(i=other.table$Var1,j=other.table$Var2,x=other.table$Freq)
table.counts <- as.data.frame.matrix(table(imports$Package,imports$Dependency))
ind.no.mov <- which(!packages%in%row.names(table.counts))
ind.no.dep <- which(!packages%in%colnames(table.counts))
zero.matrix.rows <- matrix(0,ncol=dim(table.counts)[2],nrow=length(ind.no.mov))
row.names(zero.matrix.rows) <- packages[ind.no.mov]
colnames(zero.matrix.rows) <- colnames(table.counts)
table.counts.2 <- rbind.data.frame(table.counts,zero.matrix.rows)
zero.matrix.cols <- matrix(0,ncol=length(ind.no.dep),nrow=dim(table.counts.2)[1])
row.names(zero.matrix.cols) <- row.names(table.counts.2)
colnames(zero.matrix.cols) <- packages[ind.no.dep]
table.counts.3 <- cbind.data.frame(table.counts.2,zero.matrix.cols)
# making sure that the order is right
col.names.df <- colnames(table.counts.3)
row.names.df <- row.names(table.counts.3)
table.counts.3 <- table.counts.3[order(row.names.df,decreasing = FALSE),order(col.names.df,decreasing = FALSE)]
rm(table.counts.2,zero.matrix.rows,zero.matrix.cols)

# mov.pac <- unique(imports$Package)


# Second network: mov packages import

ind.mov.table <- match(mov.pac$V1,row.names(table.counts.3))
table.mov <- table.counts.3[ind.mov.table,ind.mov.table]

# write.csv(table.mov,"mov_importsuggest_table.csv")
# 
# g.matrix <- graph.adjacency(t(as.matrix(table.mov)), weighted=TRUE, mode = "directed",diag = FALSE)
# g <- simplify(g.matrix)

data <- read_csv('PkgYearCharacteristicsCran.csv')
ind.mov.cran <- match(mov.pac$V1,data$Packages)
data <- data[ind.mov.cran,]

table.mov <- t(table.mov)

num_sugg <- apply(table.mov,1,sum)

g.matrix <- graph.adjacency(t(as.matrix(table.mov)), weighted=TRUE, mode = "directed",diag = FALSE)
g <- simplify(g.matrix)

colors_text <- rep("#1b9e77",nrow(data))
colors_text[data$Active == "Yes"] <- "#7570b3"
font_text <- rep(1,nrow(data))
font_text[data$Active == "Yes"] <- 2
color_back <- "white" #alpha("snow3",data$downloads/max(data$downloads))

el <- as_edgelist(g)
edges_sugg <- data.frame(suggesting=V(g)[el[,1]]$label, 
                         suggested=V(g)[el[,2]]$label,type="suggestion")
edges_sugg$type <- as.character(edges_sugg$type)
imports <- read.csv("RmovePackages-Import-20180830.csv",stringsAsFactors = FALSE)
imports <- imports[imports$Package %in% mov.pac$V1,]
for (i in 1:nrow(edges_sugg)){
  ind <- (imports$Package %in% as.character(edges_sugg$suggesting[i])) + 
    (imports$Dependency %in% as.character(edges_sugg$suggested[i]))
  if (any(ind == 2))
  { edges_sugg$type[i] <- "dependency"
  }
}

line_type <- rep(2,length(E(g)))
line_type[edges_sugg$type == "dependency"] <- 1
line_color <- rep(alpha("#ef8a62",0.5),length(E(g)))
line_color[edges_sugg$type == "dependency"] <- alpha("#ef8a62",0.8)

# package.names <- V(g)$name
# ind.mov <- which(!is.na(match(package.names,mov.pac)))
V(g)$label.family <- "Helvetica"
V(g)$label <- V(g)$name
V(g)$degree <- degree(g)
layout1 <- layout.fruchterman.reingold(g)
V(g)$label.color <-  "darkblue" #colors_text # "purple4" rgb(0, 0, .2, .8)
V(g)$label.font <- font_text
V(g)$frame.color <- alpha("black",0.7) #"#d95f02" #"snow3"
V(g)$label.cex <- 1.5 # in cases of too many vessels
# V(g)$label.cex[ind.mov] <- 0.9 # in cases of too many vessels
V(g)$color <- color_back #alpha("#d95f02",V(g)$degree/ max(V(g)$degree))
V(g)$size <- 40 * num_sugg/sum(num_sugg) #V(g)$degree / max(V(g)$degree)+ .2
egam <- 3
E(g)$width <- egam*1.5
E(g)$arrow.size <- egam/3
E(g)$lty <- line_type
E(g)$color <- line_color
# 
# V(g)$label.color <- "purple4" # rgb(0, 0, .2, .8)
# V(g)$frame.color <- "snow3"
# V(g)$label.cex <- 1.1 # in cases of too many vessels
# # V(g)$label.cex[ind.mov] <- 0.9 # in cases of too many vessels
# V(g)$color <- alpha("steelblue1",V(g)$degree/ max(V(g)$degree))
# V(g)$size <- 30 * V(g)$degree / max(V(g)$degree)+ .2
# egam <- 2
# E(g)$width <- egam/2
# E(g)$arrow.size <- egam/2
# layout1 <- layout.fruchterman.reingold(g)
pdf('NetworkImportSuggestTrack.pdf',width = 18,height = 16)
plot(g, layout=layout1,vertex.label.dist=0.5)
dev.off()

############

data <- read_csv('PkgYearCharacteristicsCran.csv')
ind.mov.cran <- match(mov.pac$V1,data$Packages)
data <- data[ind.mov.cran,]

theTable <- as.data.frame(table(data$Year))
colnames(theTable) <- c("Year","Total")

plot_year_counts <- ggplot(theTable, aes(x=Year, y=Total)) +
  geom_bar(stat="identity", position="identity") +
  xlab('Year of publication') + ylab("Number of packages")+ 
  theme_classic() + theme(text = element_text(size=24))
ggsave("packages_per_year.pdf",plot=plot_year_counts, width = 10, height = 10)

###########
# 
# colors_text <- rep("#1b9e77",nrow(data))
# colors_text[data$CRAN == "No"] <- "#7570b3"
# font_text <- rep(1,nrow(data))
# font_text[data$Active == "Yes"] <- 4
# color_back <- "white" #alpha("snow3",data$downloads/max(data$downloads))
# 
# # package.names <- V(g)$name
# # ind.mov <- which(!is.na(match(package.names,mov.pac)))
# V(g)$label <- V(g)$name
# V(g)$degree <- degree(g)
# layout1 <- layout.fruchterman.reingold(g)
# V(g)$label.color <- colors_text #"purple4" # rgb(0, 0, .2, .8)
# V(g)$label.font <- font_text
# V(g)$frame.color <- alpha("black",0.7) #"#d95f02" #"snow3"
# V(g)$label.cex <- 1.5 # in cases of too many vessels
# # V(g)$label.cex[ind.mov] <- 0.9 # in cases of too many vessels
# V(g)$color <- color_back #alpha("#d95f02",V(g)$degree/ max(V(g)$degree))
# V(g)$size <- 20 * V(g)$degree / max(V(g)$degree)+ .2
# egam <- 3
# E(g)$width <- egam*2
# E(g)$arrow.size <- egam/2
# # 
# # V(g)$label.color <- "purple4" # rgb(0, 0, .2, .8)
# # V(g)$frame.color <- "snow3"
# # V(g)$label.cex <- 1.1 # in cases of too many vessels
# # # V(g)$label.cex[ind.mov] <- 0.9 # in cases of too many vessels
# # V(g)$color <- alpha("steelblue1",V(g)$degree/ max(V(g)$degree))
# # V(g)$size <- 30 * V(g)$degree / max(V(g)$degree)+ .2
# # egam <- 2
# # E(g)$width <- egam/2
# # E(g)$arrow.size <- egam/2
# # layout1 <- layout.fruchterman.reingold(g)
# pdf('NetworkImportSuggestTrack.pdf',width = 18,height = 16)
# plot(g, layout=layout1,vertex.label.dist=0.5)
# dev.off()
# 
# #############################
# 
# # Venn diagram
# 
# 
# data <- read.csv("RmovementSummary.csv")
# head(data)
# data$biologging <- 1
# data$biologging[data$Biologging.specific == "No"] <- 0
# data$tracking <- 1
# data$tracking[data$Tracking.data.Processing == "no"] <- 0
# 
# data_set <- NULL
# data_set$biologging <- as.character(data$Package[data$biologging == 1])
# data_set$tracking <- as.character(data$Package[data$tracking == 1])
# 
# library(RAM)
# pdf("packages.pdf")
# group.venn(list(biologging=data_set$biologging, tracking=data_set$tracking), label=TRUE,
#            lab.cex=0.75, cex=5, fill=c("#d8b365","#5ab4ac"))
# dev.off()
