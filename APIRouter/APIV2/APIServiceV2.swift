//
//  ServiceTest.swift
//  Fer2etak
//
//  Created by SeMbA on 3/19/18.
//  Copyright © 2018 SeMbA. All rights reserved.
//

import Foundation
import Alamofire
import CodableAlamofire

//<summary>
//This is the HttpService using Alamofire Codable. this class contains the main 3 methods that the app would use in different screens.
//This version is using Codable models. So keep working with this class.
//</summary>

open class APIServiceV2<T: Decodable> {
    
    func getData(_ url: String, params: [String: AnyObject]?, callback: @escaping (T?, StatusEnum) -> Void) {
        
        //let sessionManager = Alamofire.SessionManager.default
        //sessionManager.retrier = RetryHandler()
        var request = URLRequest(url: URL(string: url)!)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .customISO8601
        //decoder.keyDecodingStrategy = .convertFromPascal
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = Constants.webApiHeaders
        
        Alamofire.request(url, parameters: params, headers: Constants.webApiHeaders)
            .responseDecodableObject(keyPath: nil, decoder: decoder) { (response: DataResponse<T>) in
                
                do {
                    if (response.result.isSuccess)
                    {
                        //--------------------- OK --------------------------//
                        let payload = try decoder.decode(T.self, from: response.data!) as T
                        let tunnelingStatus = (payload as! HttpResponse).Status
                        
                        if  tunnelingStatus?.Status == "OK"{
                            callback(payload, StatusEnum.OK)
                        }
                        else if (tunnelingStatus?.Status == "ServiceUnavailable") {
                            callback(payload, StatusEnum.Service_Unavailable)
                        }
                        else
                        {
                            //--------------------- Error --------------------------//
                            
                            callback(payload, StatusEnum.Error)
                        }
                        
                    }
                    else
                    {
                        //--------------------- Server Error --------------------------//
                        
                        callback(nil, StatusEnum.Internal_Server_Error)
                    }
                } catch {
                    callback(nil, StatusEnum.Internal_Server_Error)
                }
        }
    }
    
    class func postData(_ url:String, body: Codable,  callback: @escaping (T?, StatusEnum) -> Void)
    {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let data = body.asDictionary()
        Alamofire.request(url, method: .post ,parameters: data ,encoding: JSONEncoding.default,headers: Constants.webApiHeaders).responseDecodableObject(keyPath: nil, decoder: decoder) { (response: DataResponse<T>) in
            
            do {
                if (response.result.isSuccess)
                {
                    //--------------------- OK --------------------------//
                    let payload = try decoder.decode(T.self, from: response.data!) as T
                    let tunnelingStatus = (payload as! HttpResponse).Status
                    
                    if  tunnelingStatus?.Status == "OK"{
                        callback(payload, StatusEnum.OK)
                    }
                    else
                    {
                        //--------------------- Error --------------------------//
                        
                        callback(payload, StatusEnum.Error)
                    }
                    
                }
                else
                {
                    //--------------------- Server Error --------------------------//
                    
                    callback(nil, StatusEnum.Internal_Server_Error)
                }
            } catch {
                callback(nil, StatusEnum.Internal_Server_Error)
            }
        }
    }
    
    class func putData(_ url:String, body: Codable?,  callback: @escaping (T?, StatusEnum) -> Void)
    {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        Alamofire.request(url, method: .put ,parameters: body?.asDictionary() ?? [:] ,encoding: JSONEncoding.default,headers: Constants.webApiHeaders).responseDecodableObject(keyPath: nil, decoder: decoder) { (response: DataResponse<T>) in
            
            do {
                if (response.result.isSuccess)
                {
                    //--------------------- OK --------------------------//
                    let payload = try decoder.decode(T.self, from: response.data!) as T
                    let tunnelingStatus = payload is ReplyV2.Status ? (payload as! ReplyV2.Status) : (payload as! HttpResponse).Status
                    
                    if  tunnelingStatus?.Status == "OK"{
                        callback(payload, StatusEnum.OK)
                    }
                    else
                    {
                        //--------------------- Error --------------------------//
                        
                        callback(payload, StatusEnum.Error)
                    }
                    
                }
                else
                {
                    //--------------------- Server Error --------------------------//
                    
                    callback(nil, StatusEnum.Internal_Server_Error)
                }
            } catch {
                callback(nil, StatusEnum.Internal_Server_Error)
            }
        }
    }
    
    class func deleteData(_ url:String,  callback: @escaping (T?, StatusEnum) -> Void)
    {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        Alamofire.request(url, method: .delete ,parameters: nil ,encoding: JSONEncoding.default,headers: Constants.webApiHeaders).responseDecodableObject(keyPath: nil, decoder: decoder) { (response: DataResponse<T>) in
            
            do {
                if (response.result.isSuccess)
                {
                    //--------------------- OK --------------------------//
                    let payload = try decoder.decode(T.self, from: response.data!) as T
                    let tunnelingStatus = (payload as! HttpResponse).Status
                    
                    if  tunnelingStatus?.Status == "OK"{
                        callback(payload, StatusEnum.OK)
                    }
                    else
                    {
                        //--------------------- Error --------------------------//
                        
                        callback(nil, StatusEnum.Error)
                    }
                    
                }
                else
                {
                    //--------------------- Server Error --------------------------//
                    
                    callback(nil, StatusEnum.Internal_Server_Error)
                }
            } catch {
                callback(nil, StatusEnum.Internal_Server_Error)
            }
        }
    }

}
