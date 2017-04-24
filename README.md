# Bulls-Bears
**iOS Developer Nanodegree Final Project**


**Bulls and Bears** is a stock quote app that uses the _Yahoo Finance API_ to request stock data for a searched company







## Installation
Simply run 'pod install' from terminal and open **.xcworkspace** instead of .xcodeproj







## Implementation
This app has 3 View Controllers

**Search**- When the app is launched the user is presented with a simple background view and search bar. The user then enters the name of a desired company to search. Then they are directed to the Symbol View while the API fetches and parses all the companies(and their data) that match the search.

**Symbol**- The user is then presented with a list of companies that match the search to choose from. Once the user selects a company they are then direted to the Quote View.

**Quote**- The data for selected company is then displayed in a tableview. When the user is finished they can simply back out to the Search view and enter a new company.









## Requirements
Xcode 8.0 - Swift 3.0
