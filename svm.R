library(caret)

upTrain <- upSample(newdf[,-12],newdf$stroke)



control <- trainControl(method="repeatedcv", number=10, repeats=3)

modelSVMPr <- train(Class~age+avg_glucose_level+work_type+
                      smoking_status+ever_married+heart_disease+
                      Residence_type+gender+hypertension, 
                    data=upTrain,
                    preProcess="pca",
                    method="svmRadial", 
                    trControl=control)

#confusionMatrix(data.test$B.M, predict(modelGlmPr, data.test))

summary(modelSVMPr)

pred2 <- predict(modelSVMPr, test)
#pred22 <- ifelse (pred2>0.5,1,0)
#table(pred22)

sub_reg <- data.frame(id=test$id, stroke=pred2)
write.csv(file = 'data/submission-19.csv', x = sub_reg, row.names = F)
