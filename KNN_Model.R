## The following code uses the combined_dataset to generate a KNN machine       ##
## learning model to predict fantasy scores for any given week of the NFL       ##
## regular season using the player stats from the previous week                 ##

library(class)

#function to normalize data
normalize <- function(x) {
  return ( (x - min(x)) / (max (x) - min(x)) )}

#transform fantasy scores into 2x categories.
#"C1" represents fantasy scores that are 20 or less
#"C2" represents fantasy scores that are between 10 and 60
dfs <- combined_dataset
cats <- c("C1","C2")
dfs$Categories<-cut(dfs$NxtWk.FPTS, c(0,20,60), right=FALSE, labels=cats)
dfs <- na.omit(dfs)

#normalize data
dfs_n <- as.data.frame(lapply(dfs[c(-1, -2, -3, -13, -14)], normalize))
dfs_n <- cbind(dfs_n, Categories = dfs$Categories)
str(dfs_n)
summary(dfs_n)

#partition dataframe into training and test set
set.seed(500)
samps<-sample(459, 100)
cols<-c("Pass.Yard", "FPTS")
dfs.n_train <- df[samps, cols]
dfs.n_test <- df[-samps, cols]
dfs.n_train_target <- df[samps, "Categories"]
dfs.n_test_target <- df[-samps, "Categories"]

#find square root of entries in dataset for starting "k"
sqrt(nrow(df)) #21.42429

#find best model using trial and error
m1 <- knn(train = dfs.n_train, test = dfs.n_test, cl = dfs.n_train_target, k=21)
table(targets = dfs.n_test_target, predictions = m1)

m2 <- knn(train = dfs.n_train, test = dfs.n_test, cl = dfs.n_train_target, k=23)
table(targets = dfs.n_test_target, predictions = m2)

m3 <- knn(train = dfs.n_train, test = dfs.n_test, cl = dfs.n_train_target, k=24)
table(targets = dfs.n_test_target, predictions = m3)

m4 <- knn(train = dfs.n_train, test = dfs.n_test, cl = dfs.n_train_target, k=25)
table(targets = dfs.n_test_target, predictions = m4)

m5 <- knn(train = dfs.n_train, test = dfs.n_test, cl = dfs.n_train_target, k=30)
table(targets = dfs.n_test_target, predictions = m5)
#best accuracy 0.6016713091922006, k=30