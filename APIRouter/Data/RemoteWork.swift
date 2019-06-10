//
//  RemoteWork.swift
//  APIRouter
//
//  Created by SeMbA on 6/10/19.
//  Copyright © 2019 SeMbA. All rights reserved.
//

import Foundation

open class RemoteWork
{
    class func loginV1(_ email:String?, password:String?, callback:@escaping (AnyObject?, StatusEnum , [String: [String]]?)->Void)
    {
        let url = Config.baseUrl + Config.login
        let encodedUrl = APIRouter(baseUrl: url, paths: nil, Parameters: nil).asURLRequest()
        let payload: [String: String] = ["Email": email ?? "", "Password": password ?? ""]
        APIService.postData(encodedUrl, body: payload as [String : AnyObject]) { (JSON, Status) in
            
            if(Status == StatusEnum.OK)
            {
                callback(Reply.Single<LoginReply>(item: LoginReply(json: JSON["Item"]), status: JSON["Status"]), Status, nil);
            }
            else if(Status == StatusEnum.Error)
            {
                callback(Reply.Status(json: JSON["Status"]),Status, Reply.Status(json: JSON["Status"]).validationErrors)
            }
            else
            {
                callback(nil, Status, nil)
            }
        }
    }
    
    class func loginV2(email:String?, password:String?, _ callback: @escaping (AnyObject?, StatusEnum, [String: [String]]?)->Void)
    {
        let url = Config.baseUrl + Config.login
        let encodedUrl = APIRouter(baseUrl: url, paths: nil, Parameters: nil).asURLRequest()
        APIServiceV2<ReplyV2.Single<LoginReply>>.postData(encodedUrl, body: LoginRequest(email: email, password: password)) { (Reply, Status) in
            
            if(Status == StatusEnum.OK)
            {
                let reponse = Reply
                callback(reponse ,Status, nil);
            }
            else if(Status == StatusEnum.Error)
            {
                let status = Reply?.Status
                callback(status,Status,status?.ValidationErrors)
            }
            else
            {
                callback(nil, Status, nil)
            }
        }
    }
    
    class func getItemsV1(categoryId: Int, _ callback: @escaping (AnyObject?, StatusEnum, [String: [String]]?)->Void)
    {
        let url = Config.baseUrl + Config.items
        let paths = ["categoryId" :  String(describing: categoryId)]
        let encodedUrl = APIRouter(baseUrl: url, paths: paths, Parameters: nil).asURLRequest()
        APIService.getData(encodedUrl, params: nil) { (JSON, Status) in
            
            if(Status == StatusEnum.OK)
            {
                var items = Array<Item>()
                let itemsJson = JSON["Items"].arrayValue
                for json in itemsJson {
                    items.append(Item(json: json))
                }
                
                callback(Reply.Many<Item>(items: items , status: JSON["Status"]),Status, nil);
            }
            else if(Status == StatusEnum.Error)
            {
                callback(Reply.Status(json: JSON["Status"]),Status, Reply.Status(json: JSON["Status"]).validationErrors)
            }
            else
            {
                callback(nil, Status, nil)
            }
        }
    }

    class func getItemsV2(categoryId: Int, _ callback: @escaping (AnyObject?, StatusEnum, [String: [String]]?)->Void)
    {
        let url = Config.baseUrl + Config.items
        let paths = ["categoryId" :  String(describing: categoryId)]
        let encodedUrl = APIRouter(baseUrl: url, paths: paths, Parameters: nil).asURLRequest()
        APIServiceV2<ReplyV2.Many<Item>>().getData(encodedUrl, params: nil) { (Reply, Status) in
            
            if(Status == StatusEnum.OK)
            {
                let reponse = Reply
                callback(reponse ,Status, nil);
            }
            else if(Status == StatusEnum.Error)
            {
                let status = Reply?.Status
                callback(status,Status,status?.ValidationErrors)
            }
            else
            {
                callback(nil, Status, nil)
            }
        }
    }
}
