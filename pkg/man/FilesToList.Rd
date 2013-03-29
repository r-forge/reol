\name{FilesToList}
\alias{FilesToList}
\title{Combine File Data}
\description{
	This function accepts a list of xml pages and combined it into a single R object.
}
\usage{
FilesToList(MyFiles)
}
\arguments{
	\item{MyFiles}{A vector of filenames for downloaded EOL or hierarchy pages}
}
\value{
	Returns a list of xml files, with each entry in the list being a single xml page. 
}
\examples{
	#FilesToList(c("eol1.xml", "eol2.xml", "eol3.xml"))
}
