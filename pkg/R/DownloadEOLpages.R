DownloadEOLpages <- function(pages, MyKey=NULL) {
#Download xml page content  #now full content using X=75
  for (i in sequence(length(pages))){
    pageNum<-pages[i]
    web <- paste("http://eol.org/api/pages/", pageNum, ".xml?images=75&videos=75&sounds=75&maps=75&text=75&subjects=all&details=true&common_names=true&references=true", sep="")	
	if(!is.null(MyKey))
      web <- paste(web, "&key=", MyKey, sep="")
    a <- getURL(web)
    saveXML(xmlRoot(xmlTreeParse(a)), file=paste("eol", pages[i], ".xml", sep=""))
    Sys.sleep(1)
  }
}
