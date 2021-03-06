library(caret)
timestamp <- format(Sys.time(), "%Y_%m_%d_%H_%M")

model <- "rfe_issue485"

#########################################################################

set.seed(31253)
test_reg <- rfe(x = iris[,1:3],
                y = iris[,4]/max(iris[,4]),
                sizes = 1:2, 
                method="nnet", 
                trace = FALSE,
                rfeControl = rfeControl(functions = caretFuncs, number = 3))

set.seed(45563)
test_class <- rfe(x = iris[,1:4],
                  y = iris$Species,
                  sizes = 1:2, 
                  method="nnet", 
                  trace = FALSE,
                  rfeControl = rfeControl(functions = caretFuncs, number = 3), 
                  trControl = trainControl(classProbs = TRUE, summaryFunction = multiClassSummary))

#########################################################################

tests <- grep("test_", ls(), fixed = TRUE, value = TRUE)

sInfo <- sessionInfo()

save(list = c(tests, "sInfo", "timestamp"),
     file = file.path(getwd(), paste(model, ".RData", sep = "")))

q("no")
