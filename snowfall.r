library("snowfall")

sfInit(parallel=TRUE, cpus=2, type="MPI")

M = matrix(c(110,210,120,220,2,2,2,2,2,2,2,2,2,2), nrow = 2)
N = matrix(c(11,21,12,22,2,2,2,2,2,2,2,2,2,2), nrow = 7)
sfExport("M","N")
R = t(sfApply(M, 1, function(x) x%*%N))
#R2= sfMM(M,N)
sfStop()
