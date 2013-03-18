DataObjectOverview <- function(MyFiles, verbose=TRUE){
#thinking about the next function for an overview of media types:
  cDOI <- CombineDataObjectInformation(MyFiles, verbose=verbose)  #returns dataframe with all data objects
  UniqueTaxa <- unique(cDOI[,1])
  UniqueDataTypes <- unique(cDOI[,6])
  overview <- c()
  for(h in sequence(length(UniqueTaxa))) {
    taxonInfo <- c()
    cDOIsubset <- cDOI[which(cDOI[,1] == UniqueTaxa[h]),]
    taxonName <- as.character(cDOIsubset[1,1])
    eolID <- as.character(cDOIsubset[1,2])
    for(i in sequence(length(UniqueDataTypes))){
      taxonInfo <- append(taxonInfo, length(which(cDOIsubset[,6] == UniqueDataTypes[i])))  
    }
  taxonInfo <- c(taxonName, eolID, taxonInfo)
  overview <- rbind(overview, taxonInfo)
  overview <- data.frame(overview, stringsAsFactors=FALSE)
  }  
  colnames(overview) <- c("Taxon", "eolID", UniqueDataTypes)
  return(overview)
}
