//
//  VoterSessionCodeViewController.swift
//  GulfstreamProject
//
//  Created by Phil on 8/24/16.
//  Copyright © 2016 Armstrong. All rights reserved.
//

import UIKit

class VoterSessionCodeViewController: UIViewController {
    var x = 2016
    @IBOutlet var txtSessionCode: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        txtSessionCode.text = String(x)
}
    
    
}