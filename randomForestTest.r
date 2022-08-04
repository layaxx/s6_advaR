library(Rforestry) #forestry
library(randomForestSRC) #rfsrc

set.seed(1)

columnToPredict = 5;

data <- iris
test_ids <- sample(nrow(data), 25)

training_data <- data[-test_ids,]
training_data_x <- data[-test_ids, -columnToPredict]
training_data_y <- data[-test_ids, columnToPredict]

test_data <- data[test_ids,]
test_data_x <- data[test_ids, -columnToPredict]
test_data_y <- data[test_ids, columnToPredict]

rf <- rfsrc(Species ~ ., data = training_data, block.size = 1, splitrule = "gini")
#rf2 <- forestry(x = training_data_x, y = training_data_y)
rf
plot(rf)

predicted_y <- predict.rfsrc(rf, test_data)
predicted_y <- get.mv.predicted(predicted_y)

plot(1:length(test_data[,columnToPredict]), test_data[,columnToPredict], col = "darkgreen", ylim = c(0, 3))
#points(1:length(test_data[,columnToPredict]), correctedPredict(rf2, test_data_x), col = "red")
points(1:length(test_data[,columnToPredict]), predicted_y[,1], col = "purple")
points(1:length(test_data[,columnToPredict]), predicted_y[,2]*2, col = "red")
points(1:length(test_data[,columnToPredict]), predicted_y[,3]*3, col = "blue")

#error <- abs(test_data[,columnToPredict] - correctedPredict(rf2, test_data_x))
#mean(error)
#sd(error)

#error2 <- abs(test_data[,columnToPredict] - predicted_y[,1])
#mean(error2)
#sd(error2)