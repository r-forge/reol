GetCommonNames <- function(MyFiles, output=c("detail", "counts")) {
  #This returns a data frame with all common names as a separate row.  Maybe make a data frame with an overview of information (number of cns in english, etc. for each sp.)
  output <- match.arg(output)
  CommonNames <- matrix(nrow=0, ncol=4)
  colnames(CommonNames) <- c("Taxon", "eolID", "Common Name", "language")
  CNOverview <- data.frame(matrix(nrow=length(MyFiles), ncol=2))
  colnames(CNOverview) <- c("Taxon", "eolID")
  for(i in sequence(length(MyFiles))) {
  	#print(paste("starting file", MyFiles[i]))
    taxon <- NA
    eolID <- NA
    res <- xmlToList(xmlRoot(xmlParse(MyFiles[i], getDTD=FALSE)), simplify=FALSE)$taxonConcept
    if(!is.null(res)) {
      taxon <- res$ScientificName
      eolID <- res$taxonConceptID
      CNOverview[i,1:2] <- c(taxon, eolID)
      CNs <- which(names(res) == "commonName")
      taxonCommonNames <- rep(NA, 4)
      for(j in sequence(length(CNs))) {
        language <- as.character(res[[CNs[j]]]$.attr[which(names(res[[CNs[j]]]$.attr)=="lang")]) #not tidy, but effective for multiple entries
        taxonCommonNames <- c(res$ScientificName, res$taxonConceptID, res[[CNs[j]]]$text, language)
        CommonNames <- rbind(CommonNames, taxonCommonNames, deparse.level=0)
        CommonNames <- data.frame(CommonNames, stringsAsFactors=FALSE)
        if(sum(grepl(language, colnames(CNOverview))) == 0) {
          CNOverview <- cbind(CNOverview, rep(0, length(MyFiles)))
          colnames(CNOverview) <- append(colnames(CNOverview[-dim(CNOverview)[2]]), language)
        }
        languageColumn <- which(colnames(CNOverview) == language)  ##BROKEN
        CNOverview[i,languageColumn] <- as.numeric(CNOverview[i,languageColumn])+1   ##BROKEN
      }
    }
  }
  if (output == "detail")
    return(CommonNames)
  if (output == "counts")
    return(CNOverview)
}