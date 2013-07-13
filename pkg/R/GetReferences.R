GetReferences <- function(MyEOLs, output=c("detail", "counts")) {
  output <- match.arg(output)
  ReferenceList <- matrix(nrow=0, ncol=3)
  colnames(ReferenceList) <- c("Taxon", "eolID", "Reference")
  RefCounts <- matrix(nrow=length(MyEOLs), ncol=3)
  colnames(RefCounts) <- c("Taxon", "eolID", "Number Of References")
  for(i in sequence(length(MyEOLs))) {
    res <- PageProcessing(MyEOLs[i])$taxonConcept
    whichReferences <- which(names(res) == "reference")
    RefCounts[i,] <- c(res$ScientificName, res$taxonConceptID, length(whichReferences))
    for(j in 1:length(whichReferences)) {
      #if(!is.null(res[whichReferences[j]])){  #commented out NULL, because come in "NULL" so is.null doesn't work
        ReferenceList <- rbind(ReferenceList , c(res$ScientificName, res$taxonConceptID, as.character (res[whichReferences[j]])))
      #}
    }
  }
  RefCounts <- data.frame(RefCounts, stringsAsFactors=F)
  ReferenceList <- data.frame(ReferenceList, stringsAsFactors=F)
  if(output == "detail")
    return(ReferenceList)
  if(output == "counts")
    return(RefCounts)
}
