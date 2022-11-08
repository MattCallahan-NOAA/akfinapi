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
#' data<-get_basis_catch(startyear=2004, endyear=2004)
#'
#' ##get catch from 2004 from the NBS
#' data<-get_basis_catch(startyear=2004, endyear=2004, minlat=60)
#'
#' ##Retrieve Pacific cod data from 2004 South of 60 degrees North
#' #look up tsn from get_tsn function
#' get_tsn()%>%
#' filter(commonname=="Pacific Cod")
#' #pull data
#' data<-get_basis_catch(startyear=2004, endyear=2004, maxlat=60, tsn=164711)

get_basis_catch <- function(startyear=2021, endyear=2021, minlat=50, maxlat=80, tsn) {
  if(missing(tsn)){
    httr::content(
      httr::GET(paste0("https://apex.psmfc.org/akfin/data_marts/akmp/basis_catch_spp_lh_0?startyear=",startyear,
                       "&endyear=",endyear,
                       "&minlat=",minlat,
                       "&maxlat=",maxlat)),
                type = "application/json") %>%
      bind_rows()%>%
      rename_with(tolower) }

  else {
    httr::content(
      httr::GET(paste0("https://apex.psmfc.org/akfin/data_marts/akmp/basis_catch_spp_lh_0?startyear=",startyear,
                       "&endyear=",endyear,
                       "&minlat=",minlat,
                       "&maxlat=",maxlat,
                       "&tsn=",tsn)),
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
