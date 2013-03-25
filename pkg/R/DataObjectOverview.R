DataObjectOverview <- function(MyEOLs, verbose=TRUE){
  cDOI <- CombineDataObjectInformation(MyEOLs, verbose=verbose)  #returns dataframe with all data objects
  UniqueTaxa <- unique(cDOI[,1])
  UniqueDataTypes <- unique(cDOI[,6])
  overview <- matrix(nrow=length(UniqueTaxa), ncol=2+length(UniqueDataTypes))
  colnames(overview) <- c("Taxon", "eolID", UniqueDataTypes)
  for(h in sequence(length(UniqueTaxa))) {
    taxonInfo <- NULL
    cDOIsubset <- cDOI[which(cDOI[,1] == UniqueTaxa[h]),]
    taxonName <- as.character(cDOIsubset[1,1])
    eolID <- as.character(cDOIsubset[1,2])
    for(i in sequence(length(UniqueDataTypes))){
      taxonInfo <- append(taxonInfo, length(which(cDOIsubset[,6] == UniqueDataTypes[i])))  
    }
  taxonInfo <- c(taxonName, eolID, taxonInfo)
  overview[h,] <- taxonInfo
  }  
  overview <- data.frame(overview, stringsAsFactors=FALSE)
  return(overview)
}
