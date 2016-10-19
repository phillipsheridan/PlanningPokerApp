//
//  VoterSessionCodeViewController.swift
//  GulfstreamProject
//
//  Created by Phil on 8/24/16.
//  Copyright © 2016 Armstrong. All rights reserved.
//

import UIKit

class VoterSessionCodeViewController: UIViewController {
    
    var inputValue = [String]()
    
    @IBOutlet weak var errText: UILabel!
    
    @IBOutlet var txtSessionCode: UITextField!
    @IBAction func submit(_ sender: UIButton) {
        errText.text = "";
        let request = NSMutableURLRequest(url: NSURL(string: "http://130.254.88.95:8080/checkForHostSession.php")! as URL)
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
            
            let noMatch = 0
            let res = responseString as String
            print("responseString = \(responseString)")
            print("nomatch = " + String(noMatch))
            if 0 == Int(res) {
                //self.errText.text = "Invalid Session code, ask your Host again!"
                DispatchQueue.main.async(execute: { () -> Void in
                    self.errText.text = "Invalid Session code, ask your Host again!"
                })
                
            } else {
                DispatchQueue.main.async(execute: { () -> Void in
                    self.errText.text = "Valid Session code, nice!"
                })
                //self.errText.text = "Valid Session code, nice!"
               // let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "VoterRoom") as UIViewController
               // present(viewController, animated: true, completion: nil)
            }
        }
        task.resume()

        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
}
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
}
