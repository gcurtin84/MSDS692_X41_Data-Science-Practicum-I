## The following code pulls fantasty football stats from fftoday.com by week for ##
## the quarterback position (QB). This dataset will be used to create a ML       ##
## predicition model                                                             ##

#represents the 17 weeks of the NFL regular season
wks <- c(1:17) 

for (wk in wks) { #repeats for each week of the wks variable
  
  #urlvar is the raw url where the QB Stats table exists
  urlvar <- "http://fftoday.com/stats/playerstats.php?Season=2018&GameWeek=WEEK&PosID=10"
  
  #replace "WEEK" with the current week number
  weekvar <- gsub("WEEK", wk, urlvar) 
  
  #pull raw html from url generated in "weekvar"
  htmlvar<-read_html(weekvar)
  
  #extract ".sort1" class table entries in "htmlvar"
  txtvar<-htmlvar %>%
      html_nodes(".sort1") %>%
      html_text()
  
  #build the QB weekly stats dataframe
  m <- matrix(txtvar, ncol=13, byrow=TRUE)
  names <- m[,1]
  names1 <- substring(names[1:9], 5)
  names2 <- substring(names[-(1:9)], 6)
  names <- c(names1, names2)
  m <- cbind(names, m[,2:13], wk)
  df <- as.data.frame(m)
  names(df) <- c("Name", "Team", "G", "Pass.Comp", "Pass.Att", "Pass.Yard", "Pass.TD", "Pass.INT",
                 "Rush.Att", "Rush.Yard", "Rush.TD", "FPTS", "FPTSG", "Week")
  
  #assign variable name "Stats" + week number
  tbl_varname<-paste("Stats", wk, sep="")
  assign(tbl_varname, df)
}

#combine all weekly dataframes into one dataframe including all week stats
Stat_rbind <- rbind(Stats1, Stats2, Stats3, Stats4, Stats5, Stats6, Stats7, Stats8, Stats9,
                    Stats10, Stats11, Stats12, Stats13, Stats14, Stats15, Stats16, Stats17)

#clean environment variables
rm(Stats1, Stats2, Stats3, Stats4, Stats5, Stats6, Stats7, Stats8, Stats9,
   Stats10, Stats11, Stats12, Stats13, Stats14, Stats15, Stats16, Stats17, 
   df, htmlvar, m, names, names1, names2, tbl_varname, txtvar, urlvar, weekvar,
   wk, wks)

#write output to csv
write.csv(Stat_rbind, file = "stats_dataset.csv")

#read csv to dataframe
stats_dataset <- read.csv("stats_dataset.csv", header = TRUE)

#clean csv read dataframe
stats_dataset <- stats_dataset[-1]

#clean environment variables
rm(Stat_rbind)
