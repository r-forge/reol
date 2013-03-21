GetRichnessScores <- function(MyFiles) {
  richnessDF <- matrix(nrow=length(MyFiles), ncol=3)
  for(i in sequence(length(MyFiles))) {
    richnessData <- rep(NA, 3)
    res <- xmlToList(xmlRoot(xmlParse(MyFiles[i], getDTD=FALSE)), simplify=FALSE)$taxonConcept
    richnessData <- c(res$ScientificName, res$taxonConceptID, res$additionalInformation$richness_score)
    richnessDF[i,] <- richnessData
  }
  richnessDF <- as.data.frame(richnessDF, stringsAsFactors=FALSE)
  colnames(richnessDF) <- c("Taxon", "eolID", "Richness_Score")
  return(richnessDF)
}
