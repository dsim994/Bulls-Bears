//
//  SearchParser.swift
//  Bulls & Bears
//
//  Created by Dylan Simerly on 4/23/17.
//  Copyright © 2017 dylansimerly. All rights reserved.
//

import Foundation
import Alamofire

class SearchParser: Parser {
    
    class func getSymbols(_ searchString: String, completionHandler: @escaping (_ searchResults: [Result]?, _ error: NSError?) -> Void)  {
        
        var queryString = searchString
        
        if let encoded = searchString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed) {
            queryString = encoded
        }
        
        let responseObjectType = SearchResult()
        
        let urlString = "https://s.yimg.com/aq/autoc?query=\(queryString)&region=US&lang=en-US"
        
        requestAndResponseObject(HTTPMethod.get, urlString: urlString, responseObjectType: responseObjectType) { (responseObject, error) in
            
            if (responseObject?.resultSet?.results != nil) {
                completionHandler(responseObject!.resultSet!.results!, nil)
            } else {
                completionHandler(nil, error)
            }
        }
    }
}
