\name{GatherSynonyms}
\alias{GatherSynonyms}
\title{Gathers A List Of Taxonomic Synonyms}
\description{
	This function goes through the hierarchy pages to collect taxonomic synonyms.    
}
\usage{
GatherSynonyms(MyHiers, from.file=TRUE, output = c("detail", "counts"))
}
\arguments{
	\item{MyHiers}{A vector of filenames for downloaded hierarchy pages}
	\item{output}{"detail" will return a data frame with each taxon and their taxonomic synonyms; "counts" will return a dataframe with each species and synonym counts.}

}
\value{
	Returns a data frame where each row is a taxonomic unit. 
}
\examples{
	#GatherSynonyms(MyHiers)
}
