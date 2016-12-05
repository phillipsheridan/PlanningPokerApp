//
//  ComplexityViewController.swift
//  GulfstreamProject
//
//  Created by Phil on 11/27/16.
//  Copyright © 2016 Armstrong. All rights reserved.
//

import UIKit


protocol ComplexityDataEnteredDelegate: class {
    func userDidEnterInformation(info: String)
}

class ComplexityViewController: UIViewController {
    
    var delegate : ComplexityDataEnteredDelegate? = nil
    
    @IBOutlet weak var comValue: UILabel!
    var value : Float!
    
    @IBAction func oneHalfPressed(_ sender: UIButton) {
        comValue.text = "1/2"
    }

    @IBAction func onePressed(_ sender: UIButton) {
        comValue.text = "1"
    }
    @IBAction func twoPressed(_ sender: UIButton) {
        comValue.text = "2"
    }
    @IBAction func threePressed(_ sender: UIButton) {
        comValue.text = "3"
    }
    @IBAction func fivePressed(_ sender: UIButton) {
        comValue.text = "5"
    }
    @IBAction func eightPressed(_ sender: UIButton) {
        comValue.text = "8"
    }
    @IBAction func thirteenPressed(_ sender: UIButton) {
        comValue.text = "13"
    }
    @IBAction func idkPressed(_ sender: UIButton) {
        comValue.text = "I don't know"
    }
    @IBAction func breakItDownPressed(_ sender: UIButton) {
        comValue.text = "Too complex"
    }
    @IBAction func breakPressed(_ sender: UIButton) {
        comValue.text = "Need a break"
    }
    //don't need submit, just make new back button
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Vote!", style: .plain, target: self, action: #selector(goBack))


          }
    
    func goBack() {
        if (delegate != nil) {
            if let information = comValue.text {
                if information != "" {
            delegate!.userDidEnterInformation(info: information)
                }
            }
        }
        //goes back one view
        _ = navigationController?.popViewController(animated: true)
        
    }


   
}
