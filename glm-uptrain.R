upTrain <- upSample(newdf[,-12],newdf$stroke)


model.fit <- glm(formula=Class~age+avg_glucose_level+work_type+
      smoking_status+ever_married+heart_disease+
      Residence_type+gender+hypertension,
      data=upTrain,
      family = "binomial"
      )
summary(model.fit)

pred1 <- predict(model.fit, test)
pred11 <- ifelse (pred2>0.5,1,0)
table(pred11)
sub_reg <- data.frame(id=test$id, stroke=pred11)
write.csv(file = 'data/submission-8.csv', x = sub_reg, row.names = F)

library(DMwR)

set.seed(0987)
smoteTrain <- SMOTE(stroke~., data=newdf)
model.fit2 <- glm(formula=stroke~age+avg_glucose_level+work_type+
                   smoking_status+ever_married+heart_disease+
                   Residence_type+gender+hypertension,
                 data=smoteTrain,
                 family = "binomial"
)
summary(model.fit)

pred2 <- predict(model.fit, test)
pred22 <- ifelse (pred2>0.5,1,0)
table(pred22)

sub_reg <- data.frame(id=test$id, stroke=pred22)
write.csv(file = 'data/submission-9.csv', x = sub_reg, row.names = F)
