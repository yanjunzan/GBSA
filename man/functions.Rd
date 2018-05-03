#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
\name{vcf.header}
\alias{vcf.header}

\title{
Check the header of vcf files,extract the individual names
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{

vcf.header2 <- function(vcf) {
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


}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{
%%     ~~Describe \code{x} here~~
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
%%  ~~who you are~~
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (x)
{
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
