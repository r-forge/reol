\name{subsetDataForHierTrees}
\alias{subsetDataForHierTrees}
\title{Subset Data For Hier Trees}
\description{
	This function removed repeat taxonomic units, undefined clades, and NAs from hierarchy information. 
}
\usage{
subsetDataForHierTrees(data)
}
\arguments{
	\item{data}{A data frame from OneFileHierarchy}
}
\value{
	Returns a subset data frame. 
}
\examples{
	#subsetDataForHierTrees(OneFileHierarchy(MyHiers[1]))
}
