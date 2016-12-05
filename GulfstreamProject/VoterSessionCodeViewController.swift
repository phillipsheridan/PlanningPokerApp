//
//  VoterSessionCodeViewController.swift
//  GulfstreamProject
//
//  Created by Phil on 8/24/16.
//  Copyright © 2016 Armstrong. All rights reserved.
//

import UIKit

class VoterSessionCodeViewController: CustomViewController, UITextFieldDelegate {
    var valid = 0
    var inputValue = [String]()
    @IBOutlet weak var enterRoom: UIButton!
    
    @IBOutlet weak var errText: UILabel!
    var sessionCode: String!
   
    @IBOutlet var txtSessionCode: UITextField!
   
    
    @IBAction func submit(_ sender: UIButton) {
        dismissKeyboard()
        errText.text = "";
        let request = NSMutableURLRequest(url: NSURL(string: "http://" + IP.getAddress() + ":8080/checkForHostSession.php")! as URL)
        request.httpMethod = "POST"
        let postString = "a=\(txtSessionCode.text!)"
        self.sessionCode = txtSessionCode.text!
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
            print("responseString = \(responseString)")
            self.valid = Int(res)!
            if 0 == self.valid {
                //self.errText.text = "Invalid Session code, ask your Host again!"
                DispatchQueue.main.async(execute: { () -> Void in
                    self.errText.text = "Invalid Session code, ask your Host again!"
                    self.enterRoom.isHidden = true
                })
            } else {
                DispatchQueue.main.async(execute: { () -> Void in
                    self.errText.text = "Valid Session code, nice!"
                    self.enterRoom.isHidden = false
                    
                    
                })
                            }
        }
        task.resume()

        
    }
    
        override func viewDidLoad() {
        super.viewDidLoad()
       
        //self.txtSessionCode.delegate = self
        
}
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "VoterRoom") {
            self.enterRoom.isHidden = true
            self.errText.text = ""
            let session = self.sessionCode

            
            let nextViewController = (segue.destination as! VoterNameController)
            nextViewController.sessionNumber = session
             
        }
        
    }
    
    
    
    
}
