## Profiling allows you understand how long each piece of code takes to run 

## system.time function: takes an R expression as input, and returns the amount of time (in seconds) taken to evaluate the expression 
## user time = time charged to the CPU for this expression
## elapsed time = wall clock time 

## elapsed time < user time
## bulk of the time is from waiting for the network to load the webpage 
system.time(readLines("http://jhsph.edu"))

## user time > elapsed time 
hilbert <- function(n){
  i <- 1:n
  1 / outer(i-1, i, "+")
}
## create a hilbert matrix
x <- hilbert(1000)

## Calculate the singular value compisition with svd function
## svd function uses multiple cores of the CPU 
system.time(svd(x))

## We can time longer expressions 
## Example timing a for loop 
system.time({
  n <- 1000
  r <- numeric(n)
  for (i in 1:n){
    x <-rnorm(n)
    r[i]<- mean(x)
  }
})
r