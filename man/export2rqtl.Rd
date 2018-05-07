\name{export2rqtl}
\alias{export2rqtl}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
A function transform the output from this package to Rqtl
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
export2rqtl(genoFile,phenoFile,matchingNames,output.name)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{genoFile}{Genotype matrix output from this package}
  \item{phenoFile}{A datafram with 3 or more column as ID,sex,family id, phentpye1,...ID names have to match the ID names in genotype file}
  \item{matchingNames}{The genome information from ncbi}
  \item{output.name}{full path and file name for output file}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
This function output a .csv file with name and path specified by output.name argument
}
\references{
Yanjun Zan, Thibaut Payen, Leif Andersson, Paul B. Siegel and Örjan Carlborg;Whole-genome QTL mapping in experimental pedigrees from outbred founders utilizing low coverage individual based sequencing 2018
}
\author{
Yanjun Zan, Thibaut Payen
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
