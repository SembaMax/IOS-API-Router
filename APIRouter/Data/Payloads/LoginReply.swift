//
//  LoginReply.swift
//  APIRouter
//
//  Created by SeMbA on 6/10/19.
//  Copyright © 2019 SeMbA. All rights reserved.
//

import Foundation
import SwiftyJSON

class LoginReply: Codable {
    
    var id: Int?
    var name: String?
    
    // in case of Pascal format
    private enum CodingKeys: String, CodingKey {
        case id = "Id"
        case name = "Name"
    }
    
    // for using SwiftyJSON
    init(json: JSON?)
    {
        id = json?["id"].intValue
        name = json?["name"].stringValue
    }
    
}
