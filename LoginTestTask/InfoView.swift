//
//  InfoView.swift
//  LoginTestTask
//
//  Created by Olexa Boyko on 10/3/16.
//  Copyright © 2016 Olexa Boyko. All rights reserved.
//

import Foundation
import UIKit


class InfoView : UIViewController {
    
    @IBOutlet weak var UserAge: UILabel!
    
    @IBOutlet weak var ImageURL: UIImageView!
    
    //variable for transporting token from loginView
    var token: String = ""
    
    @IBOutlet weak var UserName: UILabel!
    
    
    override func viewDidLoad() {
        //Preparing for HTTP Request
        
        let url = URL(string: "http://104.236.248.211/api/v1/login")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = "{\n  \"token\": \"\(token)\",\n  \"firebase_token\":\"\",\n  \"device_type\": \"ios\"\n}".data(using: .utf8)
        
        //Making request
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                print(error)
            } else {
                do {
                    
                    //Getting JSON data
                    
                    let parsedData = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
                    
                    //Output User's name
                    
                    self.UserName.text = parsedData["first_name"] as! String?
                    self.UserName.isHidden = false
                    
                    //Set Age
                    
                    let intAge: Int = (parsedData["age"] as! Int?)!
                    self.UserAge.text = String(describing: intAge)
                    if intAge != 0 {
                        self.UserAge.isHidden = false
                    }
                    
                    // Output image
                    
                    var avatarURL: String = "http://www.john-james-andersen.com/wp-content/uploads/nullimage1.gif"
                    
                    let images : [[String: Any]] = parsedData["photos"] as! [[String : Any]]
                    
                    //iterating through "images" array, getting dictionary [String: Any]
                    for subArray in images {
                        
                        var imgURL: String = ""
                        var isAvatar: Bool = false
                        var id: Int = 0
                        
                        //iterating through Dictionary(Object of image)
                        for value in subArray {
                            
                            switch value.key {
                            case "is_avatar":
                                isAvatar = value.value as! Bool
                            case "id":
                                id = value.value as! Int
                            case "url":
                                imgURL = value.value as! String
                            default:
                                break
                            }
                            if isAvatar{
                                avatarURL = imgURL
                            }
                        }
                    }
                    
                    //Setting Image
                    
                    if let url  = NSURL(string: avatarURL),
                        let data = NSData(contentsOf: url as URL)
                    {
                        self.ImageURL.image = UIImage(data: data as Data)
                    }
                    
                    self.ImageURL.isHidden = false
                    
                } catch let error as NSError {
                    print(error)
                }
                
            }
            
        }
        
        task.resume()
        
    }
    
}
