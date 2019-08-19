# Stock Tracker

### Overview

Financial app that uses the _IEX Trading API_ to request stock data for a searched company

### Implementation

4 View Controller Scenes:

* __CompanySearch__- When the app is launched the user is presented with a simple search bar at the top of the screen. The user can enter the name of a desired company to search and they are directed to CompanyDataProfile. 

* __CompanyDataProfile__- The user is then presented with the most recent selling price (bid and ask underneath), a financial data chart, a tableView of key data, and another tableView of the 10 most recent news articles for the searched company. Users can click the show more button under the key data tableView and they will be directed to CompanyStats. Clicking the show more button under the news tableView will direct the user to CompanyNews.

* __CompanyStats__- Top of the view is another display of the most recent price of the stock of a searched company (bid-ask underneath). Below is over 40 different pieces of statistical data from searched company displayed. 

* __CompanyNews__- The 100 most recent news articles of a searched company is displayed in a tableView. Each cell has a headline and summary that is a link to direct you to the origins of the article if you wish to consume it in full.


This is currently a working progress, but I am loving the challege and hope to publish this in the future.


### Requirements
* Xcode 10.0
* Swift 5.0
