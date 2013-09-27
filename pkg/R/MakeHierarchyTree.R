subsetDataForHierTrees <- function(oneFileHier, HierID) {
  oneFileHier <- oneFileHier[1:which(oneFileHier[,6] == HierID),]  #stop at HierID to avoid taking children
  oneFileHier  <- matrix(oneFileHier[which(!duplicated(oneFileHier[,2])),], ncol=7) #delete repeats
  oneFileHier  <- matrix(oneFileHier[!is.na(oneFileHier[,2]),], ncol=7) #delete NAs; ncol is hard coded to be 7 columns so that R doesn't convert to a vector when there is a single row.  
  if(any(oneFileHier[,2] == "unranked clade"))
    oneFileHier  <- oneFileHier[-which(oneFileHier[,2] == "unranked clade"),] #delete unranked
  return(oneFileHier)
}

MergeTaxonomies <- function(i, j) {
  combined <- i
  `%ni%` = Negate(`%in%`) 
  outlier.pos <- which(j %ni% i)
  for (outlier.index in sequence(length(outlier.pos))) {
    if (outlier.pos[outlier.index] == 1) {
      warning("Haven't dealt with this yet")
      return(combined)
    }
    previous.pos <- which(grepl(j[outlier.pos[outlier.index] - 1], combined))[1]
    if ((previous.pos+1) <= length(combined))
      combined <- c(combined[1:previous.pos], j[outlier.pos[outlier.index]], combined[(previous.pos+1): length(combined)]) 
    else
      combined <- c(combined[1:previous.pos], j[outlier.pos[outlier.index]])
  }
  return(combined)
}

CombineHierarchyInfo <- function(MyHiers) {
  CombFiles <- matrix(nrow=0, ncol=7)
  longestHierTaxon <- 0  #start at 0, so it accepts the first file as the longest
  MergedTax <- NULL
  for(i in sequence(length(MyHiers))) {
    oneFile <- subsetDataForHierTrees(OneFileHierarchy(MyHiers[i]), GetHierID(MyHiers[i]))
    Tax <- oneFile[,2]
    MergedTax <- MergeTaxonomies(Tax, MergedTax)
    if(length(oneFile[,2]) > longestHierTaxon) {
      longestHierTaxon <- max(longestHierTaxon, length(oneFile[,2]))    
      CombFiles <- rbind(oneFile, CombFiles)  #puts longest hierarchies first in combined files
      CombFiles <- as.data.frame(CombFiles, stringsAsFactors=FALSE)
      #print(paste("longest dim = ", longestHierTaxon))
    }
    else
      CombFiles <- rbind(CombFiles, oneFile)  #puts shorter hierarchies after
  }
  
  return(list(CombFiles, MergedTax))
}

MakeTreeData <- function(MyHiers) {
  if(any(is.na(GetHierID(MyHiers)))) {
  	whichNAs <- which(is.na(GetHierID(MyHiers)))
  	MyHiers <- MyHiers[-whichNAs]
  }
  CombFiles <- CombineHierarchyInfo(MyHiers)
  whichColumns <- CombFiles[[2]]
  TreeData <- data.frame(matrix(nrow=length(MyHiers), ncol=length(whichColumns)))
  colnames(TreeData) <- whichColumns
  for(i in sequence(length(MyHiers))) {
    #here go one at a time and add each row
    oneFile <- subsetDataForHierTrees(OneFileHierarchy(MyHiers[i]), GetHierID(MyHiers[i]))
    for(j in sequence(dim(oneFile)[1])){
      colPosition <- which(colnames(TreeData) == oneFile[j,2])
      TreeData[i,colPosition] <- oneFile[j,1]
      TreeData <- as.data.frame(TreeData, stringsAsFactors=T)
    }
  }
  return(TreeData)
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

DropADim <- function(TreeData) {
  while(any(is.na(TreeData))){
    rowPercent <- apply(is.na(TreeData), 1, sum)/dim(TreeData)[2]
    colPercent <- apply(is.na(TreeData), 2, sum)/dim(TreeData)[1]
    maxPercent <- max(c(rowPercent, colPercent))
    if(maxPercent %in% rowPercent)
      TreeData  <- TreeData[-which(rowPercent == maxPercent), ]
    if(maxPercent %in% colPercent)
      TreeData  <- TreeData[,-which(colPercent == maxPercent)]
  }
  return(TreeData)
}

  
MakeHierarchyTree <- function(MyHiers, includeNodeLabels=TRUE) {
  TreeData <- MakeTreeData(MyHiers)
  TreeData <- DropADim(TreeData)
  DataToDrop <- which(apply(TreeData, 2, RepeatDataToDrop))
  pattern <- paste("~", paste(colnames(TreeData)[-which(apply(TreeData, 2, RepeatDataToDrop))], sep="", collapse="/"), sep="")
  if(pattern == "~")
    stop("Error in Tree Building: try MakeTreeData(MyHiers) to see if there is hierarchical data associated with your files")
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
  TreeData <- DropADim(TreeData)
  DataToDrop <- which(apply(TreeData, 2, RepeatDataToDrop))
  prunedTreeData <- TreeData[,-DataToDrop]
  if(label == "all")
    uniqueTaxSets <- c(apply(prunedTreeData[,-dim(prunedTreeData)[2]], 2, unique), recursive=T)
  ListOfSpeciesPerNode <- lapply(uniqueTaxSets, ReturnTaxSet, TreeData=prunedTreeData)
  names(ListOfSpeciesPerNode) <- uniqueTaxSets
  ListOfSpeciesPerNode <- ListOfSpeciesPerNode[which(lapply(ListOfSpeciesPerNode, length) > 1)]
  return(ListOfSpeciesPerNode)
}

