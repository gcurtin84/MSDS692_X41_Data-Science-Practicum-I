## The following code uses the combined_dataset to generate a SVM machine       ##
## learning model to predict fantasy scores for any given week of the NFL       ##
## regular season using the player stats from the previous week                 ##

library(e1071)

#transform fantasy scores into 2x categories.
#"C1" represents fantasy scores that are 20 or less
#"C2" represents fantasy scores that are between 10 and 60
df <- combined_dataset
cats <- c("C1","C2")
df$Categories<-cut(df$NxtWk.FPTS, c(0,20,60), right=FALSE, labels=cats)

#clean NAs in dataframe
df <- na.omit(df)

#partition dataframe into training and test set
set.seed(123)
s100<-sample(459, 100)
col<-c("Pass.Yard", "FPTS", "Categories")
col2<-c("Pass.Yard", "FPTS")
df_train <- df[s100, col]
df_test <- df[-s100, col2]

#create prediction model
svmfit <- svm(Categories ~., data = df_train, kernel = "linear", cost = .1, 
              scale = FALSE)

#tune prediction model
tuned <- tune.svm(Categories ~., data = df_train, gamma = 10^(-1:-3),
                  cost = 10^(1:3), , tunecontrol = tune.control(cross = 10))
summary(tuned)

#create tuned prediction model
svmfit_tuned <- svm(Categories ~., data = df_train, kernel = "linear", 
                    cost = 10, gamma = 0.01, scale = FALSE)
print(svmfit_tuned)
plot(svmfit_tuned, df_train[,col])

#predict fantasy scores
p<-predict(svmfit_tuned, df_test, type="class")

#show accuracy of model
table(p, df_test[,3]) #best accuracy achieved 0.6016713091922006
