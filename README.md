# akfinapi
A package to pull from the AKFIN database via api

This package is currently in development. Contact the author before using. 


## Installation
You can install the development version of akfinapi from [GitHub](https://github.com/) with:

``` {r, eval=FALSE}
devtools::install_github("MattCallahan-NOAA/akfinapi")
```

Example code
``` {r, eval=FALSE}
library(akfinapi)
library(httr)
library(tidyverse)

## get catch from 2004
data<-get_basis_catch(start_year=2004, end_year=2004)

## get catch from 2004 from the NBS
data<-get_basis_catch(start_year=2004, end_year=2004, min_lat=60)

## Retrieve Pacific cod data from 2004 South of 60 degrees North
# look up Pacific cod tsn from get_tsn() function
get_tsn()%>%
filter(commonname=="Pacific Cod")
# pull data
data<-get_basis_catch(start_year=2004, end_year=2004, max_lat=60, tsn=164711)

## add Arctic cod data also.
data<-get_basis_catch(start_year=2019, end_year=2023, tsn=c(164706,164711))
```
