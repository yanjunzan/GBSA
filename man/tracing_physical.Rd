\name{tracing_physical}
\alias{tracing_physical}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
This function directly work on the intermediated files and calculating the averaged number in each bin
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
tracing_physical(input,bin,chr.len,cut)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{input}{ input a data frame with genotype on individuals, this is the out put from read}
  \item{bin}{ size of the bin}
  \item{chr.len}{ length of the current chrommsome}
  \item{chr.len}{ below this threshold, NA is inferred}

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
return a vector of the averaged values
}
\references{
Yanjun Zan, Thibaut Payen, Leif Andersson, Paul B. Siegel and Örjan Carlborg;Whole-genome QTL mapping in experimental pedigrees from outbred founders utilizing low coverage individual based sequencing 2018
}
\author{
%%  ~~who you are~~
}
\note{
Yanjun Zan, Thibaut Payen
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
