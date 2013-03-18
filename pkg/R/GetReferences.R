GetReferences <- function(MyFiles, output=1) {
  #This returns a data frame with all common names as a separate row.  Maybe make a data frame with an overview of information (number of cns in english, etc. for each sp.)
  References <- c()
  Taxon <- c()
  RefCounts <- c()
  for(i in sequence(length(MyFiles))) {
    res <- xmlToList(xmlRoot(xmlParse(MyFiles[i], getDTD=FALSE)), simplify=FALSE)$taxonConcept
    whichReferences <- which(names(res) == "reference")
    RefCounts <- rbind(RefCounts, c(res$ScientificName, res$taxonConceptID, length(whichReferences)))
    RefCounts <- data.frame(RefCounts, stringsAsFactors=F)
    colnames(RefCounts) <- c("Taxon", "eolID", "Number Of References")
    for(j in 1:length(whichReferences)) {
      Taxon <- append(Taxon, res$taxonConceptID)
      References <- append(References, res[whichReferences[j]])
    }
  }
  if(output == 1) {
    ReferenceList <- cbind(Taxon, References)
    return(ReferenceList)
  }
  if(output == 2)
    return(RefCounts)
}
