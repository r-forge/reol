\name{DownloadHierarchy}
\alias{DownloadHierarchy}
\title{Download Hierarchy Content From Contributors}
\description{
	This function will use the results dataframe to find the contributor information.  Hierarchies get downloaded as "hier" pages rather than "eol" pages.  
}
\usage{
DownloadHierarchy(Results, database="calc", verbose=T)
}
\arguments{
	\item{Results}{Results dataframe from GatherResultsDataFrame}
	\item{database}{Contributor information to use, see function for list}
	\item{verbose}{An optional print statement during download}	
}
\value{
	XML file(s) downloaded to working directory.
}
\examples{
	#DownloadHierarchy(Results, "calc")
}
