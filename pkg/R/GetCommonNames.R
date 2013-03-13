GetCommonNames <- function(MyFiles, output=1) {
  #This returns a data frame with all common names as a separate row.  Maybe make a data frame with an overview of information (number of cns in english, etc. for each sp.)
  CommonNames <- c()
  for(i in sequence(length(MyFiles))) {
    res <- xmlToList(xmlRoot(xmlTreeParse(MyFiles[i], getDTD=F)), simplify = T)$taxonConcept
    CNs <- which(names(res) == "commonName")
    for(j in sequence(length(CNs))) {
      language <- as.character(res[[CNs[j]]]$.attr[which(names(res[[CNs[j]]]$.attr)=="lang")]) #not tidy, but effective for multiple entries
      CommonNames <- rbind(CommonNames, c(res$ScientificName, res$taxonConceptID, res[[CNs[j]]]$text, language))
      CommonNames <- as.data.frame(CommonNames, stringsAsFactors=F)
    }
  }
  colnames(CommonNames) <- c("Taxon", "eolID", "Common Name", "language")
  if (output == 1)
    return(CommonNames)

  if (output == 2){
    CNOverview <- c()
    whichLanguages <- unique(unique(CommonNames[,4]))
    for(i in sequence(length(MyFiles))) {
      res <- xmlToList(xmlRoot(xmlTreeParse(MyFiles[i], getDTD=F)), simplify = T)$taxonConcept 
      CNOverview <- rbind(CNOverview, c(res$ScientificName, res$taxonConceptID, rep(0, length(whichLanguages))))
      CNOverview <- as.data.frame(CNOverview, stringsAsFactors=F)
      colnames(CNOverview) <- c("Taxon", "eolID", whichLanguages)
      CNs <- which(names(res) == "commonName")
      for(j in sequence(length(CNs))) {
        language <- as.character(res[[CNs[j]]]$.attr[which(names(res[[CNs[j]]]$.attr)=="lang")]) #not tidy, but effective for multiple entries
        languageColumn <- which(colnames(CNOverview) == language)
        CNOverview[i,languageColumn] <- as.numeric(CNOverview[i,languageColumn])+1
      }
    }
  return(CNOverview)
  }
}
