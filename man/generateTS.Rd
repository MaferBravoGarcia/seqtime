% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/generateTS.R
\name{generateTS}
\alias{generateTS}
\title{Generate community time series}
\usage{
generateTS(N = 100, I = 1500, tend = 100, initAbundMode = 5,
  c = 0.05, clique.size = 5, sigma = 0.05, theta = 0.002,
  Atype = "klemm", Atweak = "tweak", d = -1, PEP = 30, m = 0.02,
  deathrate = 10, algorithm = "dm", interval = 1,
  output.folder = "", output.expId = "", input.folder = "",
  input.expId = "", read.A = FALSE, read.y = FALSE, read.K = FALSE,
  read.extinct = FALSE, read.ts = FALSE, maxIter = 10)
}
\arguments{
\item{N}{species number (for hubbell, refers to the species number in the metacommunity)}

\item{I}{individual number (only for SOI and hubbell)}

\item{tend}{the number of time points to generate}

\item{initAbundMode}{the mode in which initial abundances are generated (described in function generateAbundances)}

\item{c}{connectivity of interaction matrix (only for SOI, ricker and gLV)}

\item{clique.size}{parameter for interaction matrix generation (only for SOI, ricker and glv and Atype mode klemm)}

\item{sigma}{noise term (only for ricker)}

\item{theta}{Dirichlet-Multinomial overdispersion parameter (only for dm)}

\item{Atype}{method to generate the interaction matrix (described in function generateA)}

\item{Atweak}{tweaking method for instable interaction matrix, either tweak (convert positive into negative arcs until the matrix is stable or one third of the positive arcs have been converted) or schur (apply Schur decomposition, does not guarantee a stable matrix)}

\item{d}{diagonal value of the interaction matrix}

\item{PEP}{positive edge percentage of interaction matrix (only for SOI, ricker and gLV)}

\item{m}{immigration rate (only for hubbell)}

\item{deathrate}{number of individuals that are replaced at each time step (only for hubbell)}

\item{algorithm}{how time series should be generated (can be hubbell, soi, ricker, glv, dm, davida or davidb)}

\item{interval}{sampling frequency (if 1, each sample is taken, if 2, every second sample is taken etc.)}

\item{output.folder}{(optional) path to result folder, if specified, input parameter and time series are exported to the output folder}

\item{output.expId}{(optional) the identifier of the time series generation experiment}

\item{input.folder}{(optional) the folder from which previously generated parameters can be read}

\item{input.expId}{(optional) the identifier of a previous experiment whose results will be read}

\item{read.A}{read the interaction matrix from the given previous experiment}

\item{read.y}{read the initial abundances/SOI immigration rates from the given previous experiment (for hubbell, initial abundances refer to the metacommunity)}

\item{read.K}{read the carrying capacities/growth rates from the given previous experiment}

\item{read.extinct}{read the SOI extinction rates from the given previous experiment}

\item{read.ts}{read the previously generated time series from the given previous experiment}

\item{maxIter}{maximal iteration number for finding a stable interaction matrix}
}
\value{
list containing the generated interaction matrix, initial abundances (they double as immigration probabilities for soi and metapopulation proportions for hubbell), carrying capacities (they double as growth rates for glv), extinction probabilities, time series and settings
}
\description{
Wrapper function for time series generation.
The result folder has a specific structure that is
created if it does not yet exist. It has two
sub-folders, one named timeseries and the other
settings. In both sub-folders, there are folders
having as name the experiment identifier followed by
timeseries or settings. The interaction matrix,
immigration and extinction rates, carrying capacities
and other randomly generated input are also
stored in settings. The idea is that the time
series can be re-created from the information
stored in the settings folder (though not
exactly, since the SOI, Ricker and neutral models have random components).
Furthermore, a plot of the time series and (if required by the model) the interaction
matrix is stored in settings, for control. Properties of the interaction matrix
are also stored there.
}
\details{
On the random generation of parameter values:
Extinction rates are sampled from the uniform distribution
with values between 0 and 1. Carrying capacities/growth rates are sampled
from the uniform distribution with values between 0 and 0.5.
On the implementation of the neutral model: simHubbell is used to generate
neutral model time series. The 1000 first time points of the simulation are always skipped.
The species number of the local community is set to 1/10th of the species number in the
metacommunity. The local community is initialized with even abundances.
On the interaction matrix:
When the positive edge percentage is modified, symmetry is not enforced. The maximal
absolute interaction strength in the interaction matrix is set to 1.
Interaction matrix stability is tested with method "ricker", using an
explosion bound of 10^8. For interaction stabilizing method tweak, conversion of positive into negative
arcs is stopped when more than a third of the positive arcs were converted already.
On the stool data:
The stool data are processed as follows: for stool data set B, the last time point is omitted.
The data are rarefied to 10000 reads per sample, omitting samples with insufficient read numbers.
Then, using metadata on sampling days, values for missing days are interpolated with method stineman.
The top-abundant 100 taxa (according to their sum across samples) are retained and small negative values
introduced by the interpolation are set to zero.
Other settings:
For initial abundance mode 6, k is set to 0.5.
The simulation step size is always 1 (larger intervals are introduced after simulation).
Dirichet-Multinomial data are generated with a count number of 1000 per sample.
}
