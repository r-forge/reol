GetRichnessScores <- function(MyFiles) {
  richness <- c()
  for(i in sequence(length(MyFiles))) {
    res <- xmlToList(xmlRoot(xmlTreeParse(MyFiles[i], getDTD=F)), simplify = T)$taxonConcept
    richness <- rbind(richness, c(res$ScientificName, res$taxonConceptID, res$additionalInformation$richness_score))
    richness <- as.data.frame(richness, stringsAsFactors=F)
  }
  colnames(richness) <- c("Taxon", "eolID", "Richness_Score")
  return(richness)
}
