upTrain <- upSample(newdf[,-12],newdf$stroke)

library(caret)

control <- trainControl(method="repeatedcv", number=10, repeats=3)

modelGlmPr <- train(Class~age+avg_glucose_level+work_type+
                      smoking_status+ever_married+heart_disease+
                      Residence_type+gender+hypertension, 
                    data=upTrain,
                    preProcess="pca",
                    method="glm", 
                    family="binomial", 
                    trControl=control)

#confusionMatrix(data.test$B.M, predict(modelGlmPr, data.test))

summary(modelGlmPr)

pred2 <- predict(modelGlmPr, test)
#pred22 <- ifelse (pred2>0.5,1,0)
#table(pred22)

sub_reg <- data.frame(id=test$id, stroke=pred2)
write.csv(file = 'data/submission-18.csv', x = sub_reg, row.names = F)
