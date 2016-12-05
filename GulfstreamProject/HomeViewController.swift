//
//  ViewController.swift
//  GulfstreamProject
//
//  Created by Phil on 8/24/16.
//  Copyright © 2016 Armstrong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://" + IP.getAddress() + ":8080/checkTime.php")! as URL)
        request.httpMethod = "POST"
        let postString = ""
        request.httpBody = postString.data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
            print("response = \(response)")
            
            
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)!
            
            
            let res = responseString as String
            print("responseString = \(res)")
                   }
        task.resume()
    }

    

    @IBAction func btnHost() {
    }

    @IBAction func btnVoter() {
    }
}

