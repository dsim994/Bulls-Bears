# Bulls-Bears
### iOS Developer Nanodegree Final Project

### Overview

Bulls and Bears is a stock quote app that uses the _Yahoo Finance API_ to request stock data for a searched company. This app also has a watchlist feature that uses core data for users to save and display companies their interested in.  

The complete project specifications can be found [here](https://review.udacity.com/#!/rubrics/23/view)

<p align="center">
  <img src="Bulls & Bears.gif/Bulls&Bears_Demo.gif"> 
</p>

### Implementation

This app has 4 View Controller Scenes:

* __Search__- When the app is launched the user is presented with a simple background view and search bar. The user then enters the name of a desired company to search. Then they are directed to the Symbol View while the API fetches and parses all the companies(and their data) that match the search.

* __Symbol__- The user is then presented with a list of companies that match the search to choose from. Once the user selects a company they are then direted to the Quote View.

* __Quote__- The data for selected company is then displayed in a tableview. When the user is finished they can simply back out to the Search view and enter a new company.

* __Watchlist__-


### Installation
Run `pod install` from terminal and open **.xcworkspace** instead of .xcodeproj

### Requirements
* Xcode 8.0
* Swift 3.0
