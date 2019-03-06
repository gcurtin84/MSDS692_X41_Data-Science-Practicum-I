## The following code combines the stats from each NFL regular season week with   ##
## the fantasy score of the following week. The purpose of this dataset is to use ##
## the player stats from any regular season week to predict the fantasy score of  ##
## the next week. For example, the stats from week 1 will be used to predict the  ##
## fantasy score for the following week.                                          ##

#Represents the 17 weeks of the NFL regular season.  
#Note: Week 17 not used because there is no following week to predict.
wks <- c(1:16)

for (wk in wks){ #repeats for each week of the wks variable
  
  #pull stats for each week
  stats.crntwk <- stats_dataset[stats_dataset$Week == wk,]
  
  #pull fantasy score for following week
  pts.nxtwk <- stats_dataset[stats_dataset$Week == (wk+1),]
  names(pts.nxtwk) <- c("Name", "Team", "G", "Pass.Comp", "Pass.Att", "Pass.Yard", 
                        "Pass.TD", "Pass.INT", "Rush.Att", "Rush.Yard", "Rush.TD", 
                        "NxtWk.FPTS", "FPTSG", "Week")
  
  #combine each week's stats with the following weeks fantasy score
  tbl_varname<-paste("week", wk, sep="")
  assign(tbl_varname, merge(pts.nxtwk[, c("Name", "NxtWk.FPTS")], stats.crntwk))
  
  #clean environment variables
  rm(stats.crntwk, pts.nxtwk, tbl_varname)
}

#combine all weekly dataframes into one dataframe including all week projections
predtbl <- rbind(week1, week2, week3, week4, week5, week6, week7, week8, week9, 
      week10, week11, week12, week13, week14, week15, week16)

#clean dataframe
predtbl <- predtbl[c(-4,-14)]

#clean environment variables
rm(week1, week2, week3, week4, week5, week6, week7, week8, week9, 
      week10, week11, week12, week13, week14, week15, week16, week17, wk, weeks)

#write output to csv
write.csv(predtbl, file = "predtbl.csv")

#read csv to dataframe
combined_dataset <- read.csv("predtbl.csv", header = TRUE)

#clean csv read dataframe
combined_dataset <- combined_dataset[-1]

#clean environment variables
rm(predtbl)
