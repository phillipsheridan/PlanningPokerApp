//
//  VoterRoomController.swift
//  GulfstreamProject
//
//  Created by Phil on 10/12/16.
//  Copyright © 2016 Armstrong. All rights reserved.
//

import UIKit

class VoterRoomController: UIViewController {

    //var forComplexity : Bool!
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        
        
        
        if (segue.identifier == "complexity") {
            let nextViewController = (segue.destination as! HostController)
            nextViewController.forComplexity = true
        }
        else if (segue.identifier == "businessValue") {
            let nextViewController = (segue.destination as! HostController)
            nextViewController.forComplexity = false
        }
            
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

   
    

    
}
