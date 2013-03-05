DownloadEOLpages <- function(pages, MyKey) {
#Download xml page content  #now full content using X=75
  for (i in sequence(length(pages))){
    pageNum<-pages[i]
    print(i)
    #system(paste("curl 'http://eol.org/api/pages/", pageNum, ".xml?key=", MyKey, "&images=75&videos=75&sounds=75&maps=75&text=75&iucn=1'", " -o eol", pageNum,".xml -a", sep=""))
	web <- paste("http://eol.org/api/pages/", pageNum, ".xml?key=", MyKey, "&images=75&videos=75&sounds=75&maps=75&text=75&subjects=all&details=true&common_names=true&references=true", sep="")	
    a <- getURL(web)
    #save these into files somehow

    Sys.sleep(1)
	}
}
