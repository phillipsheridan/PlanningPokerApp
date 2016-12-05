//
//  BusinessValueViewController.swift
//  GulfstreamProject
//
//  Created by Phil on 11/27/16.
//  Copyright © 2016 Armstrong. All rights reserved.
//

import UIKit

protocol BusinessDataEnteredDelegate: class {
    func userDidEnterInformation(info: String)
}


class BusinessValueViewController: UIViewController {
    
    var value: Float!
    
    var delegate : BusinessDataEnteredDelegate? = nil

    @IBOutlet weak var busValue: UILabel!

    @IBAction func zeroPressed(_ sender: UIButton) {
        setValue(a: "0")
        
    }
    @IBAction func onePressed(_ sender: UIButton) {
        setValue(a: "1")
    }
    @IBAction func twoPressed(_ sender: UIButton) {
        setValue(a: "2")
    }
    @IBAction func threePressed(_ sender: UIButton) {
        setValue(a: "3")
    }
    @IBAction func fivePressed(_ sender: UIButton) {
        setValue(a: "5")
    }
    @IBAction func eightPressed(_ sender: UIButton) {
        setValue(a: "8")
    }
    @IBAction func thirteenPressed(_ sender: UIButton) {
        setValue(a: "13")
    }
    @IBAction func twentyonePressed(_ sender: UIButton) {
        setValue(a: "21")
    }
    @IBAction func thirtyfourPressed(_ sender: UIButton) {
        setValue(a: "34")
    }
    @IBAction func fiftyfivePressed(_ sender: UIButton) {
        setValue(a: "55")
    }
    @IBAction func eightyninePressed(_ sender: UIButton) {
        setValue(a: "89")
    }
    @IBAction func onefourtyfourPressed(_ sender: UIButton) {
        setValue(a: "144")
    }
    @IBAction func breakPressed(_ sender: UIButton) {
        setValue(a: "Need a break")
        
    }
    @IBAction func idkPressed(_ sender: UIButton) {
        setValue(a: "I don't know")
    }
    //dont need submit, just make new back button
    
    func setValue(a: String) {
        DispatchQueue.main.async {
            self.busValue.text = a
        }
        
        
    }
    
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Vote!", style: .plain, target: self, action: #selector(goBack))

       
      
       
    }
    
    func goBack() {
        if (delegate != nil) {
            if let inp = self.busValue.text {
                if inp != "" {
            delegate!.userDidEnterInformation(info: inp)
                }
            }
        }
        
        //goes back one view
        _ = navigationController?.popViewController(animated: true)

    }
    
    
    
}
