\name{DownloadHierarchy}
\alias{DownloadHierarchy}
\alias{ProviderCount}
\alias{BestProvider}
\title{Download Hierarchy Content From Contributors}
\description{
	This function will use the EOL pages to find the provider information.  Hierarchies get downloaded as "hier" pages rather than "eol" pages. Providers contribute information on taxonomic rankings, hierarchical tree structure, synonyms, etc.  
}
\usage{
DownloadHierarchy(MyEOLs, to.file=TRUE, database=NULL, verbose=TRUE)
ProviderCount(MyEOLs,verbose=FALSE)
BestProvider(MyEOLs)
}
\arguments{
	\item{MyEOLs}{A vector of filenames for downloaded EOL pages}
	\item{to.file}{Whether to download data to a file}
	\item{database}{Provider hierarchy information to use}
	\item{verbose}{An optional print statement during download}	
}

\value{
	XML file(s) downloaded to working directory.
}
\examples{
	#ProviderCount(MyEOLs, verbose=True)
	#BestProvider(MyEOLs)
	
	#DownloadHierarchy(MyEOLs, to.file=F, BestProvider(MyEOLs))
	
	#DownloadHierarchy(MyEOLs, "FishBase (Fish Species)")
}
