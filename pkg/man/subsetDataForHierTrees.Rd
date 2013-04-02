\name{subsetDataForHierTrees}
\alias{subsetDataForHierTrees}
\title{Subset Data For Hier Trees}
\description{
	This function removed repeat taxonomic units, undefined clades, and NAs from hierarchy information. 
}
\usage{
subsetDataForHierTrees(oneFileHier)
}
\arguments{
	\item{oneFileHier}{A dataframe of taxonomic hierarchy information out of OneFileHierarchy function}
}
\value{
	Returns a subset data frame. 
}
\examples{
	#subsetDataForHierTrees(OneFileHierarchy(MyHiers[1]))
}
