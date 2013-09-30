\name{TaxonChildren}
\alias{TaxonChildren}
\title{Gathers A List Of Taxonomic Offspring}
\description{
	This function goes through the hierarchy pages to collect taxonomic offspring.    
}
\usage{
TaxonChildren(MyHiers)
}
\arguments{
	\item{MyHiers}{A vector of filenames for downloaded hierarchy pages}
}
\value{
	This function will report the primary offspring of a taxon if the hierarchy page reports this information.  
}
\examples{
#simple example using Reol data:
data(MyHiers)
TaxonChildren(MyHiers)

#Species of Anolis off NCBI
eolAnolis <- DownloadSearchedTaxa("Anolis", to.file=FALSE)
hierAnolis <- DownloadHierarchy(eolAnolis, to.file=FALSE, database="NCBI Taxonomy")
TaxonChildren(hierAnolis)

#Species of Anolis off The Reptile Database
eolAnolis <- DownloadSearchedTaxa("Anolis", to.file=FALSE)
repdbAnolis <- DownloadHierarchy(eolAnolis, to.file=FALSE, database="The Reptile Database")
TaxonChildren(repdbAnolis)


}
