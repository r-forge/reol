FirstTwo <- function(name) {
  if(is.null(name))
    name <- NA
  if(!is.na(name)) {
    name <- trim(name)
    name <- paste(strsplit(name," ")[[1]][1:2],sep=" ",collapse=" ")
  }
  return(name)
}