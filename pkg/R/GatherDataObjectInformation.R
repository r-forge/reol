GatherDataObjectInformation <- function(MyFile) {
  #this function works for one EOL file only.  It will return information about all of the different data objects associated with each taxon.  
  #There may be warnings with this function, and they should be ok.  Warnings may indicate that there is more than one entry for a field, which is typically associated with the "additional information" subheading
  res <- xmlToList(xmlRoot(xmlParse(MyFile, getDTD=FALSE)), simplify=FALSE)
  whichDataObjects <- which(names(res) == "dataObject") 
  NumberOfDataObjects <- length(whichDataObjects) 
  DataObjectInfo <- data.frame(matrix(nrow=NumberOfDataObjects, ncol=1), stringsAsFactors=F)
  taxon <- FirstTwo(res[[1]]$ScientificName)
  if (is.null(taxon)) 
    taxon <- NA
  eolID <- res[[1]]$taxonConceptID
  if (is.null(eolID)) 
    eolID <- NA
  DataObjectInfo <- data.frame(rep(taxon, NumberOfDataObjects), rep(eolID, NumberOfDataObjects), stringsAsFactors=F)  #initialize dataframe
  colnames(DataObjectInfo) <- c("Taxon", "eolID") 

  #add each data object one by one.  
  for(i in 1:NumberOfDataObjects){
    DO <- res[[whichDataObjects[i]]]
    for(j in 1:length(DO)){
      nameOfColumn <- names(DO)[j]
      if(!any(grepl(paste(nameOfColumn,'*', sep=""), colnames(DataObjectInfo)))) {  #add new column if data doesn't exist
        DataObjectInfo <- cbind(DataObjectInfo, rep(NA, NumberOfDataObjects))
        colnames(DataObjectInfo) <- c(colnames(DataObjectInfo[-length(colnames(DataObjectInfo))]), nameOfColumn) #ad new colname
      }
      column <- which(colnames(DataObjectInfo) == nameOfColumn)
      #DataObjectInfo[i,column] <- paste("DO$", nameOfColumn, sep="")
      DataObjectInfo[i,column] <- DO[[j]]

    }
  }
  return(DataObjectInfo)
}

