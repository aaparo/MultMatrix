library("Rmpi")

ns = 7 
mpi.spawn.Rslaves(nslaves =  ns)

M = matrix(c(110,210,120,220), nrow = 2)
N = matrix(c(11,21,12,22), nrow = 2)

result = mpi.parMM(M,N)

mpi.close.Rslaves()
