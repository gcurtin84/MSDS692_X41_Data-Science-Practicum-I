## The following code pulls fantasty football projected (predicted) scores from  ##
## fftoolbox.com by week for the quarterback position (QB)                       ##

#represents the 17 weeks of the NFL regular season
wks <- c(1:17)

for (wk in wks){ #repeats for each week of the wks variable
      

      #urlvar is the raw url where the QB Stats table exists
      urlvar <- "https://fftoolbox.scoutfantasysports.com/football/rankings/?week=WEEK&pos=qb"
      urlvar <- gsub("WEEK", wk, urlvar) #sub in week number
      print(urlvar) #added to show progress in console
      
      #pull raw html from url generated in "urlvar"
      htmlvar<-read_html(urlvar)
      
      #scrape and clean player weekly positional rank
      playerRank<-htmlvar %>%
        html_nodes(".playerRank") %>%
        html_text()
      playerRank<-playerRank[1:(length(playerRank)/2)]
      playerRank<-playerRank[-1]

      #scrape and clean player name
      playerName<-htmlvar %>%
        html_nodes(".name") %>%
        html_text()
      playerName <- gsub("\n\t\t\t\t\t\t   \t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t   \n                              ", "", playerName)
      playerName <- gsub("\n                              \n                           ", "", playerName)
      playerName <- gsub("         \n                                 \n                           ", "", playerName) 
      playerName<-playerName[1:(length(playerName)/2)]
      
      #scrape and clean player position
      playerPos<-htmlvar %>%
        html_nodes(".pos") %>%
        html_text()
      playerPos<-playerPos[1:(length(playerPos)/2)]
      playerPos<-playerPos[-1]
      
      #scrape and clean opponent
      playerOpp<-htmlvar %>%
        html_nodes(".byeWeek") %>%
        html_text()
      playerOpp<-playerOpp[1:(length(playerOpp)/2)]
      playerOpp<-playerOpp[-1]

      #scrape and clean player injury status
      playerStatus<-htmlvar %>%
        html_nodes(".injury") %>%
        html_text()
      playerStatus<-playerStatus[1:(length(playerStatus)/2)]
      playerStatus<-playerStatus[-1]

      #scrape and clean player age
      playerAge<-htmlvar %>%
        html_nodes(".age") %>%
        html_text()
      playerAge<-playerAge[1:(length(playerAge)/2)]
      playerAge<-playerAge[-1]
      
      #scrape and clean player projected points
      playerPts<-htmlvar %>%
        html_nodes(".pts") %>%
        html_text()
      playerPts<-playerPts[1:(length(playerPts)/2)]
      playerPts<-playerPts[-1]
      
      #build the QB weekly projections dataframe
      playerProj <- cbind(playerName, playerRank, playerPos, playerOpp, playerStatus, playerAge, playerPts, wk)
      playerProj <- as.data.frame(playerProj)
      names(playerProj) <- c("Name", "Rank", "POS", "Opp", "Status", "Age", "Pts", "Week")
      tbl_varname<-paste(pos, wk, sep="")
      assign(tbl_varname, playerProj)
      
      #remove unwanted variables
      rm(playerName, playerRank, playerPos, playerOpp, playerStatus, playerAge, playerPts, tbl_varname)
      
      #wait 2 seconds before running next line of code
      #Sys.sleep(2)
}

#clean environment variables
rm(htmlvar, playerProj, weeks, positions, pos, urlvar, wk)

#combine all weekly dataframes into one dataframe including all week projections
Proj_rbind <- rbind(qb1,qb2,qb3,qb4,qb5,qb6,qb7,qb8,qb9,qb10,qb11,qb12,qb13,qb14,qb15,qb16,qb17)

#clean environment variables
rm(qb1,qb2,qb3,qb4,qb5,qb6,qb7,qb8,qb9,qb10,qb11,qb12,qb13,qb14,qb15,qb16,qb17)

#write output to csv
write.csv(Proj_rbind, file = "proj.csv")

#read csv to dataframe
projections_dataset <- read.csv("proj.csv", header = TRUE)

#clean csv read dataframe
projections_dataset  <- projections_dataset[-1]

#clean environment variables
rm(Proj_rbind)
