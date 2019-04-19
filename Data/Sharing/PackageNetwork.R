######### Packages network graph
library(ggplot2)
library(igraph)
library(scales)
library(Matrix)
library(ggplot2)
library(tidyverse)

# Loading the names of packages we include in the review
mov_pac <- read.csv("packages_paper.csv",stringsAsFactors = FALSE)

mov_pac[mov_pac == "SGAT/TripEstimation"] <- "SGAT"
mov_pac[mov_pac == "TwGeos/BAStag"] <- "TwGeos"
mov_pac[mov_pac == "ukfsst/kfsst"] <- "ukfsst"

# loading the import + suggest information for each package
imports <- read.csv("RmovePackages-ImportSuggest-20180830.csv",stringsAsFactors = FALSE)

# getting the names of all packages that participate here as a dependent or dependency (or suggestion)
packages <- unique(c(imports$Package,imports$Dependency))
imports$Dependency[which(imports$Dependency=="-")] <- NA

# accomodating everything as a matrix of counts
packages <- packages[-which(packages=='-')] # excluding packages with neither dependencies or suggestions
pack.id <- 1:length(packages)
table.counts <- as.data.frame.matrix(table(imports$Package,imports$Dependency)) # table of counts with rows as list of packages and columns the packages they depend on/suggest
# but we only want to account for tracking packages. 

# So in the end, we want a matrix of counts which would be square, with rows and columns of tracking packages. 
# Problem? Not all tracking packages are counted as dependencies or suggestions of other packages, so they are not in the columns
# We are going to add the missing ones first (with zeros) and then remove the columns that should not be there

new_col <- setdiff(t(mov_pac),colnames(table.counts))
zero_matrix <- matrix(0,ncol=length(new_col),nrow=dim(table.counts)[1])
row.names(zero_matrix) <- row.names(table.counts)
colnames(zero_matrix) <- new_col
table.counts <- cbind.data.frame(table.counts,zero_matrix)

ind.mov.row <- match(t(mov_pac),row.names(table.counts))
ind.mov.col <- match(t(mov_pac),colnames(table.counts))

table.counts <- table.counts[ind.mov.row,ind.mov.col]
# making sure that the order is right
col.names.df <- colnames(table.counts)
row.names.df <- row.names(table.counts)
table.counts <- table.counts[order(row.names.df,decreasing = FALSE),order(col.names.df,decreasing = FALSE)]

# Table with information of all packages from the survey
data <- read_csv("RmovementPackagesInformation.csv")
# only keeping columns that we will use
data <- data[,c("Package","Active")]

data$Package[data$Package == "SGAT/TripEstimation"] <- "SGAT"
data$Package[data$Package == "TwGeos/BAStag"] <- "TwGeos"
data$Package[data$Package == "ukfsst/kfsst"] <- "ukfsst"

ind.mov.cran <- match(t(mov_pac),data$Package)
data <- data[ind.mov.cran,]

table.mov <- t(table.counts) # transposing for plotting

num_sugg <- apply(table.mov,1,sum) # total number of dep/sugg

g.matrix <- graph.adjacency(t(as.matrix(table.mov)), weighted=TRUE, mode = "directed",diag = FALSE)
g <- simplify(g.matrix)

font_text <- rep(1,nrow(data))
font_text[data$Active == "Yes"] <- 2 # bold for active packages
color_back <- "white" #alpha("snow3",data$downloads/max(data$downloads))

# now, we want to make dashed and more transparent arrows for suggestion but darker and solid arrows for import
el <- as_edgelist(g)
edges_sugg <- data.frame(suggesting=V(g)[el[,1]]$name, 
                         suggested=V(g)[el[,2]]$name,type="suggestion")
edges_sugg$type <- as.character(edges_sugg$type)

imports <- read.csv("RmovePackages-Import-20180830.csv",stringsAsFactors = FALSE) # we need an only import file 
imports <- imports[imports$Package %in% mov_pac$Package,]
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

# General options for plotting. 
V(g)$label.family <- "Helvetica"
V(g)$label <- V(g)$name
V(g)$degree <- degree(g)
layout1 <- layout.fruchterman.reingold(g)
V(g)$label.color <-  "darkblue"
V(g)$label.font <- font_text
V(g)$frame.color <- alpha("black",0.7) 
V(g)$label.cex <- 1.5 
V(g)$color <- color_back 
V(g)$size <- 40 * num_sugg/sum(num_sugg) 
egam <- 3
E(g)$width <- egam*1.5
E(g)$arrow.size <- egam/3
E(g)$lty <- line_type
E(g)$color <- line_color

# pdf('NetworkImportSuggestTrack.pdf',width = 18,height = 16)
plot(g, layout=layout1,vertex.label.dist=0.5)
# dev.off()
