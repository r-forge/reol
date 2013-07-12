#IUCN
GetIUCNStat <- function(MyEOLs) {
  IUCN <- matrix(ncol=3, nrow=length(MyEOLs))
  colnames(IUCN) <- c("Taxon", "eolID", "IUCNstat")
  for(i in sequence(length(MyEOLs))){
    res <- PageProcessing(MyEOLs[i])
    whichDOs <- which(names(res) == "dataObject")
    IUCNstat <- NA
    for(j in sequence(length(whichDOs))) {
      if(!is.null(res[[whichDOs[j]]]$title)) {
        if(res[[whichDOs[j]]]$title == "IUCNConservationStatus")
          IUCNstat <- res[[whichDOs[j]]]$description
      }
    }
  
  IUCN[i,] <- c(res$taxonConcept$ScientificName, res$taxonConcept$taxonConceptID, IUCNstat)
  }  
  return(IUCN)
}