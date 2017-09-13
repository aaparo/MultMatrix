library(rmr2)

map = function(.,val){
  
  left = val[1:m.row,]
  right = val[(m.row+1):nrow(val),]
  
  #Left
  tmp = expand.grid(i=1:nrow(left),k=1:ncol(right),j=1:ncol(left))
  tmp = cbind(tmp, element=apply(tmp,1,function(x,left) (left[x["i"],x["j"]]), left),matrix="isLeft")
  Val = tmp[,c(-1,-2)]
  Key = tmp[,c(1,2)]
  #Right
  tmp = expand.grid(j=1:nrow(right),k=1:ncol(right),i=1:ncol(left))
  tmp = cbind(tmp,element=apply(tmp,1,function(x,right) (right[x["j"],x["k"]]), right),matrix="isRight")
  Val = rbind(Val,tmp[,c(-2,-3)])
  Key = rbind(Key,tmp[,c(3,2)])
  
  keyval(Key,Val)
  
}


reduce= function(key, val){
  #val -> matrix 4x3
  listM= subset(val, val[,"matrix"]=="isLeft")
  listN= subset(val, val[,"matrix"]=="isRight")
  listM= listM[order(as.integer(listM[,"j"])),] 
  listN= listN[order(as.integer(listN[,"j"])),]
  

  element=0
  for (i in 1:nrow(listM))
  {
    element = element+ as.integer(listM[i,"element"])*as.integer(listN[i,"element"]) 
  }
  
  keyval(key,element)
  
}


prodMN = function(M,N)
{
  m.row <<- nrow(M)
  A = rbind(M,N)
  A.index = to.dfs(A)

  mult = 
    from.dfs(
      mapreduce(
        input = A.index,
        map = map,
        reduce = reduce
      ))
  
  return (matrix(mult$val, ncol = ncol(M),byrow = T))
  
}

