library(mice)

#library(VIM)

# md.pattern(df)
# aggr_plot <- aggr(newdf, 
#                  col=c('navyblue','red'), 
#                  numbers=TRUE, 
#                  sortVars=TRUE, 
#                  labels=names(df), 
#                  cex.axis=.7, 
#                  gap=3, 
#                  ylab=c("Histogram of missing data","Pattern"))



df$smoking_status <- as.character(df$smoking_status)
df[df$smoking_status=='','smoking_status'] <-'UNKNOWN'
df$smoking_status <- as.factor(df$smoking_status)

test$smoking_status <- as.character(test$smoking_status)
test[test$smoking_status=='','smoking_status'] <-'UNKNOWN'
test$smoking_status <- as.factor(test$smoking_status)

tempData <- mice(df,m=5,maxit=1,meth='pmm',seed=500)
summary(tempData)
tempData$meth
newdf<-complete(tempData, 1)

testTempData <- mice(test,m=5,maxit=1,meth='pmm',seed=500)
test<-complete(testTempData, 1)


#proc <- preProcess(df, method = "knnImpute")
#newdf <- predict(proc, newdata=df)
#newdf$stroke <- ifelse(newdf$stroke > 0,1,0)
#newdf <- df

# newdf[is.na(newdf$bmi),'bmi'] <- mean(newdf$bmi, na.rm = T)
#newdf[is.na(newdf$bmi),'bmi'] <- mean(newdf$bmi, na.rm = T)
newdf$stroke <- as.factor(newdf$stroke)
#table(df$stroke)
#table(newdf$stroke)

# idx <- createDataPartition(newdf$stroke, list=F, p=0.8, times=1)
# trainSet <- df[idx,]
# testSet <- df[-idx,]
