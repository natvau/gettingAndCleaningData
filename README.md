Getting the tidy data
========================================================

# Download the data
```{r}
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" 
download.file(url=url, destfile='data', method='curl')
unzip(zipfile="data")
```

# Source the file
```{r}
source('run_analysis.r')
```

