//
//  ViewController.swift
//  APIRouter
//
//  Created by SeMbA on 6/10/19.
//  Copyright © 2019 SeMbA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        performLogin()
    }
    
    private func performLogin()
    {
        RemoteWork.loginV2(email: "Email", password: "Password") { (_response, _status, _validations) in
            //Do Stuff
        }
        
    }
    
    
    
    
}

