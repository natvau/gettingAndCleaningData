Getting the tidy data
========================================================

# Download the data
```{r}
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" 
download.file(url=url, destfile='data', method='curl')
unzip(zipfile="data")
```
# Copy run_analysis.R file into your working directory

# Source the file
```{r}
source('run_analysis.R')
```

