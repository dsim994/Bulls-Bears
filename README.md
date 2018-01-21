# Bulls-Bears

### iOS Developer Nanodegree Final Project

### Overview

__UPDATE__- The Yahoo Finance Api for quotes has been shut down since the Verizon Merge. I am currently transitioning to the iex trading api as well as redesigning the layout and adding new features. Stay Tuned!

Bulls and Bears is a stock quote app that uses the _Yahoo Finance API_ to request stock data for a searched company. This app also has a watchlist feature that uses core data for users to save and display companies their interested in.  

The complete project specifications can be found [here](https://review.udacity.com/#!/rubrics/23/view)

<p align="center">
  <img src="Bulls & Bears.gif/Bulls&Bears_Demo.gif"> 
</p>

### Implementation

This app has 4 View Controller Scenes:

* __Search__- When the app is launched the user is presented with a simple background view, watchlist button, and search bar. The user can enter the name of a desired company to search or press the watchlist button and they are directed to the their watchlist. If a new company is entered the API fetches and parses all the companies(and their data) that match the search while the user is directed to the Symbol View.

* __Symbol__- The user is presented with a list of companies that match the search to choose from. Once the user selects a company they are then direted to the Quote View.

* __Quote__- The data for selected company is then displayed in a tableview. If the user wants to add selected company to their watchlist they simply press the +watchlist button and are directed to the Watchlist view while selected company is saved in core data. When the user is finished they can simply back out to the Search view to enter a new company.

* __Watchlist__- This view allows the user to see the companies they have saved. It can be accessed from the Search view or when a new company is added.


### Installation
Run `pod install` from terminal and open __.xcworkspace__ instead of .xcodeproj

### Requirements
* Xcode 9.0
* Swift 4.0
