//
//  VoterNameController.swift
//  GulfstreamProject
//
//  Created by Phil on 10/23/16.
//  Copyright © 2016 Armstrong. All rights reserved.
//

import UIKit

class VoterNameController: CustomViewController, UITextFieldDelegate {

    @IBOutlet weak var nameTf: UITextField!
    var voterId: String!
    var name: String!
    var sessionNumber : String! //changed
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameTf.delegate = self

            }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "NameEntered") {
            name = nameTf.text
            voterId = UIDevice.current.identifierForVendor!.uuidString
            //force unwrap optionals
            
            if let voterIdValue = voterId, let nameValue = name, let hostIdValue = sessionNumber {
            
            
            
            let nextViewController = (segue.destination as! ValidVoterSessionRoom)
            nextViewController.sessionNumber = hostIdValue
            nextViewController.name = self.nameTf.text
            
            let request = NSMutableURLRequest(url: NSURL(string: "http://" + IP.getAddress() + ":8080/insertVoter.php")! as URL)
            
            request.httpMethod = "POST"
            let postString = "a=\(nameValue)&b=\(voterIdValue)&c=\(hostIdValue)"
            request.httpBody = postString.data(using: String.Encoding.utf8)
            let task = URLSession.shared.dataTask(with: request as URLRequest) {
                data, response, error in
                
                if error != nil {
                    print("error=\(error)")
                    return
                }
                
                print("response = \(response)")
                
                
                let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)!
                
                
                
                print("responseString = \(responseString)")
                
                            }
            task.resume()

        }
        }
    }

    

   
}
