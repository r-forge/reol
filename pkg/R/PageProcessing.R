PageProcessing <- function(MyEOL) {
  res <- xmlToList(xmlRoot(xmlParse(MyEOL, getDTD=FALSE)), simplify=FALSE)
  if(!is.null(res$error)) {
    system(paste("mv", MyEOL, "../TRASH/"))
    stop(paste("Bad file", MyEOL, "has been purged"))
    }
  return(res)
}
