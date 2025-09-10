IVSS<- function(model,observed){
  a<- apply(model,2,IQR,na.rm=TRUE)
  b<- apply(observed,2,IQR,na.rm=TRUE)
  c<- a/b
  d<- b/a
  n<- length(c)
  e<- sum((c-d)^2)
  f<- e/n
  return(f)
}

