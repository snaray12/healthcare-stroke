library(h2o)
local <- h2o.init()

fullData <- as.h2o(newdf)

finalTestData <- as.h2o(test)

splits <- h2o.splitFrame(fullData,
                         c(0.8),
                         seed=1234)

trainData <- h2o.assign(splits[[1]], "train.hex")
validationData <- h2o.assign(splits[[2]], "validation.hex")
#testData <- h2o.assign(splits[[3]], "test.hex")

rf1 <- h2o.gbm(
  training_frame = trainData,
  validation_frame = validationData,
  nfolds = 3,
  ntrees = 30,
  balance_classes = T,
  x=2:11,
  y=12,
  model_id = "RF1",
  stopping_metric = c("AUC"),
  seed=12345
)
h2o.confusionMatrix(rf1)
summary(rf1)

h2o.performance(rf1, validationData)
#pred <- h2o.predict(rf1, testData)

# table(testData$stroke, pred$predict)


predicted <- as.data.frame(h2o.predict(rf1, finalTestData))
sub_reg <- data.frame(id=test$id, stroke=predicted$predict)
write.csv(file = 'data/submission-13.csv', x = sub_reg, row.names = F)
