GetCommonNames <- function(MyFiles) {
  #This returns a data frame with all common names as a separate row.  Maybe make a data frame with an overview of information (number of cns in english, etc. for each sp.)
  CommonNames <- c()
  for(i in sequence(length(MyFiles))) {
    res <- xmlToList(xmlRoot(xmlTreeParse(MyFiles[i], getDTD=F)), simplify = T)$taxonConcept
    CNs <- which(names(res) == "commonName")
    for(j in sequence(length(CNs))) {
      CommonNames <- rbind(CommonNames, c(res$ScientificName, res$taxonConceptID, res[[CNs[j]]]$text, as.character(res[[CNs[j]]]$.attr)))
      CommonNames <- as.data.frame(CommonNames, stringsAsFactors=F)
    }
  }
  colnames(CommonNames) <- c("Taxon", "eolID", "Common Name", "language")
  return(CommonNames)
}
