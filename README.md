# About

This repository contains the code for the annual Scottish Government "Poverty an Income Inequality in Scotland" report, the "Persistent Poverty in Scotland" report, a child poverty summary and the accompanying reference tables. It produces a folder website/\_site with all files for the website (including downloadable spreadsheets) hosted on data.gov.scot/poverty.

Running this project requires access to restricted Scottish Government datasets, which is only available to a small number of individuals who are responsible for producing the annual poverty reports. However, we hope that the code may still be useful.

# Workflow

### 0. Files missing in github

The following R files are missing from the github repository, because they contain absolute path names, which are potentially sensitive.

* R/01_importSASfiles.R
* R/01_importpersistentpovertydata.R
* R/09_backup.R

### 1. Import data and prepare datasets

* Ensure the inflation_index file in the SOCJUST SAS library is up to date (DWP provide latest CPIH inflators)
* In R/00_strings.R, add latest year and period values to labels\[\["years"]].
* Run all [Data prep](#dataprep) scripts.
* Make sure 02_clean...data.R and 03_maketidydatasets.R scripts return no errors. 

Tidy datasets are now available in the data folder to produce reports and spreadsheets.

### 2. Create everything

* Run 08_create_website.R to create all spreadsheets and the website. Alternatively, all scripts from R/04_... to R_07_... can also be run individually.
* Look at (local version of) website: website/\_site/index.html
* Check and update all commentary in:

  * website/index.Rmd
  * website/\_poverty_chapters/...
  * website/persistent.Rmd
  * website/\_persistent_chapters/...
  * website/cpupdate.Rmd
  * website/download.Rmd
  * website/accessibility.Rmd
  * website/uncertainty.Rmd
  * website/contact.Rmd

  Most of the figures in the commentary are automatically produced; however, the text is not.

* Run last line of R/08_create_website.R again, inspect website, make required changes to the commentary in the .Rmd files, and repeat until happy

# List of scripts

### Helpers

* R/00_colours.R (colour palettes)
* R/00_functions.R
* R/00_functions_rmd.R (functions required to run Rmd files)
* R/00_strings.R (list of formatted years and periods, categories, etc.)

### Data prep<a name="dataprep"></a>

* R/01_importSASfiles.R - takes a very long time to run, maybe do at night; script not included on GitHub
* R/01_importpersistentpovertydata.R - requires persistent poverty data being supplied in the typical format; script not included on GitHub
* R/02_cleanadultdata.R
* R/02_cleanbenefitsdata.R
* R/02_cleanchilddata.R
* R/02_cleanhbaidata.R
* R/02_cleanhouseholdata.R
* R/03_maketidydatasets.R - combines various HBAI and FRS datasets into two tidy datasets: one adult-level and one benefit unit-level

### Create spreadsheets

* R/04_xlsx_1yr_part1.R - single year data
* R/04_xlsx_1yr_part2.R
* R/04_xlsx_3yrs_part1.R - three-year averaged data
* R/04_xlsx_3yrs_part2.R
* R/04_xlsx_3yrs_part3.R
* R/04_xlsx_3yrs_part4.R
* R/04_xlsx_3yrs_UK.R - UK comparisons for briefing (not included as not required for website)
* R/05_xlsx_run_all.R - runs all xlsx (R/04_...) scripts and copies spreadsheets (for publication) into website folder

Spreadsheets are saved in output folder

### Create charts and tables included in reports

* R/06_prepcharts_cpupdate.R
* R/06_prepcharts_poverty.R
* R/07_maketables_persistentpoverty.R
* R/07_makecharts_persistentpoverty.R
* R/07_maketables_poverty.R
* R/07_makecharts_cpupdate.R
* R/07_makecharts_poverty.R
* R/07_maketables_uncertainty.R

### Create website

* R/08_create_website.R - runs spreadsheets, charts and tables and then creates complete website in website/\_site

### Backup

* R/09_backup.R (not included) - backs up all R, Rmd, CSS files to restricted datashare folder

# List of files in website folder

### Rmd files

These will be compiled into seven html pages.

* index.Rmd
* \_poverty_chapters/\_chapter01.Rmd
* \_poverty_chapters/\_chapter02.Rmd
* \_poverty_chapters/\_chapter03.Rmd
* \_poverty_chapters/\_chapter04.Rmd
* \_poverty_chapters/\_chapter05.Rmd
* \_poverty_chapters/\_chapter06.Rmd
* \_poverty_chapters/\_chapter07.Rmd
* \_poverty_chapters/\_chapter08.Rmd
* \_poverty_chapters/\_chapter09.Rmd
* \_poverty_chapters/\_chapter10.Rmd
* \_poverty_chapters/\_chapter11.Rmd
* persistent.Rmd
* \_persistent_chapters/\_pers01.Rmd
* \_persistent_chapters/\_pers02.Rmd
* \_persistent_chapters/\_pers03.Rmd
* \_persistent_chapters/\_pers04.Rmd
* \_persistent_chapters/\_pers05.Rmd
* \_persistent_chapters/\_pers06.Rmd
* \_persistent_chapters/\_pers07.Rmd
* accessibility.Rmd
* contact.Rmd
* cpupdate.Rmd
* download.Rmd
* uncertainty.Rmd

### Helper files for styles, site- and navbar configurations, and template

* styles.css
* \_site.yml
* \_footer.html
* \_navbar.html
* \_template.html - this pandoc template differs from the default in how the main html blocks (nav, main, footer) are configured

### Images and spreadsheets

* img/sglogo.svg
* img/badge.png
* img/chart0a.png
* img/chart0b.png
* img/chart0c.png

Note that the spreadsheets are created in step 2.

* xls/All three-year average.xlsx
* xls/All single year.xlsx

