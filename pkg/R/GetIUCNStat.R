GetIUCNStat <- function(MyEOLs, from.file=TRUE) {
  IUCN <- matrix(ncol=3, nrow=length(MyEOLs))
  colnames(IUCN) <- c("Taxon", "eolID", "IUCNstat")
  for(i in sequence(length(MyEOLs))){
    if(from.file)
      res <- PageProcessing(MyEOLs[i])
    else
      res <- PageProcessing(MyEOLs[[i]])
    whichDOs <- which(names(res) == "dataObject")
    IUCNstat <- NA
    for(j in sequence(length(whichDOs))) {  #cleaner/faster way to do this would be to grep for IUCN throughout all of res, get location and use that
      if(!is.null(res[[whichDOs[j]]]$title)) {
        if(res[[whichDOs[j]]]$title == "IUCNConservationStatus")
          IUCNstat <- res[[whichDOs[j]]]$description
      }
    }
  scientificName  <- res$taxonConcept[[which(names(res$taxonConcept) == grep("ScientificName", names(res$taxonConcept), ignore.case=TRUE, value=T))]] #because some are cap and some are not
  IUCN[i,] <- c(scientificName, res$taxonConcept$taxonConceptID, IUCNstat)
  }  
  return(IUCN)
}