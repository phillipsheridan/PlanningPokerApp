//
//  ValidVoterSessionRoom.swift
//  GulfstreamProject
//
//  Created by Phil on 10/22/16.
//  Copyright © 2016 Armstrong. All rights reserved.
//

import UIKit

class ValidVoterSessionRoom: UIViewController {

    var name : String!
    @IBOutlet weak var nameTf: UILabel!
    // host id
    var sessionNumber:Int!
    //boolean to check if host session is for complexity or business value
    var forComplexity:Bool!
    //voter's current vote
    var voteValue:Float!
    //voter device string
    var device = UIDevice.current.identifierForVendor!.uuidString
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTf.text = name
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Exit", style: .plain, target: self, action: #selector(exitTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Vote", style: .plain, target: self, action: #selector(voteTapped))
       
        
        //need to know which viewController to show (forComplexity or not?) and add voter if not added yet
        let request = NSMutableURLRequest(url: NSURL(string: "http://10.0.0.12:8080/getForComplexity.php")! as URL)
        request.httpMethod = "POST"
        let postString = "a=\(sessionNumber!)b=\(device)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
            print("response = \(response)")
            print("device = " + self.device)
            
            
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)!
            
            
            let res = responseString as String
            print("responseString = \(responseString)")
            self.forComplexity = self.parseJSONBool(text: res)
            self.setTitle()
        }
        task.resume()
        
        

        
        
        
        

        // Do any additional setup after loading the view.
    }
    func exitTapped () {
        _ = self.navigationController?.popViewController(animated: true)
        
        
    }
    func voteTapped () {
        
    }
    
    func parseJSONBool(text: String) -> Bool {
        var substring = ""
        if let startRange = text.range(of:":"), let endRange = text.range(of:"}") {
            substring = text[startRange.upperBound..<endRange.lowerBound]
        }
        return Bool(substring)!
    }
    func setTitle() {
        if self.forComplexity! {
            self.title = "Complexity"
        }
        else {
            self.title = "Business Value"
        }
    }
 
    
    
    

    
}
