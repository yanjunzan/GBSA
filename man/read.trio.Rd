\name{read_trio}
\alias{read_trio}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
format the parental genotype in vcf file
}
\description{
Give two parental ID in a divergent cross, this function screen the called sites
}
\usage{
read_trio(of_id,F_id,M_id,vcf.file,pathout,generate.input)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{of_id}{offspring ID in the vcf file}
  \item{F_id}{one of the parental ID in the vcf file,does not have to be father line id}
  \item{M_id}{one of the parental ID in the vcf file,does not have to be mother line id}
  \item{vcf.file}{the input vcf, this file should be filtered in advance to  make sure only fixed sites between lines are included}
  \item{pathout}{out put path}
  \item{generate.input}{ T means only generate intermediate files, F means read in the intermediate file}
}
\details{
We recommend a two step run: i) turn on generate.input to create the intermediate file only; ii) turn off the generate.input to read in the data.
}
\value{
return a data.table object with gentoype of the divergent lines and this indiviudal in columns. Each row is a site which is fixed between parental and has genotype call for this particular offspring.
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
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
