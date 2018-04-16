library(e1071)
library(caret)
upTrain <- upSample(newdf[,-12],newdf$stroke)
svm_model <- svm(Class~age+avg_glucose_level+work_type+
                   smoking_status+ever_married+heart_disease+
                   Residence_type+gender+hypertension, 
                 data=upTrain,
                 kernel="radial", cost=1, gamma=0.5
                 )

svm_tune <- tune(svm, train.x=newdf[,c(-1,-12)], train.y=newdf[,12], 
                 kernel="radial", ranges=list(cost=2(-1:2), gamma=c(.5,1,2)))

print(svm_tune)

summary(svm_model)

svm_pred <- predict(svm_model, test)

sub_reg <- data.frame(id=test$id, stroke=svm_pred)
write.csv(file = 'data/submission-19.csv', x = sub_reg, row.names = F)
