//
//  VoterSessionCodeViewController.swift
//  GulfstreamProject
//
//  Created by Phil on 8/24/16.
//  Copyright © 2016 Armstrong. All rights reserved.
//

import UIKit

class VoterSessionCodeViewController: CustomViewController, UITextFieldDelegate {
    var sessionNumber = 0
    var inputValue = [String]()
    @IBOutlet weak var enterRoom: UIButton!
    
    @IBOutlet weak var errText: UILabel!
    
   
    @IBOutlet var txtSessionCode: UITextField!
   
    
    @IBAction func submit(_ sender: UIButton) {
        dismissKeyboard()
        errText.text = "";
        let request = NSMutableURLRequest(url: NSURL(string: "http://130.254.88.167:8080/checkForHostSession.php")! as URL)
        request.httpMethod = "POST"
        let postString = "a=\(txtSessionCode.text!)"
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
            self.sessionNumber = self.parseJSONInt(text: res)
            if 0 == self.sessionNumber {
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
       
        self.txtSessionCode.delegate = self
        
}
    
    
    
    func parseJSONInt(text: String) -> Int {
        var substring = ""
        if let startRange = text.range(of:":"), let endRange = text.range(of:"}") {
            substring = text[startRange.upperBound..<endRange.lowerBound]
        }
        return Int(substring)!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "VoterRoom") {
            self.enterRoom.isHidden = true
                       self.errText.text = ""

            
            let nextViewController = (segue.destination as! VoterNameController)
            nextViewController.sessionNumber = self.sessionNumber
             
        }
    }
    
    
    
    
}
