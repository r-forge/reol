subsetDataForHierTrees <- function(oneFileHier) {
  oneFileHier  <- oneFileHier[which(!duplicated(oneFileHier[,2])),] #delete repeats
  oneFileHier  <- oneFileHier[!is.na(oneFileHier[,2]),] #delete NAs
  if(any(oneFileHier[,2] == "unranked clade"))
    oneFileHier  <- oneFileHier[-which(oneFileHier[,2] == "unranked clade"),] #delete unranked
  return(oneFileHier)
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

MakeTreeData <- function(MyHiers) {
  if(any(MyHiers == "hierNA.xml"))
  	MyHiers <- MyHiers[-which(MyHiers == "hierNA.xml")]
  CombFiles <- CombineHierarchyInfo(MyHiers) #in future get these to read in just once
  whichColumns <- unique(CombFiles[,2])
  TreeData <- data.frame(matrix(nrow=length(MyHiers), ncol=length(whichColumns)))
  colnames(TreeData) <- whichColumns
  for(i in 1:length(MyHiers)) {
    #here go one at a time and add each row
    oneFile <- subsetDataForHierTrees(OneFileHierarchy(MyHiers[i]))
    for(j in sequence(dim(oneFile)[1])){
      colPosition <- which(colnames(TreeData) == oneFile[j,2])
      TreeData[i,colPosition] <- oneFile[j,1]
      TreeData <- as.data.frame(TreeData, stringsAsFactors=T)
    }
  }
  return(TreeData)
}  
  
MakeHierarchyTree <- function(MyHiers, includeNodeLabels=TRUE) {
  TreeData <- MakeTreeData(MyHiers)
  DataToDrop <- which(apply(TreeData, 2, RepeatDataToDrop))
  pattern <- paste("~", paste(colnames(TreeData)[-which(apply(TreeData, 2, RepeatDataToDrop))], sep="", collapse="/"), sep="")
  fo <- as.formula(pattern)
  TreeData <- as.data.frame(apply(TreeData, 2, factor))
  tree <- ladderize(as.phylo.formula(fo, data=TreeData))  
  if(includeNodeLabels)
    tree <- makeNodeLabel(tree, method="u", nodeList=NodeLabelList(MyHiers, "all"))  #maybe change this later when other options
  return(tree)
}

ReturnTaxSet <- function(Taxon, TreeData) {
	whichRows <- which(TreeData == Taxon, TRUE)[,1]
	return(TreeData[whichRows, dim(TreeData)[2]])
}

NodeLabelList <- function(MyHiers, label="all") {  #also make an option to just label genus, etc. 
  TreeData <- MakeTreeData(MyHiers)
  DataToDrop <- which(apply(TreeData, 2, RepeatDataToDrop))
  prunedTreeData <- TreeData[,-DataToDrop]
  if(label == "all")
    uniqueTaxSets <- c(apply(prunedTreeData[,-dim(prunedTreeData)[2]], 2, unique), recursive=T)
  ListOfSpeciesPerNode <- lapply(uniqueTaxSets, ReturnTaxSet, TreeData=prunedTreeData)
  names(ListOfSpeciesPerNode) <- uniqueTaxSets
  ListOfSpeciesPerNode <- ListOfSpeciesPerNode[which(lapply(ListOfSpeciesPerNode, length) > 1)]
  return(ListOfSpeciesPerNode)
}

