//
//  GetNameHost.swift
//  GulfstreamProject
//
//  Created by Phil on 10/24/16.
//  Copyright © 2016 Armstrong. All rights reserved.
//

import UIKit

class GetNameHost: CustomViewController {

    var forComplexity: Bool!
    
    var name: String!
    
    
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var tfName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "HostName" {
            name = tfName.text
            
            if let hostName = name, let complex = forComplexity {
                //let nextViewController = (segue.destination as! HostController)
                // ^ might need this idk, probably not
                let request = NSMutableURLRequest(url: NSURL(string: "http://" + IP.getAddress() + ":8080/insertHost.php")! as URL)
                
                request.httpMethod = "POST"
                //request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                let postString = "a=\(hostName)&b=\(complex)"
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

    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
