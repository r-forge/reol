DataObjectOverview <- function(MyFiles, verbose=T){
#thinking about the next function for an overview of media types:
  cDOI<-CombineDataObjectInformation(MyFiles, verbose=verbose)
  UniqueTaxa <- unique(cDOI[,1])
  UniqueDataTypes <- unique(cDOI[,6])
  overview <- c()
  for(h in sequence(length(UniqueTaxa))){
    a <- cDOI[which(cDOI[,1] == UniqueTaxa[h]),]
    b <- as.character(a[1,1])
    for(i in sequence(length(UniqueDataTypes))){
      b <- c(b, length(which(a[,6] == UniqueDataTypes[i])))  
    }
  overview <- rbind(overview, b)
  overview <- data.frame(overview, stringsAsFactors=F)
  }  
  colnames(overview) <- c("Taxon", UniqueDataTypes)
  return(overview)
}
