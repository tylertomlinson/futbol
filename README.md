<p align="center">
  <img width="650" height="350" src="https://i.imgur.com/96qJSAy.png">
</p>

# Table of Contents
<details>
<summary>Click to expand</summary>
  
- [About](#about)
- [Learning Goals](#learning-goals)
- [Getting Started](#getting-started)
- [Statistics](#statistics)
	* [Game Statistics](#game-statistics)
  * [League Statistics](#league-statistics)
  * [Team Statistics](#team-statistics)
  * [Season Statistics](#season-statistics)
- [Authors](#authors)
- [Contributing](#contributing)
</details>

# About 
Futbol is a group project which builds a system to do some analysis on individual and group futbol team performances. All of the statistics functionality with be based through a `StatTracker`. 

# Learning Goals

- Build classes with single responsibilities.
- Write organized readable code.
- Use TDD as a design strategy
- Design an Object Oriented Solution to a problem
- Practice algorithmic thinking
- Work in a group
- Use Pull Requests to collaborate among multiple partners

# Getting Started

## Prerequisites
```ruby
brew install ruby -2.5.3
gem install rspec
```
## Installing

#### Clone repository:
```ruby
git clone git@github.com:tylertomlinson/futbol.git
```
#### Navigate into directory:
```ruby
cd futbol
```

#### Run test suite: (spec harness repo)
```ruby
within /futbol 
git clone https://github.com/turingschool-examples/futbol_spec_harness.git
rspec
```

# Statistics
<p align="center">
  <img width="650" height="350" src="https://i.imgur.com/5SqVBQx.jpg">
</p>


### Game Statistics
**Statistic** | **Description**
:---:|---
Highest Total Score | Highest total for home and away goals in a single game
Lowest Total Score | Lowest total for home and away goals in a single game
Biggest Blowout | Largest difference in goals between two teams in a single game
Home Win Percentage | Percentage of games in which the home team won
Visitor Win Percentage | Percentage of games in which the visiting team won
Overall Tie Percentage | Percentage of games which ended in a tie
Average Goals per Game | Average number of total goals scored in a game
Average Goals by Season | Average number of goals scored per game for each season in the league
Count of Games by Season | Total number of games played during each season in the league

### League Statistics
**Statistic** | **Description**
:---:| ---
Best Offense | Team with the highest average number of goals scored per game across all seasons
Worst Offense | Team with the lowest average number of goals scored per game across all seasons
Best Defense | Team with the lowest average number of goals allowed per game across all seasons
Worst Defense | Team with the highest average number of goals allowed per game across all seasons
Highest Scoring Visitor | Team with the highest average score per game across all seasons when they are away
Highest Scoring Home Team | Team with the highest average score per game across all seasons when they are home
Lowest Scoring Visitor | Team with the lowest average score per game across all seasons when they are a visitor
Lowest Scoring Home Team | Team with the lowest average score per game across all seasons when they are at home
Winningest Team | Team with the highest win percentage across all seasons
Best Fans | Team with biggest difference between home and away win percentages
Worst Fans | List of names of all teams with better away records than home records

### Team Statistics
Each of the methods below take a `team_id` as an argument. Using that team id, your instance of StatTracker will provide statistics for a specific team.

**Statistic** | **Description**
:---:| ---
Team Info | List including the team's team ID, franchise ID, team name, abbreviation, and link
Best Season | Season with the highest win percentage for a team
Worst Season | Season with the lowest win percentage for a team
Average Win Percentage | Average win percentage of all games for a team
Most Goals Scored | Highest number of goals a particular team has scored in a single game
Fewest Goals Scored | Lowest number of goals a particular team has scored in a single game
Favorite Opponent | Name of the opponent that has the lowest win percentage against the given team
Rival | Name of the opponent that has the highest win percentage against the given team
Biggest Team Blowout | Biggest difference between team goals and opponent goals for a win for the given team
Worst Loss | Biggest difference between team goals and opponent goals for a loss for the given team
Head to Head | List of opponents that the team has played and their win percentage against that opponent
Seasonal Summary | Seasonal breakdown with all info

### Season Statistics
These methods each take a `season_id` as an argument and return the values described below.

**Statistic** | **Description** 
:---:| ---
Biggest Bust | Team that suffered the biggest decrease between their regular and post\-season records 
Biggest Surprise | Team that achieved the biggest increase between their regular and post\-season records 
Winningest Coach | Toach with the most wins in the given season 
Worst Coach | Toach with the fewest wins in the given season 
Most Accurate Team | Team with the best ratio of shots taken to goals made in the given season 
Least Accurate Team | Team with the worst ratio of shots taken to goals made in the given season 
Most Tackles | Team with the largest amount of tackles in the given season 
Fewest Tackles | Team with the lowest amount of tackles in the given season 

# Authors 
<p>
  <a href="https://github.com/tylertomlinson">Tyler Tomlinson</a>
 </p>
 <p>
  <a href="https://github.com/mronauli">Maria Ronauli</a>
 </p>
 <p>
  <a href="https://github.com/Yetidancer">Ezekiel Clark</a>
 </p>
 <p>
  <a href="https://github.com/d-atkins">David Atkins</a>
 </p>
 
 # Contributing
- Fork repo (https://github.com/tylertomlinson/futbol)
- Create your feature branch (`git checkout -b feature/fooBar`)
- Commit your changes (`git commit -m 'Add some fooBar'`)
- Push to the branch (`git push origin feature/fooBar`)
- Create a new Pull Request
