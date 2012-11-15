changeKingdomsToNumbers<-function(ListOfKingdoms){
	l<-ListOfKingdoms
	for(i in sequence(length(l))){
		if(l[i] == "Animalia") l[i]<-1
		if(l[i] == "Plantae") l[i]<-2
		if(l[i] == "Bacteria" || l[i] == "Cellular organisms") l[i]<-3
		if(l[i] == "Fungi") l[i]<-4
		if(l[i] == "Protozoa") l[i]<-5
	}
	return(l)
}
