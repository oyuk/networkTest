//
//  APIClient.swift
//  networkTest
//
//  Created by oky on 2015/01/17.
//  Copyright (c) 2015年 oky. All rights reserved.
//

import Foundation
import Alamofire


//http://www.raywenderlich.com/85080/beginning-alamofire-tutorial

enum Router : URLRequestConvertible {
    
    static let url = "https://app.rakuten.co.jp/services/api/BooksBook/Search/20130522?format=json"
    static let apiKey = "xxxxxxxxxxxxxxxx"
 
    case Author(String)
    case TITLE(String)
    
    var URLRequest:NSURLRequest {
        
        let parameters:[String:AnyObject] =  {
            
            var params = ["applicationId":Router.apiKey,"sort":"sales"]
            
            switch self {
            case .Author(let author):
                params[param.AUTHOR] = author
                return params
            case .TITLE(let title):
                params[param.TITLE] = title
                return params
            }
            
            
        }()
        
        let urlRequest = NSURLRequest(URL: NSURL(string: Router.url)!)
        let encoding = Alamofire.ParameterEncoding.URL
        return encoding.encode(urlRequest, parameters: parameters).0
    }
    
}
