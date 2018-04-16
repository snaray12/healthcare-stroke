library(caret)

ctrl<-trainControl(method='cv', 
                   number=3, 
                   returnResamp='none'
#                   summaryFunction = twoClassSummary, 
#                   classProbs = TRUE
                   )

outcomeName <- 'stroke'
predictorsNames <- names(trainSet)[names(trainSet) != outcomeName]

lmCVFit<-train(trainSet[,-12],
               trainSet[,12],
               method = "glm",
               family=binomial(),
               trControl = ctrl,
               metric="roc")

summary(lmCVFit)
prob=predict.glm(lmCVFit,type=c("response"))
predicted <- predict(lmCVFit)

residuals <- resid(lmCVFit)

plot(trainSet$stroke, residuals)
varImp(lmCVFit)
plot(varImp(lmCVFit))

library("ROCR")    
pred <- prediction(predicted, labels = trainSet$stroke )
perf <- performance(pred, measure = "tpr", x.measure = "fpr")     
plot(perf, col=rainbow(7), main="ROC curve Admissions", xlab="Specificity", 
     ylab="Sensitivity")    
abline(0, 1) #add a 45 degree line

predictions <- predict.train(lmCVFit, testSet, type="raw")

bin_predictions <-ifelse(predictions>0.5,1,0)

table(bin_predictions)
prop.table(table(bin_predictions))

confusionMatrix(lmCVFit, "average")

test_predictions <- predict.train(lmCVFit, test, type="prob")



test_pred<- ifelse(test_predictions>0.5,1,0)
table(test_pred)

model_gbm<-train(trainSet[,predictors],trainSet[,outcomeName],method='gbm')
model_rf<-train(trainSet[,predictors],trainSet[,outcomeName],method='rf')
model_nnet<-train(trainSet[,predictors],trainSet[,outcomeName],method='nnet')
model_glm<-train(trainSet[,predictors],trainSet[,outcomeName],method='glm')