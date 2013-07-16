\name{DownloadEOLpages}
\alias{DownloadEOLpages}
\title{Download Page Content From EOL}
\description{
	This function will take a EOL page number(s) and download all the page content and save it as an xml file in the working directory.  
}
\usage{
DownloadEOLpages(pages, to.file=T, MyKey=NULL, verbose=TRUE)
}
\arguments{
	\item{pages}{EOL page numbers to download}
	\item{to.file}{Whether to download data to a file}
	\item{MyKey}{An optional user identification key to identify yourself to EOL}
	\item{verbose}{An optional print statement during download}
}
\details{
	To generate an api key, register with EOL and find it under your profile.  
}
\value{
	XML file(s) downloaded to working directory or saved to the workspace as an R object.
}
\examples{
	#DownloadEOLpages(pages=SeriesOfNumbers, to.file=F, MyKey=000123)
	#DownloadEOLpages(1045608, T)
}
