//
//  OAuth2RetryHandler.swift
//  Fer2etak
//
//  Created by SeMbA on 6/1/18.
//  Copyright © 2018 SeMbA. All rights reserved.
//

import Foundation
import Alamofire

class RetryHandler: RequestRetrier {
    
    /// Intercept 401 and do an OAuth2 authorization.
    public func should(_ manager: SessionManager, retry request: Request, with error: Error, completion: @escaping RequestRetryCompletion) {
        if let response = request.task?.response as? HTTPURLResponse, 503 == response.statusCode, let req = request.request {
            completion(true, 0.0) //How to get the tunneling Status Code ??!
        }
        else {
            completion(false, 0.0)   // not a 401, not our problem
        }
    }
}
