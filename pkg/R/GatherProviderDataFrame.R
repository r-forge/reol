GatherProviderDataFrame <- function(MyFiles, extended.output=FALSE) {
  Providers <- data.frame(matrix(nrow=1, ncol=2))
  for(i in sequence(length(MyFiles))) {
    res <- xmlToList(xmlRoot(xmlParse(MyFiles[i], getDTD=FALSE))[[1]], simplify=FALSE) #[[1]] here for gathering just taxonConcepts
    taxon <- FirstTwo(res$ScientificName)
    if (is.null(taxon)) 
      taxon <- NA
    eolID <- res$taxonConceptID
    if (is.null(eolID)) 
      eolID <- NA
    if (i==1)
      Providers <- data.frame(taxon, as.numeric(eolID))
    else
      Providers <- rbind(Providers, data.frame(taxon, as.numeric(eolID)))
  }  
  colnames(Providers) <- c("Taxon", "eolID")

  provider.vector <- c()
  provider.dataframe <- Providers
  for(row.num in sequence(dim(Providers)[1])){
    res <- xmlToList(xmlRoot(xmlParse(MyFiles[row.num], getDTD=FALSE))[[1]], simplify=FALSE)
    whichTaxon <- which(names(res$additionalInformation) == "taxon")
    for (i in sequence(length(whichTaxon))) {
      source <- NULL
      try(source <- res$additionalInformation[[whichTaxon[i]]]$nameAccordingTo)
      if (!is.null(source)) {
        identifier <- NULL
        taxonID <- NULL
        scientificName <- NULL
        taxonRank <- NULL
        try(identifier <- res$additionalInformation[[whichTaxon[i]]]$identifier)
        try(taxonID <- res$additionalInformation[[whichTaxon[i]]]$taxonID)
        try(scientificName <- res$additionalInformation[[whichTaxon[i]]]$scientificName)
        try(taxonRank <- res$additionalInformation[[whichTaxon[i]]]$taxonRank)
        if(sum(grepl(paste(source, '*', sep=""), colnames(Providers)))==0) {
          provider.dataframe<-cbind(provider.dataframe, rep(0, dim(provider.dataframe)[1]))
          colnames(provider.dataframe)[dim(provider.dataframe)[2]]<-source
          provider.vector<-append(provider.vector, source)
          Providers <-cbind(Providers, rep(NA, dim(Providers)[1]))
          colnames(Providers)[dim(Providers)[2]] <- paste(source, ".identifier", sep="")
          Providers <-cbind(Providers, rep(NA, dim(Providers)[1]))
          colnames(Providers)[dim(Providers)[2]] <- paste(source, ".taxonID", sep="")
          Providers <-cbind(Providers, rep(NA, dim(Providers)[1]))
          colnames(Providers)[dim(Providers)[2]] <- paste(source, ".scientificName", sep="")
          Providers <-cbind(Providers, rep(NA, dim(Providers)[1]))
          colnames(Providers)[dim(Providers)[2]] <- paste(source, ".taxonRank", sep="")
        }
        provider.dataframe[row.num, which(colnames(provider.dataframe) == source)] <- 1
        if (!is.null(identifier)) 
          Providers[row.num, which(colnames(Providers) == paste(source, ".identifier", sep=""))] <- identifier
        if (!is.null(taxonID))
          Providers[row.num, which(colnames(Providers) == paste(source, ".taxonID", sep=""))] <- taxonID
        if (!is.null(scientificName)) 
          Providers[row.num, which(colnames(Providers) == paste(source, ".scientificName", sep=""))] <- scientificName
        if (!is.null(taxonRank)) 
          Providers[row.num, which(colnames(Providers) == paste(source, ".taxonRank", sep=""))] <- taxonRank
      }
    }
  }
  provider.dataframe <- cbind(provider.dataframe, number.sources=apply(provider.dataframe[,3:dim(provider.dataframe)[2]], 1, sum))
  if (extended.output) {
    Providers <- cbind(Providers, provider.dataframe[,3:dim(provider.dataframe)[2]])
    Providers <- Providers[which(!is.na(Providers$eolID)),]
    return(Providers)
  }
  else
    return(provider.dataframe)
}
