GatherDataObjects <- function(MyFiles) {
  DataObjects <- data.frame(matrix(nrow=1, ncol=2))
  for(i in sequence(length(MyFiles))) {
    res <- xmlToList(xmlRoot(xmlTreeParse(MyFiles[i], getDTD=F)), simplify = T)
    whichDataObjects <- which(names(res) == "dataObject") 
    taxon <- FirstTwo(res[[1]]$ScientificName)
    if (is.null(taxon)) 
      taxon <- NA
    eolID <- res[[1]]$taxonConceptID
    if (is.null(eolID)) 
      eolID <- NA
    if (i==1)
      DataObjects <- data.frame(taxon, as.numeric(eolID))
    else
      DataObjects <- rbind(DataObjects, data.frame(taxon, as.numeric(eolID)))
  }  
  colnames(DataObjects) <- c("Taxon", "eolID")
  
  #add each data object one by one.  USE NEW FUNCTION
  


  return(DataObjects)
}

