\name{DownloadHierarchy}
\alias{DownloadHierarchy}
\title{Download Hierarchy Content From Contributors}
\description{
	This function will use the results dataframe to find the contributor information.  Hierarchies get downloaded as "hier" pages rather than "eol" pages.  
}
\usage{
DownloadHierarchy(MyFiles, database="calc", verbose=T)
}
\arguments{
	\item{MyFiles}{A vector of filenames for downloaded EOL pages}
	\item{database}{Provider hierarchy information to use}
	\item{verbose}{An optional print statement during download}	
}
\value{
\details{
	There are currently two choices for database.  "calc" is the default, and will download the database with the most taxonomic coverage.  If there is more than one, it will only use the first in the list.  The second option is to be "user.defined".  This option will display all of the 
}
	XML file(s) downloaded to working directory.
}
\examples{
	#DownloadHierarchy(Results, "calc")
}
