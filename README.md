# This repository contains:

1. Information on R packages for movement, collected between March and August 2018. This information is used for the review (pre-print in <https://arxiv.org/abs/1901.05935>)
2. Scripts to reproduce Figs. 2 to 4 from the review (Fig. 1 is a conceptual graphical representation of the packages)
3. Survey on R packages: data and script (.Rmd file) with the analysis and results

# Road map:

## Data directory:

* RmovementPackagesInformation.csv: csv file with information from 74 R packages related to movement and tracking data processing/analysis. Information was collected between March and August 2018. 59 of the packages were used for an R tracking packages review paper, and 72 of those packages were the focus of a survey on their users about their use, relevant and quality of their documentation. There is a README file with more details on this file in the same directory. The information was collected between March and August 2018.

* Rpackages_survey_responses.csv: csv file with the responses of anonymous participants in a survey about the use, relevant and quality of the documentation of 72 packages related to movement. There is a README file with more details on this file in the same directory. The survey was executed in the Fall of 2018.

* packages_paper.csv: file containing a list of names of the packages used in the review paper.

* packages_survey_names.csv: file containing a list of names of the packages from the survey.

* RmovePackages-Import.csv: For each of the 59 packages from the review, it contains in one column the name of a package and on the second column the package they import, depend on, or link to. Information collected in Aug. 30th 2018.

* RmovePackages-ImportSuggest.csv: For each of the 59 packages from the review, it contains in one column the name of a package and on the second column the package they import, depend on, link to or suggest. Information collected in Aug. 30th 2018.

## Scripts:

* r-survey.Rmd: R markdown document with the description and results of the survey on the R packages.

* r-survey.html: html version of the markdown document

* PackagesYear-Fig2.R: Script to get Fig.2 from the review paper (barplot of the number of packages per year)

* ResultsDoc-Fig3.R: Script to get Fig.3 from the review paper (Number of respondents vs. good/excellent documentation rating for packages with at least 10 respondents)

* PackageNetwork-Fig4.R: Script to get Fig. 4 from the review paper (network representation of import and suggest links between packages)




