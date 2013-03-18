GetRichnessScores <- function(MyFiles) {
  richness <- c()
  for(i in sequence(length(MyFiles))) {
    res <- xmlToList(xmlRoot(xmlParse(MyFiles[i], getDTD=FALSE)), simplify=FALSE)$taxonConcept
    richness <- rbind(richness, c(res$ScientificName, res$taxonConceptID, res$additionalInformation$richness_score))
    richness <- as.data.frame(richness, stringsAsFactors=FALSE)
  }
  colnames(richness) <- c("Taxon", "eolID", "Richness_Score")
  return(richness)
}
