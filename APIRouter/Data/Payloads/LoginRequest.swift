//
//  LoginRequest.swift
//  APIRouter
//
//  Created by SeMbA on 6/10/19.
//  Copyright © 2019 SeMbA. All rights reserved.
//

import Foundation
class LoginRequest: Codable {
    
    var email : String?
    var password: String?
    
    init(email: String?, password: String?) {
        self.email = email
        self.password = password
    }
    
    // in case of Pascal format
    private enum CodingKeys: String, CodingKey {
        case email = "Email"
        case password = "Password"
    }
}
