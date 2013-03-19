\name{DownloadSearchedTaxa}
\alias{DownloadSearchedTaxa}
\title{Download Page Content From EOL}
\description{
	This function will take a sting of taxa and search EOL database for the EOL pages. If it finds a match, it will download the EOL page.  
}
\usage{
DownloadSearchedTaxa(ListOfTaxa, MyKey=NULL, verbose=TRUE)
}
\arguments{
	\item{ListOfTaxa}{List of EOL taxa to search and download EOL pages}
	\item{MyKey}{An optional user identification key to identify yourself to EOL}
	\item{verbose}{An optional print statement during download}	
}
\details{
	To generate an api key, register with EOL and find it under your profile.  
}
\value{
	XML file(s) downloaded to working directory.
}
\examples{
	#DownloadSearchedTaxa("Anolis_carolinensis")
	#DownloadEOLpages(phy$tip.label, MyKey)
}
