# Stock Tracker

Currently Trying to find a new API!

### Overview

Swift application that uses the _IEX Trading API_ to request financial investment data for users searched company

### Implementation

4 View Controller Scenes:

* __CompanySearch__- Upon launch the user is presented with a simple search bar at the top of view. User can enter the name of a desired company to search and they are directed to CompanyDataProfile while the IEX Trading API fetches the financial data. 

* __CompanyDataProfile__- The user is then presented with the most recent price (bid-ask underneath), a financial data chart, a tableView of key data, and another tableView of the 10 most recent news articles for the searched company. Users can press show more under the key data tableView and they will be directed to CompanyStats. Pressing show more under the news tableView will direct user to CompanyNews.

* __CompanyStats__- User is presented with another display of the most recent price of the stock of a searched company (bid-ask underneath) at the top of the view. Displayed below is some of the same key data seen in CompanyDataProfile as well as over 40 different pieces of technical indacating statistical data from searched company. 

* __CompanyNews__- User is presented with the 100 most recent news articles of a searched company displayed in a tableView. Each cell has a headline and summary along with a link to direct you to the origins of the article if you wish to consume it in full.


This is currently a working progress, but I am loving the challege and hope to publish this in the future.


### Requirements
* Xcode 10.0
* Swift 5.0
