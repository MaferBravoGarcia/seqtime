% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plotA.R
\name{plotA}
\alias{plotA}
\title{Plot an interaction matrix.}
\usage{
plotA(A, method = "image", header = "", scale.weight = FALSE,
  original = FALSE, setNAToZero = FALSE, pos.link.color = "green",
  neg.link.color = "red", removeOrphans = TRUE, removeLoops = FALSE,
  returnNetwork = FALSE)
}
\arguments{
\item{A}{interaction matrix}

\item{method}{image, ggplot or network (ggplot requires ggplot2 and reshape2, image is therefore default), image and ggplot will plot the matrix, network will plot the network with igraph}

\item{header}{the title of the plot (does not apply to method network)}

\item{scale.weight}{scale interaction strengths between -1 and 1 (does not apply to method network)}

\item{original}{plot original values (does not apply to method network)}

\item{setNAToZero}{set missing values to zeros}

\item{pos.link.color}{color of positive edges}

\item{neg.link.color}{color of negative edges}

\item{removeOrphans}{remove orphan nodes (method network)}

\item{removeLoops}{remove loops (method network)}

\item{returnNetwork}{return the network for manual adjustment with tkplot (method network)}
}
\description{
By default, the interaction strengths are set to -1 or 1. Negative values
are plotted in red, positive in green. If scale.weight is true, the interaction
strengths are scaled to lie in the range of [-1,1]. The option original suppresses
any modification of the interaction strengths. If interaction strengths are scaled or the original
ones are used, the method ggplot is recommended, since it adds a color legend.
Alternatively, the interaction matrix can also be visualized as a directed network with method network.
In this case, the igraph network object is returned, to allow for manual adjustment of the layout with igraph's tkplot function.
Method network recognizes separate taxon name columns in unmerged taxon matrices.
Method ggplot requires ggplot2 and reshape2.
}
\examples{
plotA(generateA(20,c=0.1))
}
