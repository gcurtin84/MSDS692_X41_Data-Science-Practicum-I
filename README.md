# MSDS692_X41_Data-Science-Practicum-I

by Garrett Curtin

## Predicting Daily Fantasy Football Points Using Machine Learning

According to rotogrinders.com, the daily fantasy company Fanduel paid out more than $560 million in prizes during the 2014 calendar year.  With so much money to be made daily fantasy players are always looking for a tool that will give them an edge in selecting their daily fantasy teams.  As a daily fantasy football (DFF) ethusiast I have used many of the tools that promise better performance and winnings for DFF players.  All of those tools had one thing in common: they did not keep their promise.  The purpose of this project is to explore a potential tool that can be used to gain the promised edge.

## Daily Fantasy Football

DFF is a simple concept.  A player selects a fantasy team from a pool of football players that will play within a given timeframe.  In a traditional contest each player is assigned a salary.  The sum  of all player salaries must be less than the contest's budget.  For example, a Draftkings lineup requires that a DFF contestant selects one quarterback (QB), two running backs (RB), 3 wide receivers (WR), 1 tight end (TE), and the entire defense and special teams (DST) of one NFL franchise.  In addition the contestant gets to fill a flex position from either of the RB, WR or TE positions.  This makes a total of nine DFF positions. The contestant is given a budget of $50 thousand dollars and must pick a lineup with combined salaries less than or equal to the budget.  Each position within the lineup accumulates fantasy points (FPTS) based on pre-defined rules.

#### QB Scoring Rules:
* Passing Touchdown = 4pts
* 25 Passing Yards = 1pt
* 300+ Yard Passing Game = 3pts
* Interception = -1pt

[**Full Set of Rules](http://fantasysportdrs.com/draftkings-fantasy-football-rules/)

A contestant competes with the other players who have joined the same contest.  Which ever contestant has the highest scoring lineup wins the contest and the prize associated.  Most contests give a range of prizes to a certain percentage of the highest scoring contestants.  However simple this process may seem, the hard part is winning.  

## Personal Experience

From my own experience, I have found that one factor distinguishes how well I do in a particular contest.  Generally, when my overall score exceeds 180 total points my odds of winning are higher.  Anything less than 180 points usually results in no prize.  Of course, this distinguishing factor does not always prove to be true.  However, it is an obtainable goal that has given me a decent amount of success. With 9 DFF positions and a goal of 180 overall points, I attempt to pick the cheapest players that I believe will exceed 20 points.  The below project is designed in an attempt to make such a tool.

## Project Design

To keep this project simple I focused on the QB position.  This project is designed to be a proof of concept rather than a fully functional tool.  The dataset used for training and testing the machine learning models was created by web-scraping from [fftoday.com](http://fftoday.com/stats/playerstats.php?Season=2018&GameWeek=1&PosID=10&LeagueID=).  Two categorical machine learning models where used to predict fantasy points: SVM and KNN.  Instead of predicting a specific score for each player I separated FPTS into two categories.  In my [YouTube presentation](https://www.youtube.com/watch?v=pC5gCreOxjs), I show how the resulting models can be used to make predictions and select players for a lineup.  I want to give a special thanks to [Matteo Hoch](https://www.youtube.com/channel/UCiie9CN--dazA7iT2sry5FA) for sharing his tutorial on how to web scrape daily fantasy data.  His tutorial can be found [here](https://www.youtube.com/watch?v=YgalGDCL3Zk&t=535s).  

## EDA - Combined Dataset

The combined data set contains 14 columns and 611 rows.  It has the first 16 regular season NFL football week QB stats.  The 17th week is excluded because there is not a following week to predict FPTS for.

#### Parameters:
1) Name: First and Last name of football player
2) NxtWk.FPTS: Fantasty points (FPTS) scored for the following week
3) Team: the Football player's owning franchise
4) Pass.Comp: Passes completed for the current week
5) Pass.Att: Passes attempted for the current week
6) Pass.TD: Touchdowns thrown for the current week
7) Pass.INT: Interceptions thrown for the current week
8) Rush.Att: Rushing attempts for the current week
9) Rush.Yard: Yards rushed for the current week
10). Rush.TD: Rushed in touchdowns for the current week
11) FPTS: Fantasy points scored for the current week
12) Week: Current week
13) Categories: Categories for the NxtWk.FPTS parameter. Two categories: C1 = < 20 FPTS, C2 = > 20 FPTS

![str](https://github.com/gcurtin84/MSDS692_X41_Data-Science-Practicum-I/blob/master/Str_AllQBStats.png)

![summary](https://github.com/gcurtin84/MSDS692_X41_Data-Science-Practicum-I/blob/master/Summary_AllStats.png)

Looking at the correlations below, I found that the pass stats and FPTS had the highest correlations to the target parameter (NxtWk.FPTS).  For this reason, I decided to use the Pass.Yards and FPTS in my ML models.

![Pass Correlations](https://github.com/gcurtin84/MSDS692_X41_Data-Science-Practicum-I/blob/master/Plot_PassQBStats.png)

![Rush Correlations](https://github.com/gcurtin84/MSDS692_X41_Data-Science-Practicum-I/blob/master/Plot_RushQBStats.png)

![Corrplot](https://github.com/gcurtin84/MSDS692_X41_Data-Science-Practicum-I/blob/master/Corrplot_Allstats.png)

The [Combined Dataset](https://github.com/gcurtin84/MSDS692_X41_Data-Science-Practicum-I/blob/master/Combined_Dataset.R) is created using the [Stats Dataset](https://github.com/gcurtin84/MSDS692_X41_Data-Science-Practicum-I/blob/master/Stats_Dataset.R).  For each week of football the next week's stats for each player were added to the current week.  For example, I combined the week 1 stats with the week 2 stats.  The goal of this project is to use a week's stats to predict the following weeks fantasy points.

## Projections Dataset

The [Projections Dataset](https://github.com/gcurtin84/MSDS692_X41_Data-Science-Practicum-I/blob/master/Projections_Dataset.R) was pulled from fftoolbox.com and is solely purposed to compare my predictions with the predictions already available to DFF players.

## Results

To predict the target categories I tested two ML models: KNN and SVM.  Both the [SVM Model](https://github.com/gcurtin84/MSDS692_X41_Data-Science-Practicum-I/blob/master/Code/SVM_Model.R) and [KNN Model](https://github.com/gcurtin84/MSDS692_X41_Data-Science-Practicum-I/blob/master/Code/KNN_Model.R) performed almost exactly the same with about 60% accuracy. Basically, these models will accurately predict if a QB will score over 20 FPTS more than half the time.  This isn't a great accuracy rate for most data science projects.  However, 60% confidence is a player'd value makes a huge different in the DFF domain.

#### KNN Predictions vs. Targets:
![KNN Predictions](https://github.com/gcurtin84/MSDS692_X41_Data-Science-Practicum-I/blob/master/KNN_Table.png)

#### SVM Predictions vs. Targets:
![SVM Predictions](https://github.com/gcurtin84/MSDS692_X41_Data-Science-Practicum-I/blob/master/SVM_Table.png)

## Abbreviations

DFF - Daily Fantasy Football<br/>
DST - Defense and Special Teams<br/>
FPTS - Fantasy Points<br/>
QB - Quarterback<br/>
RB - Runningback<br/>
TE - Tight End<br/>
WR - Wide Receiver

## Sources

https://rotogrinders.com/static/daily-fantasy-sports-timeline

http://fantasysportdrs.com/draftkings-fantasy-football-rules

http://fftoday.com/stats/playerstats.php?Season=2018&GameWeek=1&PosID=10&LeagueID=

http://fantasysportdrs.com/draftkings-fantasy-football-rules/

https://www.youtube.com/watch?v=YgalGDCL3Zk&t=535s
