\name{DownloadHierarchy}
\alias{DownloadHierarchy}
\alias{ProviderCount}
\alias{BestProvider}
\title{Download Hierarchy Content From Contributors}
\description{
	This function will use the EOL pages to find the provider information.  Hierarchies get downloaded as "hier" pages rather than "eol" pages. Providers contribute information on taxonomic rankings, hierarchical tree structure, synonyms, etc.  
}
\usage{
DownloadHierarchy(MyEOLs, from.file=T, to.file=T, database=NULL, verbose=TRUE)
ProviderCount(MyEOLs, from.file=T, verbose=FALSE)
BestProvider(MyEOLs, from.file=T)
}
\arguments{
	\item{MyEOLs}{A vector of filenames for downloaded EOL pages}
	\item{from.file}{Whether MyEOLs is an existing file}
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
	
	#DownloadHierarchy(MyEOLs, from.file=F, to.file=F, BestProvider(MyEOLs))
	
	#DownloadHierarchy(MyEOLs, "FishBase (Fish Species)")
}
