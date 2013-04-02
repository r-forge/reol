\name{MakeHierarchyTree}
\alias{CombineHierarchyInfo}
\alias{subsetDataForHierTrees}
\alias{MakeTreeData}
\alias{RepeatDataToDrop}
\alias{MakeHierarchyTree}
\alias{ReturnTaxSet}
\alias{MakeNodeLabels}
\title{Creates Hierarchical Trees}
\description{
	These functions will create a phylogenetic tree (dendrogram) based on taxonomic ranking from EOL hierarchy pages. 
}
\usage{
CombineHierarchyInfo(MyHiers)
subsetDataForHierTrees(oneFileHier)
MakeTreeData(MyHiers)
RepeatDataToDrop(TreeData)
MakeHierarchyTree(MyHiers)
ReturnTaxSet(Taxon, TreeData)
MakeNodeLabels(MyHiers, label="all")
}
\arguments{
	\item{MyHiers}{A vector of hier pages}
	\item{oneFileHier}{A dataframe of taxonomic hierarchy information out of OneFileHierarchy function}
	\item{TreeData}{A dataframe of taxonomic hierarchy information out of MakeTreeData function}
	\item{Taxon}{Taxonomic group that contains subunits}
	\item{label}{Which hierarchical units should be included in the node labels}
}
\value{
	CombineHierarchyInfo combines OneFileHierarchy data frames into a single large data frame. subsetDataForHierTrees will delete data that is repeated or contains NAs from OneFileHierarchy data frames.  MakeTreeData returns a data frame with data for use in MakeHierarchyTree function, but can also be used independently. RepeatDataToDrop deletes columns that are monotypic or contain NAs, since these can not be used in tree building. MakeHierarchyTree returns phylogenetic tree in the class "phylo". ReturnTaxSet will return the tree tips for the taxonomic group requested. MakeNodeLabels will return a list of tip labels per internal node.  
}
\details{
	This tree displays taxonomic structuring only and is not the result of a phylogenetic analysis.
}
\examples{
	#CombinedFiles <- CombineHierarchyInfo(MyHiers)
	#TreeData <- MakeTreeData(MyHiers)
	#RepeatDataToDrop(TreeData)
	#MakeHierarchyTree(MyHiers)
	#ReturnTaxSet(TreeData[1,1], TreeData)
	#MakeNodeLabels(MyHiers, "all")
}
