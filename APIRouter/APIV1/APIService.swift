//
//  MadinatyService.swift
//  Fer2etak
//
//  Created by SeMbA on 7/19/17.
//  Copyright © 2017 SeMbA. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

//<summary>
//This is the HttpService using Alamofire. this class contains the main 3 methods that the app would use in different screens.
//This version is using SwiftyJSON. it's deprecated since Alamofire4.6 has provided Codable feature.
//</summary>

open class APIService {
    
    
    class func getData(_ url:String, params:[String: AnyObject]?, callback: @escaping (JSON, StatusEnum) -> Void)
    {
        var request = URLRequest(url: URL(string: url)!)
        /*let configuration = URLSessionConfiguration.default
        let manager = Alamofire.SessionManager(configuration: configuration)*/
        
        request.httpMethod = "GET"
        //request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.allHTTPHeaderFields = Constants.webApiHeaders
        
        Alamofire.request(url, method: .get, parameters: params, headers: Constants.webApiHeaders)
            .validate().responseJSON{ response in

                if (response.response?.statusCode == 200)
                {
                    //--------------------- OK --------------------------//
                    
                    let response = response.result.value
                    let tunnelingStatus = Reply.Status(json: JSON(response ?? "")["Status"])
                    
                    if  response != nil && tunnelingStatus.status == "OK"{
                        callback(JSON(response ?? ""), StatusEnum.OK)
                    }
                    else
                    {
                        //--------------------- Error --------------------------//
                        
                        callback(JSON.null, StatusEnum.Error)
                    }
                    
                }
                else
                {
                    //--------------------- Server Error --------------------------//
                    
                    callback(JSON.null, StatusEnum.Internal_Server_Error)
                }
        }
    }
    
    class func postData(_ url:String, body: [String:AnyObject],  callback: @escaping (JSON, StatusEnum) -> Void)
    {
        //----------------------- Optional Structure --------------------------------//
        //        var request = URLRequest(url: URL(string: url)!)
        //        request.httpMethod = "POST"
        //        request.allHTTPHeaderFields = Constants.webApiHeaders
        //
        //        let postData = try! JSONSerialization.data(withJSONObject: body, options: [])
        //        request.httpBody = postData as Data
        //
        //
        //        Alamofire.request(request)
        //            .validate().responseJSON { response in
        
        
        Alamofire.request(url, method: .post ,parameters: body ,encoding: JSONEncoding.default,headers: Constants.webApiHeaders).responseJSON { response in
            
            if (response.response?.statusCode == 200)
            {
                //--------------------- OK --------------------------//
                
                let response = response.result.value
                let tunnelingStatus = Reply.Status(json: JSON(response ?? "")["Status"])
                
                if  response != nil && tunnelingStatus.status == "OK"{
                    callback(JSON(response ?? ""), StatusEnum.OK)
                }
                else{
                    //--------------------- Error --------------------------//
                    
                    callback(JSON(response ?? ""), StatusEnum.Error)
                }
            }
            else
            {
                //--------------------- Server Error --------------------------//
                callback(JSON.null, StatusEnum.Internal_Server_Error)
            }
            
        }
    }
    
    class func putData(_ url:String, body: [String:AnyObject],  callback: @escaping (JSON, StatusEnum) -> Void)
    {
        //----------------------- Optional Structure --------------------------------//
        //        var request = URLRequest(url: URL(string: url)!)
        //        request.httpMethod = "PUT"
        //        request.allHTTPHeaderFields = Constants.webApiHeaders
        //
        //        let postData = try! JSONSerialization.data(withJSONObject: body, options: [])
        //        request.httpBody = postData as Data
        //
        //
        //        Alamofire.request(request)
        //            .validate().responseJSON { response in
        
        
        Alamofire.request(url, method: .put ,parameters: body ,encoding: JSONEncoding.default,headers: Constants.webApiHeaders).responseJSON { response in
            
            if (response.response?.statusCode == 200)
            {
                //--------------------- OK --------------------------//
                
                let response = response.result.value
                let tunnelingStatus = Reply.Status(json: JSON(response ?? "")["Status"])
                
                if  response != nil && tunnelingStatus.status == "OK"{
                    callback(JSON(response ?? ""), StatusEnum.OK)
                }
                else{
                    //--------------------- Error --------------------------//
                    
                    callback(JSON.null, StatusEnum.Error)
                }
            }
            else
            {
                //--------------------- Server Error --------------------------//
                callback(JSON.null, StatusEnum.Internal_Server_Error)
            }
        }
    }
            
}
