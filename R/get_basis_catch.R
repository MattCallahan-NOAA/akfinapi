#' get_basis_catch
#' @description This function pulls basis survey catch data
#' by species and life history stage including zero catches.
#' All parameters are optional but downloading all years, all species may take several minutes.
#' The default is to download only 2021.
#' A related function, get_tsn(), pulls a list of tsns to lookup.
#' @param startyear first year in the time series, default 2021
#' @param endyear last year in the time series, default 2021
#' @param minlat minimum latitude, used to differentiate NBS/SEBS, default 50
#' @param maxlat maximum latitude, used to differentiate NBS/SEBS, default 80
#' @param tsn taxonomic serial number
#'
#' @return
#' @export
#'
#' @examples
#' ##get catch from 2004
#' data<-get_basis_catch(start_year=2004, end_year=2004)
#'
#' ##get catch from 2004 from the NBS
#' data<-get_basis_catch(start_year=2004, end_year=2004, min_lat=60)
#'
#' ##Retrieve Pacific cod data from 2004 South of 60 degrees North
#' #look up tsn from get_tsn function
#' get_tsn()%>%
#' filter(commonname=="Pacific Cod")
#' #pull data
#' data<-get_basis_catch(start_year=2004, end_year=2004, max_lat=60, tsn=164711)

get_basis_catch <- function(start_year=2021, end_year=2021, min_lat=50, max_lat=80, tsn) {
  if(missing(tsn)){
    url<-"https://apex.psmfc.org/akfin/data_marts/akmp/basis_catch_spp_lh_0?"
    query<-list(start_year=start_year, end_year=end_year, min_lat=min_lat, max_lat=max_lat)
    httr::content(
      httr::GET(url=url, query=query),
                type = "application/json") %>%
      bind_rows()%>%
      rename_with(tolower) }

  else {
    url<-"https://apex.psmfc.org/akfin/data_marts/akmp/basis_catch_spp_lh_0?"
    tsn<-paste(tsn, collapse=",")
    query<-list(start_year=start_year, end_year=end_year, min_lat=min_lat, max_lat=max_lat, tsn=tsn)

    httr::content(
      httr::GET(url=url, query=query),
      type = "application/json") %>%
      bind_rows()%>%
      rename_with(tolower) }

}

#look up txonomic serial numbers
get_tsn<-function () {
  httr::content(
    httr::GET('https://apex.psmfc.org/akfin/data_marts/akmp/basis_tsn'),
    type = "application/json") %>%
    bind_rows%>%
    rename_with(tolower)
}
