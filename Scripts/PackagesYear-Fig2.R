# Barplot of packages per year

library(tidyverse)

data_dir <- "./Data/"

# Table with information of all packages from the survey
data <- read_csv(paste0(data_dir,"RmovementPackagesInformation.csv"))
# only keeping columns that we will use
data <- data[,c("Package","Year")]
# Loading the names of packages we include in the review
mov_pac <- read.csv(paste0(data_dir,"packages_paper.csv"),stringsAsFactors = FALSE)
mov_pac[mov_pac == "SGAT/TripEstimation"] <- "SGAT"
mov_pac[mov_pac == "TwGeos/BAStag"] <- "TwGeos"
mov_pac[mov_pac == "ukfsst/kfsst"] <- "ukfsst"

# Subsetting by packages in review
ind.mov.pac <- match(mov_pac$Package,data$Package)
data <- data[ind.mov.pac,]

# counting packages per year
theTable <- as.data.frame(table(data$Year))
colnames(theTable) <- c("Year","Total")

# in case there are some years without publication of packages
theTable$Year <- as.numeric(levels(theTable$Year))
# filter out 2018 which is not complete
theTable <- theTable %>% 
  filter(Year < 2018)
range_year <- range(theTable$Year)
values_year <- range_year[1]:range_year[2]
missing_years <- setdiff(values_year,theTable$Year)

theTable <- rbind.data.frame(cbind.data.frame(Year=missing_years,Total=rep(0,length(missing_years))),theTable)
theTable$Year <- factor(theTable$Year,levels = sort(theTable$Year))


plot_year_counts <- ggplot(theTable, aes(x=Year, y=Total)) +
  geom_bar(stat="identity", position="identity") +
  xlab('Year of publication') + ylab("Number of packages")+ 
  theme_light() + theme(text = element_text(size=24), axis.text.x = element_text(angle=45,hjust = 1), 
                          axis.title.y = element_text(margin = margin(r=10)), 
                        axis.title.x = element_text(margin = margin(t=10))) +
  scale_y_continuous(minor_breaks = seq(0 , 12, 1), breaks = seq(0, 12, 3)) 
# ggsave("packages_per_year.pdf",plot=plot_year_counts, width = 10, height = 10) 
