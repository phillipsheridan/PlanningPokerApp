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
    var name: String!
    var sessionNumber : Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameTf.delegate = self

            }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "NameEntered") {
            
            
            
            let nextViewController = (segue.destination as! ValidVoterSessionRoom)
            nextViewController.sessionNumber = self.sessionNumber
            nextViewController.name = self.nameTf.text
        }

    }

    

   
}
