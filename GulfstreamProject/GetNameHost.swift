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
    
    var hostid: String!
    
    @IBOutlet weak var tfName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    @IBAction func getName(_ sender: UIButton) {
        self.name = tfName.text
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //we just need to send name to next view controller
        if segue.identifier == "HostName" {
            let nextViewController = segue.destination as! HostController
            nextViewController.name = self.name
            nextViewController.forComplexity = self.forComplexity
            
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
