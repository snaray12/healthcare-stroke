library(h2o)
local <- h2o.init()

fullData <- as.h2o(newdf)
fullData[12] <- fullData.index[12].asfactor()

finalTestData <- as.h2o(test)

splits <- h2o.splitFrame(fullData,
                         c(0.6,0.2),
                         seed=1234)

trainData <- h2o.assign(splits[[1]], "train.hex")
validationData <- h2o.assign(splits[[2]], "validation.hex")
testData <- h2o.assign(splits[[3]], "test.hex")


sample_factors <- c(1., 0.5, 1., 1., 1., 1., 1.)

rf1 <- h2o.glm(
  training_frame = trainData,
  validation_frame = validationData,
  x=1:11,
  y=12,
  family = "binomial",
  balance_classes = T,
  max_after_balance_size = .6,
  class_sampling_factors = c(1, 1, 2.5),
  model_id = "RF1",
  alpha = 0,
#  lambda = 1,
  nfolds = 3,
  lambda_search = T,
  solver = "L_BFGS",
  seed=12345
)
h2o.confusionMatrix(rf1)

summary(rf1)
#h2o.performance(rf1, testData)
#pred <- h2o.predict(rf1, testData)

#table(testData$stroke, pred$predict)


predicted <- as.data.frame(h2o.predict(rf1, finalTestData))
sub_reg <- data.frame(id=test$id, stroke=predicted$predict)
write.csv(file = 'data/submission-6.csv', x = sub_reg, row.names = F)

