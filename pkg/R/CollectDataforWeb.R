FirstTwo <- function(name) {
  if(is.null(name))
    name <- NA
  if(!is.na(name)) {
    name <- trim(name)
    name <- paste(strsplit(name," ")[[1]][1:2],sep=" ",collapse=" ")
  }
  return(name)
}



#common names counts
CNCount <- function(res) {
  whichCNs <- which(names(res$taxonConcept) == "commonName")
  languages <- NULL
  for(j in sequence(length(whichCNs))) {
    languages <- c(languages, as.character(res$taxonConcept[[whichCNs[j]]]$.attr[which(names(res$taxonConcept[[whichCNs[j]]]$.attr)=="lang")])) #not tidy, but effective for multiple entries
  }
  langCounts <- rep(NA,length(unique(languages)))
  for(k in sequence(length(unique(languages)))) {
  	langCounts[k] <- paste(unique(languages)[k], length(which(languages == unique(languages)[k])), sep=".", collapse="")
  }
  return(c(length(unique(languages)), paste(langCounts, collapse="_")))
}

#data object counts
DOCount <- function(res) {
  whichDOs <- which(names(res) == "dataObject")
  dataTypes <- NULL
  IUCNstat <- NA
  for(j in sequence(length(whichDOs))) {
    dataTypes <- c(dataTypes, res[[whichDOs[j]]]$mimeType)
    if(!is.null(res[[whichDOs[j]]]$title)) {
      if(res[[whichDOs[j]]]$title == "IUCNConservationStatus")
        IUCNstat <- res[[whichDOs[j]]]$description
    }
  }
  typeCounts <- rep(NA, length(unique(dataTypes)))
  for(k in sequence(length(unique(dataTypes)))) {
  	typeCounts[k] <- paste(unique(dataTypes)[k], length(which(dataTypes == unique(dataTypes)[k])), sep=".", collapse="")
  }
  return(c(length(unique(dataTypes)), paste(typeCounts, collapse="_"), IUCNstat))
}

#provider numbers
providerCount <- function(res) {
  whichProviders <- which(names(res$taxonConcept$additionalInformation) == "taxon")
  providerTypes <- NULL
  providerIDs <- NULL
  for(j in sequence(length(whichProviders))) {
    providerTypes <- c(providerTypes, res$taxonConcept$additionalInformation[[whichProviders[j]]]$nameAccordingTo)
    providerID <- paste(res$taxonConcept$additionalInformation[[whichProviders[j]]]$nameAccordingTo, res$taxonConcept$additionalInformation[[whichProviders[j]]]$taxonID, sep=".")
    providerIDs <- c(providerIDs, providerID)
  }
  return(c(length(unique(providerTypes)), paste(providerIDs, collapse="_")))
}


#gather vector of information
DataProcessing <- function(res) {
  if(!is.null(res$taxonConcept)) {
    taxonData <- c(FirstTwo(res$taxonConcept$ScientificName), res$taxonConcept$ScientificName, res$taxonConcept$taxonConceptID)
    richness <- res$taxonConcept$additionalInformation$richness_score
    refCounts <- length(which(names(res$taxonConcept) == "reference"))
    CNs <- CNCount(res)
    providers <- providerCount(res)
    DOs <- DOCount(res)
    pageLength <- sum(nchar(unlist(res, use.names=FALSE)))
  }	
  return(matrix(c(taxonData, richness, refCounts, CNs, providers , DOs, pageLength), nrow=1))
}

CollectDataforWeb <- function(MyEOL) {
  res <- PageProcessing(MyEOL)
  return(DataProcessing(res))
}












