\name{arbitrary.cut}
\alias{arbitrary.cut}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
A function transform the averaged score in to genotypes based on arbitrary cutoff.
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
arbitrary.cut(geno,  upper.cut,  lower.cut)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{geno}{ the genotype matrix returned from creatExact function}
  \item{ upper.cut}{ threshold for calling  homozygous genotype,  0.8 is a good strat to try}
  \item{ lower.cut}{ threshold for calling  homozygous alternative genotype,  0.2 is a good strat to try}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
return a data.frame with each bin transformed to "A" for homozygous and "B" for alternative genotype, "H" for heterozygous
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
See the package tutorial
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
