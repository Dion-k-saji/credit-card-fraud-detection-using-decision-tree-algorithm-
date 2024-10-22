library(caret)
library(caTools)
library(data.table)
library(ranger)

dim(creditcard)
names(creditcard)
table(creditcard$Class)
head(creditcard)

creditcard$Amount=scale(creditcard$Amount)

newdata = creditcard[,-1]
head(newdata)
#model creation

set.seed(1234)
datasample=sample.split(newdata$Class,SplitRatio = 0.80)
train = subset(newdata,datasample == TRUE)
test = subset(newdata,datasample == FALSE)

head(train)
head(test)

library(rpart)
library(rpart.plot)

dtree = rpart(Class ~., data= train,method ='class')
summary(dtree)
predicted_probs <- predict(dtree, data = test, type = "prob")

rpart.plot(dtree)

# Extract tree structure as a data frame
tree_structure <- as.data.frame(dtree$frame)

# View the first few rows
head(tree_structure)

# Write tree structure to a CSV file
write.csv(tree_structure, file = "decision_tree_structure.csv", row.names = FALSE)
getwd()

# Save the tree plot to a PNG file
png("decision_tree_plot.png")
rpart.plot(dtree)
dev.off()
getwd()

