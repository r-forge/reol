\name{DownloadEOLpages}
\alias{DownloadEOLpages}
\title{Download Page Content From EOL}
\description{
	This function will take a EOL page number(s) and download all the page content and save it as an xml file in the working directory.  
}
\usage{
DownloadEOLpages(pages, MyKey, verbose=T)
}
\arguments{
	\item{pages}{EOL page numbers to download}
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
	#DownloadEOLpages(1045608)
	#DownloadEOLpages(SeriesOfNumbers, MyKey)
}
