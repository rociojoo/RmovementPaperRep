Read Me file for RmovementPackagesInformation.csv

It is a package with information about 74 R packages related to movement and tracking data processing/analysis. Information was collected between March and August 2018.

Columns are:
- Package: name of the package
- Title: as in the Description file of the package.
- Package: as in the Description file of the package.
- Year: year when the package was publicly available for the first time.
- CRAN: Yes if the package is on CRAN.
- Active: Yes if the package had a new version released within the last year or if a commit was performed in the last year.
monthly downloads: using the package 'dlstats' on cran
- Biologging-specific: if the package was created specifically for a certain type of biologging device (which one). See Joo et al. (pre-print) https://arxiv.org/abs/1901.05935 for more information.
- Tracking-data Processing: if the package was created to do a specific type of data-processing or analysis. See Joo et al. (pre-print) https://arxiv.org/abs/1901.05935 for more information.
- Define own-class: Yes if the package defines its own data class(es).
- Data-class: If yes in last column, name main data classes.
- Supporting sp or sf? Those are data classes. Possible values: No, sp, sf, both. (Note: rpostgisLT imports sf but only for visualization functions; for its main purpose, it depends only on sp). 
- Standard manual: Yes if the package offers standard documentation.
- Vignettes: Yes if the package offers vignette(s).
- Papers: Yes if there is a peer-reviewed scientific article published.
- Number of functions: its the number of functions in the package. The list was obtained by taking the highest function count from two methods: Counting function imports in the NAMESPACE file and number of function documentation pages (through library()).
- url: url of the package.
- url2: if there is a second url.
- Contact Person: as in the Description file of the package.
- ContactEmail: as in the Description file of the package, or updated if the contact person provided a new one.
- version: version of the package analyzed.



