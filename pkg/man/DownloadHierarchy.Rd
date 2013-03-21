\name{DownloadHierarchy}
\alias{DownloadHierarchy}
\alias{ProviderCount}
\alias{BestProvider}
\title{Download Hierarchy Content From Contributors}
\description{
	This function will use the EOL pages to find the provider information.  Hierarchies get downloaded as "hier" pages rather than "eol" pages. Providers contribute information on taxonomic rankings, hierarchical tree structure, synonyms, etc.  
}
\usage{
DownloadHierarchy(MyFiles, database=NULL, verbose=TRUE)
ProviderCount(MyFiles, verbose=FALSE)
BestProvider(MyFiles)
}
\arguments{
	\item{MyFiles}{A vector of filenames for downloaded EOL pages}
	\item{database}{Provider hierarchy information to use}
	\item{verbose}{An optional print statement during download}	
}

\value{
	XML file(s) downloaded to working directory.
}
\examples{
	#ProviderCount(MyFiles, verbose=True)
	#BestProvider(MyFiles)
	
	#DownloadHierarchy(MyFiles, BestProvider(MyFiles))
	#DownloadHierarchy(MyFiles, "FishBase (Fish Species)")
}
