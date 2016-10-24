//
//  VoterRoomController.swift
//  GulfstreamProject
//
//  Created by Phil on 10/12/16.
//  Copyright © 2016 Armstrong. All rights reserved.
//

import UIKit

class VoterRoomController: UIViewController {

    var forComplexity : Bool!
    
    
    func prepare(for segue: UIStoryboardSegue!, sender: AnyObject!) {
        if (segue.identifier == "Complexity") {
            let nextViewController = (segue.destination as! GetNameHost)
            nextViewController.forComplexity = true
        }
        else if (segue.identifier == "BusinessValue") {
            let nextViewController = (segue.destination as! GetNameHost)
            nextViewController.forComplexity = false
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

   
    

    
}
