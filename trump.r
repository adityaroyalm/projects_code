library(ggplot2)
df1=read.csv('approval_topline.csv')
df2=read.csv('approval_polllist.csv')
df1=df1[,-1]
dfm=subset(df1,subgroup=='Adults')
ts1=ts(dfm['approve_estimate'])
ggplot(data=dfm, aes(as.Date(dfm$modeldate,'%m/%d/%Y'),dfm$approve_estimate))+geom_line()+geom_point()+xlab('date')+ylab('Adult_approval') 
dfm=subset(df1,subgroup=='Voters')
ggplot(data=dfm, aes(as.Date(dfm$modeldate,'%m/%d/%Y'),dfm$approve_estimate))+geom_line()+geom_point()+xlab('date')+ylab('Voters_approval')
dfm=subset(df1,subgroup=='All polls')
ggplot(data=dfm, aes(as.Date(dfm$modeldate,'%m/%d/%Y'),dfm$approve_estimate))+geom_line()+geom_point()+xlab('date')+ylab('All polls_approval') 
df2=df2[-3842,]
ggplot(data=df2, aes(as.Date(df2$startdate,'%m/%d/%Y'),df2$final))+geom_line()+geom_point()+xlab('date')+ylab('All polls_approval') 

a=df2
check=NULL
ans=NULL
'%!in%'=Negate('%in%')
for (i in 1:length(a$president)){
  if (as.character(a[i,'pollster']) %!in% check){
    check=append(as.character(a[i,'pollster']),check)
    ans=append(as.character(df2[i,'startdate']),ans)
  }}
df2$final=df2$weight*df2$adjusted_approve
library(plyr)
df2$enddate=as.character(df2$enddate)
fun=aggregate(final~enddate,df2,mean)
df3=df2[,c('weight','approve','adjusted_approve','disapprove','adjusted_disapprove','pollster')]
weigh=aggregate(.~pollster,df3,mean)
party=NULL
ans=ans[-1]
check=check[-1]
for (i in 1:length(check)){
  party=append(df2[(df2$startdate==ans[i]) & (df2$pollster==check[i]),c('weight','approve','adjusted_approve','disapprove','adjusted_disapprove')],party)
}
nmn=split(party,f=names(party),data.frame)
part1=do.call('rbind',lapply(list(unname(sapply(nmn[[1]],'[[',1))),data.frame))
part2=do.call('rbind',lapply(list(unname(sapply(nmn[[2]],'[[',1))),data.frame))
part3=do.call('rbind',lapply(list(unname(sapply(nmn[[3]],'[[',1))),data.frame))
part4=do.call('rbind',lapply(list(unname(sapply(nmn[[4]],'[[',1))),data.frame))
part5=do.call('rbind',lapply(list(unique(unname(sapply(nmn[[5]],'[[',1)))),data.frame))
checkdf=do.call('rbind',lapply(check,data.frame))
party_check=cbind(part1,part2,part3,part4,part5,checkdf)
colnames(party_check)=c('int_adjusted_approve','int_adjusted_disapprove','int_approve','int_disapprove','int_weight','pollster')
ik=merge(party_check,weigh,by='pollster' )
ggplot(data=ik,aes(c(1:40)))+geom_line(aes(y=ik$int_weight,colour='int_weight'))+xlab('pollsters')+ylab("initial_weights")+geom_line(aes(y=ik$weight,colour='weight'))+xlab('pollsters')+ylab("weights")
source('multiplo.R')
multiplot(p1,p2)
#statistical testdf3=s
library('nortest')
ad.test(df3[,2])
df4=data.frame()
a=rep(list(rep(list(0),length(row.names(ik)))),length(colnames(ik))-1)
for (i in 2:length(colnames(ik))){
  for (x in 1:length(row.names(ik))){
    a[[i-1]][x]=mean(sample(ik[,i],10))
    }
}
ad.test(unlist(a[[2]]))

dfdf=as.data.frame(matrix(rep(list(0),410),nrow=10))
for (i in 1:41){
  dfdf[,i]=data.frame(sapply(a,'[[',i))
  }
dfdf=t(dfdf)
colnames(dfdf)=colnames(ik[,-1])
colnames(df555)=colnames(ik[,-1])
t.test(dfdf[,"int_adjusted_approve"],dfdf[,"adjusted_approve"])
#t.test(dfdf[,"int_adjusted_approve"],dfdf[,"int_adjusted_disapprove"])
t.test(dfdf[,"int_weight"],dfdf[,"int_weight"])####satified)
t.test(dfdf[,"int_adjusted_disapprove"],dfdf[,"adjusted_disapprove"])
t.test(dfdf[,"int_approve"],dfdf[,"approve"])
#t.test(dfdf[,"int_approve"],dfdf[,"int_disapprove"])
dfm$diff=dfm$disapprove_estimate-dfm$approve_estimate
#ts.plot(df1$diff)
dfm$lag=c(diff(dfm$diff,1),0)
ggplot(data=dfm, aes(as.Date(dfm$modeldate,'%m/%d/%Y'),dfm$lag))+geom_line()+xlab('date')+ylab('lag_1') 
ts.plot(dfm$lag)
