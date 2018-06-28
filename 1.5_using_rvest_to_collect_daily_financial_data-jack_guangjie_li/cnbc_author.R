library("rvest")
rm(list=ls())
readurl0 <- function(url){
  out <- tryCatch(
    {
      read_html(url)
    },
    error=function(cond) {#not sure whether to add argument or not
      return(NA);
    }    
  )
  return(out);
}
startd=as.Date("2015-07-10")
endd=as.Date("2015-09-30")
fauthor=c("fred-imbert","evelyn-cheng")
#pstart=60;pend=66 #2017-06-01~2017-7-07 Fred
pstart=145;pend=154
kwords=c("Stocks","Nasdaq","Dow","S&P")#key words
nkwords=length(kwords)
sflink=rep("",(pend-pstart+1)*10);nsflink=1;#suspected links, assume 10 articles/page
for(ip in pstart:pend){
  pauthor=readurl0(paste0("https://www.cnbc.com/",fauthor[2],"/?page=",as.character(ip)))
  flink=pauthor%>%html_nodes("#pipeline_assetlist_0 .headline a")%>%html_attr("href")
  lflink=length(flink)
  for(i1 in 1:lflink){
    cdate=as.Date(gsub("/","-",substr(flink[i1],2,11)))
    if(cdate>startd&&cdate<endd){
      fpage=readurl0(paste0("https://www.cnbc.com",flink[i1]))
      ctitle=fpage%>%html_nodes(".twoCol .title")%>%html_text()
      mko=0;#judge whether the article is the market overview
      for(i2 in 1:nkwords){
        if(grepl(kwords[i2],ctitle)){
          mko=1;break;
        }
      }
      if(mko==1){
        fpath=paste0("D:/New/prg/cnbc/cnbc",gsub("-","",as.character(cdate)),".txt")
        if(!file.exists(fpath)){
          author=fpage%>%html_nodes(".source > a , .controlsLayer")%>%html_text()
          nauthor=length(author)
          atwitter=fpage%>%html_nodes(".twitter-url a")%>%html_text()
          ctextn=fpage%>%html_nodes("p")
          lctext=length(ctextn)
          csum=fpage%>%html_nodes("#article_deck li")%>%html_text()
          lcsum=length(csum)
          ctext=rep("",lctext-1+nauthor+lcsum)
          ctext[1]=paste0("https://www.cnbc.com",flink[i1]);
          ctext[3:(2+nauthor)]=author;ctext[2]=ctitle;  
          if(length(atwitter)!=0)ctext[(3+nauthor)]=atwitter;
          if(lcsum!=0)ctext[(4+nauthor):(3+nauthor+lcsum)]=csum
          for(i2 in 2:(lctext-3)){
            ctext[i2+2+nauthor+lcsum]=html_text(ctextn[i2])
          }
          fileConn<-file(fpath)
          writeLines(ctext, fileConn)
          close(fileConn)
        }else{
          sflink[nsflink]=paste0("https://www.cnbc.com",flink[i1])
          nsflink=nsflink+1  
        }
      }else{
        sflink[nsflink]=paste0("https://www.cnbc.com",flink[i1])
        nsflink=nsflink+1
      }
    }
  }
}
#wirte down the suspected links
fpath=paste0("D:/New/prg/cnbc/",gsub("-","",as.character(startd)),"-",gsub("-","",as.character(endd)),".txt")
fileConn<-file(fpath)
writeLines(sflink[1:nsflink], fileConn)
close(fileConn)