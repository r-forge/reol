\name{GetReferences}
\alias{GetReferences}
\title{Gather EOL References}
\description{
	This function gathers the references on the EOL pages (not the references on the provider pages). 
}
\usage{
GetReferences(MyEOLs, output = c("detail", "counts"))
}
\arguments{
	\item{MyEOLs}{A vector of filenames or a list of XMLs for downloaded EOL pages}
	\item{output}{"detail" will return a data frame with eolID and reference; "counts" will return a dataframe with  eol taxon name, eol ID, and number of references.}
}
\value{
	Returns a data frame with taxon, eol ID, common name, and language. 
}
\examples{
data(MyEOLs)
GetReferences(MyEOLs[[1]], output="detail")
GetReferences(MyEOLs, "c")
}
