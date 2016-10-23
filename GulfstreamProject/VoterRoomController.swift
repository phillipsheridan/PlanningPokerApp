//
//  VoterRoomController.swift
//  GulfstreamProject
//
//  Created by Phil on 10/12/16.
//  Copyright © 2016 Armstrong. All rights reserved.
//

import UIKit

class VoterRoomController: UIViewController {

    
    
    func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if (segue.identifier == "Complexity") {
            // pass data to next view
        }
        else if (segue.identifier == "BusinessValue") {
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
