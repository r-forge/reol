CombineDataObjectInformation <- function(MyFiles, verbose=T) {
  #Next: subset to Trusted Information only
  #this function works for multiple EOL files.  It will return information about all of the different data objects associated with each taxon.  
  #There may be warnings with this function, and they should be ok.  Warnings may indicate that there is more than one entry for a field, which is typically associated with the "additional information" subheading
  CombinedDOI <- suppressWarnings(GatherDataObjectInformation(MyFiles[1]))
  for (i in 2:length(MyFiles)){
    if(verbose)
      print(paste("combined", i, "files"))
    DOI <- suppressWarnings(GatherDataObjectInformation(MyFiles[i]))
    if(any(!colnames(DOI) %in% colnames(CombinedDOI))) { #check that all new data coming in will match existing data
      ColumnsToAdd <- which(!colnames(DOI) %in% colnames(CombinedDOI))
      for(j in sequence(length(ColumnsToAdd))) {
        CombinedDOI <- cbind(CombinedDOI, rep(NA, dim(CombinedDOI)[1]))
        colnames(CombinedDOI) <- c(colnames(CombinedDOI[-length(colnames(CombinedDOI))]), colnames(DOI)[ColumnsToAdd[j]]) #add new colname
        #print(paste("added column to CombinedDOI", colnames(DOI)[ColumnsToAdd[j]]))
      }
    }
    if(any(!colnames(CombinedDOI) %in% colnames(DOI))) { #check that all new data coming in will match existing data
      ColumnsToAdd <- which(!colnames(CombinedDOI) %in% colnames(DOI))
      for(j in sequence(length(ColumnsToAdd))) {
        DOI <- cbind(DOI, rep(NA, dim(DOI)[1]))
        colnames(DOI) <- c(colnames(DOI[-length(colnames(DOI))]), colnames(CombinedDOI)[ColumnsToAdd[j]]) #add new colname
        #print(paste("added column to DOI", colnames(CombinedDOI)[ColumnsToAdd[j]]))
      }
    }

    ColMatches <- match(colnames(CombinedDOI), colnames(DOI))
    #two ways of sorting dataframes by columns seem to work 1) b[,c(2,1,3)] and 2) subset(b, select=c(2,1,3))
    #rearrange colnames in DOI then add to CombinedDOI
    DOI <- DOI[,ColMatches]
    CombinedDOI <- rbind(CombinedDOI, DOI)
  }
  return(CombinedDOI)
}