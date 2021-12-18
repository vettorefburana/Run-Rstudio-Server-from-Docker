
# add lib path
.libPaths(new = "/packages")

library(ggplot2)
library(randomForest)
library(dplyr)

# read csv file
redwine = read.csv("./R/winequality-red.csv")

# binary variable for wine quality
redwine$good_wine<-ifelse(redwine$quality>6,1,0)

# random forest model
wine_rf <- randomForest(factor(good_wine)~.-quality, redwine, ntree=150)

imp <- importance(wine_rf)

var_importance <- data.frame(Variables = row.names(imp), 
                            Importance = round(imp[ ,'MeanDecreaseGini'],2))

# rank variable importance
rank_importance <- var_importance %>%
  mutate(rank = paste0('#',dense_rank(desc(imp))))

# save ouput as csv
write.csv(rank_importance, file = "./R/output.csv")
