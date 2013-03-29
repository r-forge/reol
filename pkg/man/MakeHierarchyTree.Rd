\name{MakeHierarchyTree}
\alias{MakeHierarchyTree}
\title{Creates Hierarchical Tree}
\description{
	This function will create a phylogenetic tree (dendrogram) based on taxonomic ranking from EOL hierarchy pages.
}
\usage{
MakeHierarchyTree(MyHiers)
}
\arguments{
	\item{MyHiers}{A vector of hier pages}
}
\value{
	Returns phylogenetic tree in the class "phylo".
}
\details{
	This tree displays taxonomic structuring only and is not the result of a phylogenetic analysis.  
}
\examples{
	#MakeHierarchyTree(MyHiers)
}
