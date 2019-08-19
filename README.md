# Stock Tracker

### Overview

Stock Tracker is a financial app that uses the _IEX Trading API_ to request stock data for a searched company

### Implementation

This app has 4 View Controller Scenes:

* __CompanySearch__- When the app is launched the user is presented with a simple search bar at the top of the screen for now. The user can enter the name of a desired company to search they are directed to the CompanyDataProfile view. 

* __CompanyDataProfile__- The user is presented with a financial data chart, a tableView of key data, and another tableView of the 10 most recent news articles for the searched company. Users can click the show more button under the key data tableView and the will be directed to the CompanyStats view. Clicking the show more button under the news tableView will redirect the user to thr CompanyNews view.

* __CompanyStats__- The data for selected company is then displayed in a tableview. If the user wants to add selected company to their watchlist they simply press the +watchlist button and are directed to the Watchlist view while selected company is saved in core data. When the user is finished they can simply back out to the Search view to enter a new company.

* __CompanyNews__- This view allows the user to see the companies they have saved. It can be accessed from the Search view or when a new company is added.




### Requirements
* Xcode 10.0
* Swift 5.0
