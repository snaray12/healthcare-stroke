library(h2o)
local <- h2o.init()

newdf$stroke <- as.factor(newdf$stroke)

fullData <- as.h2o(newdf)

finalTestData <- as.h2o(test)

splits <- h2o.splitFrame(fullData,
                         c(0.6,0.2),
                         seed=1234)

trainData <- h2o.assign(splits[[1]], "train.hex")
validationData <- h2o.assign(splits[[2]], "validation.hex")
testData <- h2o.assign(splits[[3]], "test.hex")


sample_factors <- c(1., 0.5, 1., 1., 1., 1., 1.)

rf1 <- h2o.randomForest(
  training_frame = trainData,
  validation_frame = validationData,
  x=2:11,
  y=12,
  balance_classes = T,
#  class_sampling_factors = c(1, 1, 2.5),
  max_after_balance_size = 0.85,
  model_id = "RF1",
  seed=12345
)
h2o.confusionMatrix(rf1)
summary(rf1)

#h2o.performance(rf1, testData)
#pred <- h2o.predict(rf1, testData)

#table(testData$stroke, pred$predict)


predicted <- as.data.frame(h2o.predict(rf1, finalTestData))
sub_reg <- data.frame(id=test$id, stroke=predicted$predict)
write.csv(file = 'data/submission-11.csv', x = sub_reg, row.names = F)
