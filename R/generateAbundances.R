#' @title Generate Abundance Vector
#'
#' @description Generate a vector of taxon abundances.
#'
#' @details The taxon abundance vector can be used as initial abundance vector in models.
#' Note: The geometric series (a niche apportionment model) is for instance described in
#' "Comments about some species abundance patterns: classic, neutral, and niche partitioning models" by
#' Ferreira and Petrere-Jr., Braz. J. Biol. 2008
#'
#' @param N number of species
#' @param count total number of individuals (ignored in mode 2, 4 and 7)
#' @param mode 1=each species receives round(count/N) counts, 2=sampled from uniform distribution with 0 as lower and count as upper bound, 3=dominant species takes 95 percent of the counts and all others split the remaining counts equally, 4=counts are sampled from a Poisson distribution with lambda set to count/N, 5=using bstick function from vegan, 6=using geometric series with parameter k, 7=sample from the exponential distribution and scale with count/N
#' @param k evenness parameter of geometric series (the smaller, the more even is the abundance vector)
#' @param probabs if true, return probabilities instead of abundances
#' @return species abundances
#' @examples
#'   x <- round(generateAbundances(10, mode=6))
#' @seealso \code{\link{simCountMat}}
#' @export
generateAbundances <- function(N, count=1000, mode=1, k=0.5, probabs=FALSE){
  if(N < 1){
    stop("N should be at least 1.")
  }
  if(count < 1){
    stop("count should be at least 1.")
  }
  if(k > 1 || k < 0){
    stop("k should be a number between 0 and 1.")
  }
  if(!is.wholenumber(mode)){
    stop("The mode should be an integer between 1 and 7")
  }
  if(mode == 1){
    y=rep(round(count/N),N)
  }else if(mode == 2){
    y=runif(N,min=0,max=count)
  }else if(mode == 3){
    dominant=0.95*count
    commoner=0.05*count/(N-1)
    y=c(dominant,rep(commoner,(N-1)))
  }else if(mode == 4){
    y=rpois(N,lambda=(count/N))
  }else if(mode == 5){
    y=vegan::bstick(N,count)
  }else if(mode == 6){
    y=c()
    C = 1/(1 - ((1-k)^N))
    for(i in 1:N){
      y=c(y,count*C*k*(1-k)^(i-1))
    }
  }else if(mode == 7){
    # Draw from exponential since the slope is less steep and hence conservative
    # and round to closest integer
    y <- 1 + round(rev(sort(rexp(N))))
    y=y*(count/N)
  }else{
    stop("Available modes: 1, 2, 3, 4, 5, 6 or 7")
  }
  if(probabs == TRUE){
    y = y/sum(y)
  }
  return(y)
}

##############################################################################
# Check whether a number is an integer.
#
# Argument:
# x = number
# tol = tolerance
#
# Value:
# boolean true if number is an integer within the tolerance, false otherwise
#
# Note: function taken from http://stackoverflow.com/questions/3476782/how-to-check-if-the-number-is-integer
#
##############################################################################
is.wholenumber <- function(x, tol = .Machine$double.eps^0.5)  abs(x - round(x)) < tol
