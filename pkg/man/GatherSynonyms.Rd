\name{GatherSynonyms}
\alias{GatherSynonyms}
\title{Gathers A List Of Taxonomic Synonyms}
\description{
	This function goes through the hierarchy pages to collect taxonomic synonyms.    
}
\usage{
GatherSynonyms(MyHiers, output=1)
}
\arguments{
	\item{MyHiers}{A vector of filenames for downloaded hierarchy pages}
	\item{output}{Value of 1 or 2.  output=1 is default and will return a data frame with taxon and their taxonomic synonyms.  output=2 will return a dataframe with each species and synonym counts.}

}
\value{
	Returns a data frame where each row is a taxonomic unit. 
}
\examples{
	#GatherSynonyms(MyHiers)
}
