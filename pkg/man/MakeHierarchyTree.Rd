\name{MakeHierarchyTree}
\alias{MakeTreeData}
\alias{MakeHierarchyTree}
\alias{ReturnTaxSet}
\alias{MakeNodeLabels}
\title{Creates Hierarchical Trees}
\description{
	These functions will create a phylogenetic tree (dendrogram) based on taxonomic ranking from EOL hierarchy pages. 
}
\usage{
MakeTreeData(MyHiers)
MakeHierarchyTree(MyHiers)
ReturnTaxSet(Taxon, TreeData)
MakeNodeLabels(MyHiers, label="all")
}
\arguments{
	\item{MyHiers}{A vector of hier pages}
	\item{TreeData}{A dataframe of taxonomic hierarchy information out of MakeTreeData function}
	\item{Taxon}{Taxonomic group that contains subunits}
	\item{label}{Which hierarchical units should be included in the node labels}
}
\value{
	MakeTreeData returns a data frame with data for use in MakeHierarchyTree function, but can also be used independently. MakeHierarchyTree returns phylogenetic tree in the class "phylo". ReturnTaxSet will return the tree tips for the taxonomic group requested. MakeNodeLabels will return a list of tip labels per internal node.  
}
\details{
	This tree displays taxonomic structuring only and is not the result of a phylogenetic analysis.
}
\examples{
	#TreeData <- MakeTreeData(MyHiers)
	#MakeHierarchyTree(MyHiers)
	#ReturnTaxSet(TreeData[1,1], TreeData)
	#MakeNodeLabels(MyHiers, "all")
}
