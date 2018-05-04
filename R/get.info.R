############
get.info <- function(chroms,chroms.len,bin.size=1e6){
  num.bin <- rep(NA,length(chroms))
  index <- data.frame(array(NA,dim = c(length(chroms),2)))
  colnames(index) <- c("start","end")
  rownames(index) <- chroms
  num.bin <- ceiling(chroms.len/bin.size)
  names(num.bin) <- chroms

  if(any(num.bin==1))
    warnings("a few chr only have one bin, start and end are set to the same","\n")

  index$start[1] <- 1
  index$end[1] <- num.bin[1]
  loca <- seq(from = 0.5,to =num.bin[1])
  loca.chr <- rep(chroms[1] , num.bin[1])
  for( i in 2:length(chroms)){
    index$start[i] <- sum(num.bin[1:c(i-1)])+1
    index$end[i] <- sum(num.bin[1:i])
    loca <- c(loca,seq(from = 0.5,to =num.bin[i]))
    loca.chr <- c(loca.chr,rep(chroms[i],num.bin[i]))
  }
  chr.loca <- rep(NA,max(index$end))
  for( i in 1:length(loca)){
    chr.loca[i] <- paste(loca.chr[i],"-",loca[i],sep = "")
  }
  return(list("num.bin" = num.bin,"index"=index,"loca"=loca,"loca.chr"=loca.chr,"chr.loca"=chr.loca))
}
