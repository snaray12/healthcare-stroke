library(randomForest)

rf.model <- randomForest(formula=stroke~age+avg_glucose_level+work_type+
               smoking_status+ever_married+heart_disease+
               Residence_type+gender+hypertension,
             data=smoteTrain,
             ntree=500,
             proximity=T
             )

summary(rf.model)

rf.pred <- predict(rf.model, test)
sub_reg <- data.frame(id=test$id, stroke=rf.pred)
write.csv(file = 'data/submission-10.csv', x = sub_reg, row.names = F)

