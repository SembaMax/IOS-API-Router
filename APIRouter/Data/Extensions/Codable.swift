//
//  Codable.swift
//  APIRouter
//
//  Created by SeMbA on 6/10/19.
//  Copyright © 2019 SeMbA. All rights reserved.
//

import Foundation
extension Encodable {
    func asDictionary() -> [String: AnyObject?] {
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let data = try encoder.encode(self)
            //Notice(t) : that commented code is for testing the request body's form.
            /*let reqJSONStr = String(data: data, encoding: .utf8)
             var testDic: [String: Any]
             if let dataV2 = reqJSONStr?.data(using: .utf8) {
             do {
             testDic = (try JSONSerialization.jsonObject(with: dataV2, options: []) as? [String: Any])!
             } catch {
             print(error.localizedDescription)
             }
             }*/
            guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: AnyObject?] else {
                return [:]
            }
            return dictionary
        } catch {
            return [:]
        }
    }
}
