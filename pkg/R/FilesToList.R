FilesToList <- function(MyFiles){
  MyFilesList <- vector("list", length(MyFiles))
  for(i in sequence(length(MyFiles))){
    MyFilesList[[i]]  <- xmlToList(xmlRoot(xmlParse(MyFiles[i], getDTD=FALSE)), simplify=FALSE)
    names(MyFilesList)[[i]] <- MyFiles[i]
  }
  return(MyFilesList)
}
