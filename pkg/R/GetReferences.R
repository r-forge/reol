GetReferences <- function(MyFiles, output=c("detail", "counts")) {
  #This returns a data frame with all common names as a separate row.  Maybe make a data frame with an overview of information (number of cns in english, etc. for each sp.)
  output <- match.arg(output)
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
      #if(!is.null(res[whichReferences[j]])){  #commented out because some taxa do not have references, so they come in NULL.  
        Taxon <- append(Taxon, res$taxonConceptID)
        References <- append(References, res[whichReferences[j]])
      #}
    }
  }
  if(output == "detail") {
    ReferenceList <- cbind(Taxon, References)
    return(ReferenceList)
  }
  if(output == "counts")
    return(RefCounts)
}
