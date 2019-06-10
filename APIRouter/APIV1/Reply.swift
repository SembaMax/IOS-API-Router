//
//  APIReply.swift
//  Fer2etak
//
//  Created by SeMbA on 7/22/17.
//  Copyright © 2017 SeMbA. All rights reserved.
//

import Foundation
import SwiftyJSON

//<summary>
//A generic data class that use generics<T> to handle all the possible API models (Request/Response).
//The same interface has to be implemented with the same structure at Backend side.
//This one is used with SwiftyJSON models.
//Finally: This model is architected by Eng.Tarek Samy https://www.linkedin.com/in/tsamy/
//</summary>
open class Reply {
    
    open class Single<T>
    {
        var item: T?
        var status: Status?
        
        init(item:T?, status: JSON?) {
            self.item = item
            self.status = Status(json: status)
        }
    }
    
    open class Many<T>
    {
        var items: [T]?
        var status: Status?
        
        init(items:[T]?, status: JSON?) {
            self.items = items
            self.status = Status(json: status)
        }
    }
    
    open class Paged<T>
    {
        var itemsWithPaging: WithPagingInfo<T>?
        var status: Status?
        
        init(items: [T], withPagingInfo:JSON?, status: JSON?) {
            self.itemsWithPaging = WithPagingInfo(items: items, pagingInfoJson: withPagingInfo)
            self.status = Status(json: status)
        }
    }
    
    
    open class WithPagingInfo<T>
    {
        var items: [T]?
        var pagingInfo: PagingInfo?
        
        init(items:[T]?, pagingInfoJson: JSON?) {
            self.items = items
            self.pagingInfo = PagingInfo(json: pagingInfoJson)
        }
    }
    
    open class PagingInfo
    {
        var currentPage: Int?
        var pageSize: Int?
        var totalResults: Int?
        var totalPages: Int?
        
        init(json: JSON?) {
            self.currentPage = json?["CurrentPage"].intValue
            self.pageSize = json?["PageSize"].intValue
            self.totalPages = json?["TotalPages"].intValue
            self.totalResults = json?["TotalResults"].intValue
        }
    }
    
    open class Status
    {
        var status: String?
        var message: String?
        var sessionId: String?
        var hasPaging: Bool?
        var validationErrors: [String: [String]]?
        
        init(json: JSON?) {
            
            status = json?["Status"].stringValue
            message = json?["Message"].stringValue
            sessionId = json?["SessionId"].stringValue
            hasPaging = json?["HasPaging"].boolValue
            validationErrors = [:]
            
            if let errorsDic:[String : JSON]  = json?["ValidationErrors"].dictionaryValue
            {
                
                for ItemAnyObj in errorsDic {
                    var innerArray:[String] = []
                    
                    for errorTitle in ItemAnyObj.value.arrayValue {
                    innerArray.append(errorTitle.stringValue)
                    }
                    validationErrors?[ItemAnyObj.key] = innerArray
                }
            }
        }
    }
    
}
