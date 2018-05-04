calculate.origin.phy <- function(x,index.pos=index.pos,cut){
  ratio <- function(x) {
    if(length(x) > cut ){
      return(sum(x)/length(x))
    }else{
      return(NA)
    }
  }
  num.mrk <- tapply(X = x, INDEX = index.pos, FUN = function(x) length(x))
  ratio.mrk <- tapply(X = x, INDEX = index.pos, FUN = ratio )
  return(list("num.mrk"=num.mrk,"ratio.mrk"=ratio.mrk))
}

tracing_physical <- function(input,bin,chr.len,cut){
  if(!require(zoo))
    require(zoo)
  # We assume f1 == f2 AND f1 != m1 AND m1 == m2
  trace.of1 <- input[,"f1"] - input$of1
  trace.of2 <- input[,"f1"] - input$of2
  trace.of <- abs(trace.of1 + trace.of2)/2
  num.bin <- chr.len/bin
  bin.loca <- seq(0,chr.len,by=bin)+1
  index.pos <- findInterval(input$pos,bin.loca)
  # Because of High coverage need to check of1 and of2 (if low coverage replace trace.of1 and comment 2 lines)
  out <- calculate.origin.phy(x = trace.of, index.pos = index.pos,cut=cut)
  f <- as.numeric(out$ratio.mrk)
  #m <- as.numeric(calculate.origin.phy(x = trace.mat1$m1, index.pos = index.pos,cut=cut)$ratio.mrk)
  fn <- as.numeric(out$num.mrk)
  loca <- (sort(unique(index.pos),decreasing = F)*bin - 0.5*bin)
  ##return(list("f"=f,"m"=m,"fn"=fn,"loca"=loca))
  return(list("f"=f, "fn"=fn, "loca"=loca))
}

