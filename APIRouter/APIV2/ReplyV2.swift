//
//  ReplyTest.swift
//  Fer2etak
//
//  Created by SeMbA on 3/19/18.
//  Copyright © 2018 SeMbA. All rights reserved.
//

import Foundation

//<summary>
//A generic data class that use generics<T> to handle all the possible API models (Request/Response).
//The same interface has to be implemented with the same structure at Backend side.
//This one is used with Codable models.
//Finally: This model is architected by Eng.Tarek Samy https://www.linkedin.com/in/tsamy/
//</summary>

protocol HttpResponse: Codable {
    var Status: ReplyV2.Status? {get set}
}

open class ReplyV2: Codable {
    
    open class Single<T: Codable>:HttpResponse
    {
        var Item: T?
        var Status: ReplyV2.Status?
    }
    
    open class Many<T: Codable>:HttpResponse
    {
        var Items: [T]?
        var Status: ReplyV2.Status?
    }
    
    open class Paged<T: Codable>:HttpResponse
    {
        var PagingInfo: WithPagingInfo<T>?
        var Status: ReplyV2.Status?
    }

    open class WithPagingInfo<T: Codable>: Codable
    {
        var Items: [T]?
        var Paging: PagingInfo?
    }

    open class PagingInfo: Codable
    {
        
        var CurrentPage: Int?
        var PageSize: Int?
        var TotalResults: Int?
        var TotalPages: Int?
    }
    
    open class Status: Codable
    {
        var Status: String?
        var Message: String?
        var SessionId: String?
        var HasPaging: Bool?
        var ValidationErrors: [String: [String]]?
        
    }
    
}
