subsetDataForHierTrees <- function(data) {
  data  <- data[which(!duplicated(data[,2])),] #delete repeats
  data  <- data[!is.na(data[,2]),] #delete NAs
  if(any(data[,2] == "unranked clade"))
    data  <- data[-which(data[,2] == "unranked clade"),] #delete unranked
  return(data)
}

CombineHierarchyInfo <- function(MyHiers) {
  CombFiles <- matrix(nrow=0, ncol=7)
  for(i in 1:length(MyHiers)) {
    oneFile <- subsetDataForHierTrees(OneFileHierarchy(MyHiers[i]))
    CombFiles <- rbind(CombFiles, oneFile)
    CombFiles <- as.data.frame(CombFiles, stringsAsFactors=FALSE)
  }
  return(CombFiles)
}

RepeatDataToDrop <- function(TreeData) {
  #Drop any columns that are the same or NA
  if(length(unique(TreeData)) == 1)
    return(TRUE)
  if(any(is.na(TreeData)))
    return(TRUE)
  else
    return(FALSE)
}


MakeHierarchyTree <- function(MyHiers) {
  CombFiles <- CombineHierarchyInfo(MyHiers) #in future get these to read in just once
  whichColumns <- unique(CombFiles[,2])
  TreeData <- data.frame(matrix(nrow=length(MyHiers), ncol=length(whichColumns)))
  colnames(TreeData) <- whichColumns
  for(i in 1:length(MyHiers)) {
    #here go one at a time and add each row
    oneFile <- subsetDataForHierTrees(OneFileHierarchy(MyHiers[i]))
    for(j in sequence(dim(oneFile)[1])){
      colPosition <- which(colnames(TreeData) == oneFile[j,2])
      #colPosition <- grep(oneFile[j,2], oneFile[,2], ignore.case=TRUE)  #ignoring case acts like a wildcard instead of just case (infraorder, order, suborder all return)
      TreeData[i,colPosition] <- oneFile[j,1]
      TreeData <- as.data.frame(TreeData, stringsAsFactors=T)
    }
  }
  DataToDrop <- which(apply(TreeData, 2, RepeatDataToDrop))
  pattern <- paste("~", paste(colnames(TreeData)[-which(apply(TreeData, 2, RepeatDataToDrop))], sep="", collapse="/"), sep="")
  TreeData <- as.data.frame(apply(TreeData, 2, factor))
  class(fo <- ~genus/Species)
  tree <- as.phylo.formula(fo, data=TreeData)  
  return(tree)
}