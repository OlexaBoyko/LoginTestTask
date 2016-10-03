//
//  ViewController.swift
//  LoginTestTask
//
//  Created by Olexa Boyko on 10/2/16.
//  Copyright © 2016 Olexa Boyko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var loginButton: FBSDKLoginButton
        loginButton = FBSDKLoginButton()
        loginButton.readPermissions = ["email", "public_profile"]
        
        view.addSubview(loginButton)
        loginButton.center = view.center
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let DestViewController: InfoView = segue.destination as! InfoView
        DestViewController.token = FBSDKAccessToken.current().tokenString
    }

}

