#collect daily market overview news from CNBC, assuming the address format is
#http://www.cnbc.com/yyyy/mm/dd/us-markets.html
library("rvest")
rm(list=ls())
readurl0 <- function(url){
    out <- tryCatch(
    {
        read_html(url)
    },
    error=function(cond) {
        return(NA);
    }    
    )
    return(out);
}
#valid in some periods in
#2015/07/10-2017/05/31 except 2016/12/30/
startd=as.Date("2015-07-10")
endd=as.Date("2015-09-30")
ndates=endd-startd
for(i0 in 0:ndates){
    cdate=as.character(startd+i0)
    cdate=gsub("-","/",cdate)
    htmla=paste("http://www.cnbc.com/",cdate,"/us-markets.html",sep='')
    cnbc=readurl0(htmla)
    if(!is.na(cnbc)){
        ctitle=cnbc%>%html_nodes(".twoCol .title")%>%html_text()
        author=cnbc%>%html_nodes(".source > a , .controlsLayer")%>%html_text()
	      nauthor=length(author)
        atwitter=cnbc%>%html_nodes(".twitter-url a")%>%html_text()
        ctextn=cnbc%>%html_nodes("p")
        lctext=length(ctextn)
        csum=cnbc%>%html_nodes("#article_deck li")%>%html_text()
        lcsum=length(csum)
        ctext=rep("",lctext-1+nauthor+lcsum)
        ctext[1]=htmla;ctext[3:(2+nauthor)]=author;ctext[2]=ctitle;
	      if(length(atwitter)!=0)ctext[(3+nauthor)]=atwitter;
        if(lcsum!=0)ctext[(4+nauthor):(3+nauthor+lcsum)]=csum
        for(i1 in 2:(lctext-3)){
            ctext[i1+2+nauthor+lcsum]=html_text(ctextn[i1])
        }
        cdate=gsub("/","",cdate)
        fpath=paste("D:/New/prg/cnbc/cnbc",cdate,".txt",sep="")
        fileConn<-file(fpath)
        writeLines(ctext, fileConn)
        close(fileConn)
    }
}
