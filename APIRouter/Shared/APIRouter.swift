//
//  Fer2etakRouter.swift
//  Fer2etak
//
//  Created by SeMbA on 2/25/18.
//  Copyright © 2018 SeMbA. All rights reserved.
//

import Foundation
import Alamofire

//<summary>
//Since Alamofire doesn't have a way to define url path paramters so this class is implemented to handle and encode all the query and path paramters to URLs.
//</summary>

class APIRouter {
    
    var routerBaseUrl = ""
    var defaultParameters: [String:AnyObject] = [:]
    var urlPaths: [String:String] = [:]
    var passedParameters: [String : AnyObject?] = [:]
    
    init(baseUrl: String, paths: [String : String]?, Parameters: [String : AnyObject?]?) {
        routerBaseUrl = baseUrl
        urlPaths = paths ?? [:]
        passedParameters = Parameters ?? [:]
        
        let lang = (LocaleManager.currentLocale) as AnyObject
        defaultParameters = ["lang" : lang]
    }
    
    func asURLRequest() -> String {
        
        var finalUrl = routerBaseUrl
        for (text,value) in urlPaths {
            finalUrl = finalUrl.replacingOccurrences(of: text , with: value, options: .literal, range: nil)
        }
        
        for (query,value) in passedParameters {
            if value != nil {
               defaultParameters.updateValue(value!, forKey: query)
            }
        }
        let url = URL(string: finalUrl)!
        let urlRequest = URLRequest(url: url)
        
       let encodedData = try? URLEncoding(destination: .queryString).encode(urlRequest , with: defaultParameters)
        guard let returnValue = encodedData?.url?.absoluteString else {
            return ""
        }
        
        return returnValue
    }
    
    
}
