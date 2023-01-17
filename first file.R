## Profiling allows you understand how long each piece of code takes to run 

###############################
###system.time function start##
###############################
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
###############################
###system.time function end####
###############################


##########################
###rprof function start###
##########################
## Rprof() function starts the profiler in R
## summaryRprof() function summarizes the output from rprof() and tabulates how much time is spent in each function (otherwise it's not readable)
## Rprof keeps track of the function call stack at regularly timed intervals 
## NOTES: (1)Do not use system.time() and Rprof() together (2) If code runs very quickly, profiler will not be useful (do not use it)
## Rprof simply returns the function call stack at .02 second intervals 
## summaryRprof uses that raw output and calculates how much time is spent in each function 
## summaryRprof uses two methods:
## (1) by.total divides the time spent in each function by the total run time (this just gives us amount of time spent in top level function, but in reality the top level function may be spending a lot of time calling lower level functions)
## (2) by.self does the same but first subtracts out time spent in functions above in the call stack (this gives us the amount of time spent in the top level function but subtracting out all the function that it calls (lower level functions))
## by.self gives a more accurate representation of the time spent in each function in the call function call stack (helps identify bottlenecks in the code)
## summaryRprof() gives 4 outputs: (1) by.total (2) by.self (3) sample.interval- what time interval was used to print call stacks  (4) sampling.time- total amount of time expression took the run (equivalent to elapsed time in system.time function)


##########################
###rprof function end#####
##########################