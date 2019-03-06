# MSDS692_X41_Data-Science-Practicum-I

by Garrett Curtin

## Predicting Daily Fantasy Football Points Using Machine Learning

According to rotogrinders.com, the daily fantasy company Fanduel paid out more than $560 million in prizes during the 2014 calendar year.  With so much money to be made daily fantasy players are always looking for a tool that will give them an edge in selecting their daily fantasy teams.  As a daily fantasy football (DFF) ethusiast I have used many of the tools that promise better performance and winnings for DFF players.  All of those tools had one thing in common: they did not keep their promise.  The purpose of this project is to explore a potential tool that can be used to gain the promised edge.

## Daily Fantasy Football

DFF is a simple concept.  A player selects a fantasy team from a pool of football players that will play within a given timeframe.  In a traditional contest each player is assigned a salary.  The sum  of all player salaries must be less than the contest's budget.  For example, a Draftkings lineup requires that a DFF contestant selects one quarterback (QB), two running backs (RB), 3 wide recievers (WR), 1 tight end (TE), and the entire defense and special teams (DST) of one NFL franchise.  In addition the contestant gets to fill a flex position from either of the RB, WR or TE positions.  This makes a total of nine DFF positions. The contestant is given a budget of $50 thousand dollars and must pick a lineup with combined salaries less than or equal to the budget.  Each position within the lineup accumulates fantasy points based on pre-defined rules.

#### QB Scoring Rules:
* Passing Touchdown (TD) = 4pts
* 25 Passing Yards = 1pt
* 300+ Yard Passing Game = 3pts
* Interception = -1pt

[**Full Set of Rules](http://fantasysportdrs.com/draftkings-fantasy-football-rules/)

A contestant competes with the other players who have joined the same contest.  Which ever contestant has the highest scoring lineup wins the contest and the prize associated.  Most contests give a range of prizes to a certain percentage of the highest scoring contestants.  However simple this process may seem, the hard part is winning.  

## Personal Experience

From my own experience, I have found that one factor distinguishes how well I do in a particular contest.  Generally, when my overall score exceeds 180 total points my odds of winning are higher.  Anything less than 180 points usually results in no prize.  Of course, this distinguishing factor does not always prove to be true.  However, it is an obtainable goal that has given me a decent amount of success. With 9 DFF positions and a goal of 180 overall points, I attempt to pick the cheapest players that I believe will exceed 20 points.  The below project is designed in an attempt to make such a tool.

## Project Design

To keep this project simple I focused on the QB position.  The dataset was created by web-scraping from [fftoday.com](http://fftoday.com/stats/playerstats.php?Season=2018&GameWeek=1&PosID=10&LeagueID=)

## Stats Dataset

## EDA - Stats Dataset

## Projections Dataset

## EDA - Stats Dataset

## SVM Model

## KNN Model

## Sources
https://rotogrinders.com/static/daily-fantasy-sports-timeline
