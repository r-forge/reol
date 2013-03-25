GetRichnessScores <- function(MyEOLs) {
  richnessDF <- matrix(nrow=length(MyEOLs), ncol=3)
  for(i in sequence(length(MyEOLs))) {
    richnessData <- rep(NA, 3)
    res <- xmlToList(xmlRoot(xmlParse(MyEOLs[i], getDTD=FALSE)), simplify=FALSE)$taxonConcept
    richnessData <- c(res$ScientificName, res$taxonConceptID, res$additionalInformation$richness_score)
    richnessDF[i,] <- richnessData
  }
  richnessDF <- as.data.frame(richnessDF, stringsAsFactors=FALSE)
  colnames(richnessDF) <- c("Taxon", "eolID", "Richness_Score")
  return(richnessDF)
}
