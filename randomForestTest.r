library(Rforestry)

set.seed(1)

columnToPredict = 1;

data <- attitude
test_ids <- sample(nrow(data), 5)

training_data_x <- data[-test_ids, -columnToPredict]
training_data_y <- data[-test_ids, columnToPredict]

test_data_x <- data[test_ids, -columnToPredict]
test_data_y <- data[test_ids, columnToPredict]

rf <- forestry(x = training_data_x, y = training_data_y)

predicted_y <- correctedPredict(rf, test_data_x)#predict(rf, test_data_x)

plot(1:length(test_data_y), test_data_y, col = "darkgreen")
points(1:length(test_data_y), predicted_y, col = "red")

error <- abs(test_data_y - predicted_y)
mean(error)
sd(error)