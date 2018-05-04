

vcf.header <- function(vcf) {
  vcf <- gsub(pattern = "\\s+(.*)",replacement = "\\1",vcf)
  # readLines(gzcon(file("your_file.txt.gz", "rb")))
  con = file(vcf, "r")
  line = readLines(con, n = 1)
  c <- 0
  while ( substring(line[1], 1, 1) == "#" ) {
    c <- c + 1
    line = readLines(con, n = 1)
    if ( length(line) == 0 ) {
      break
    }
    if (any(grep("#CHR", line))){
      b.s <- strsplit(line,"\t")
      break
    }
  }
  close(con)
  print(c)
  if(class(b.s) == "list") {
    return(unlist(b.s))
  } else {
    return(b.s)
  }
}
