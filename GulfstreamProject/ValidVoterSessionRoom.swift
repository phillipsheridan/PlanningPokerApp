//
//  ValidVoterSessionRoom.swift
//  GulfstreamProject
//
//  Created by Phil on 10/22/16.
//  Copyright © 2016 Armstrong. All rights reserved.
//

import UIKit



class ValidVoterSessionRoom: UITableViewController, BusinessDataEnteredDelegate, ComplexityDataEnteredDelegate {

    
    var timer: Timer!
    
    var name : String!
    var names = [String]()
    var values = [Double]()
    var voterIDs = [String]()
    // host id
    var sessionNumber:String!
    //boolean to check if host session is for complexity or business value
    var forComplexity:Bool!
    //voter's current vote
    var voteValue:Float!
    //voter device string
    var device = UIDevice.current.identifierForVendor!.uuidString
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.names = []
        self.values = []
        self.voterIDs = []

        
        //self.tableView.delegate = self
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Exit", style: .plain, target: self, action: #selector(exitTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Vote", style: .plain, target: self, action: #selector(voteTapped))
       
        
        getComplexity()
        
        

        
        
        //thread timer to check every few sec if hostid still exists here
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(checkTimer), userInfo: nil, repeats: true)
        
    
        
    
    

       
    }
    
    func getComplexity() {
        //need to know which viewController to show (forComplexity or not?) and add voter if not added yet
        let request = NSMutableURLRequest(url: NSURL(string: "http://" + IP.getAddress() + ":8080/getForComplexity.php")! as URL)
        request.httpMethod = "POST"
        let postString = "a=\(sessionNumber!)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
            print("response = \(response)")
            
            
            
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)!
            
            
            let res = responseString as String
            print("responseString = \(responseString)")
            var boolvalue: Bool!
            
            if (res == "1") {
                boolvalue = true
            } else {
                boolvalue = false
            }
            self.forComplexity = boolvalue
            DispatchQueue.main.async(execute: { () -> Void in
                self.setTitle()
                
            })
            
            //self.get()
            
        }
        task.resume()

    }
    
    func checkTimer() {
        
        getComplexity()
        
        let request2 = NSMutableURLRequest(url: NSURL(string: "http://" + IP.getAddress() + ":8080/checkForHostSession.php")! as URL)
        request2.httpMethod = "POST"
        let idString = "a=\(self.sessionNumber!)"
        request2.httpBody = idString.data(using: String.Encoding.utf8)
        let task2 = URLSession.shared.dataTask(with: request2 as URLRequest) {
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
            print("response = \(response)")
            
            
            
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)!
            
            
            let res = responseString as String
            print("responseString = \(responseString)")
            
            if res == "0" {
                self.timer.invalidate()
                DispatchQueue.main.async(execute: { () -> Void in
                    let alert = UIAlertController(title: "Alert", message: "The host has ended the session!", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: { (alert: UIAlertAction!) in
                        self.timer.invalidate()
                        self.performSegue(withIdentifier: "home", sender: self)
                        
                        
                    }))
                    self.present(alert, animated: true, completion: nil)

                    
                })
            } else {
                //if yes, update table view and check if host is ready to show average,
                // if show average = 1
                // query the database for the average.
                // else
                //
                //if host is showing average, alertview to give average
                
                self.get()
                
            }
            
            
            
        }
        task2.resume()
    }
    
    

    // get a json array of everyone with same hostid (show voter's cell first)
    func get() {
        
        if let sess = self.sessionNumber {
        self.names = []
        self.values = []
        self.voterIDs = []
        
        let url = "http://" + IP.getAddress() + ":8080/getRowsForVoter.php"
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        let postString = "a=\(sess)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
            print("response = \(response)")
            
            // responseString = {"items":[{"name":"Phil","value":null},{"name":"HostPhil","value":null}]}

            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)!
            print("responseString = \(responseString)")
            
            let json = try! JSONSerialization.jsonObject(with:data! as Data, options: .allowFragments) as! [String: Any]
            let items = json["items"] as! [[String: Any]]
            for item in items {
                self.names.append(item["name"] as! String)
                self.voterIDs.append(item["voterid"] as! String)
                if let v = item["value"] as? String{
                    self.values.append(Double(v)!)
                } else {
                    self.values.append(-1.0)
                }
                for t in self.values {
                print("value: " + String(t))
                }
                for k in self.names {
                    print("name: " + String(k))
                }
               
            }
            
            //maybe we can check if host wants to show vote here and update a label in View
            
            DispatchQueue.main.async() {
                self.tableView.reloadData()
                
                
                
            }

            
            
                    }
        task.resume()
        
        
        }
        
            }
        

            
    
    
        
    
        
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return values.count
    }
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath) as! SpecialCell
        
        cell.name.text = names[indexPath.row] as String
        if values[indexPath.row] == -1 {
            cell.value.text = "\u{274C}"
        } else if values[indexPath.row] == -2 {
            cell.value.text = "\u{2753}"
        }
        else if values[indexPath.row] == -3 {
            cell.value.text = "\u{2615}"
        }
        else if values[indexPath.row] == -4 {
            cell.value.text = "\u{1F914}"
        }
        else {
            if voterIDs[indexPath.row] == self.device {
                cell.value.text = String(values[indexPath.row])
            } else {
                cell.value.text = "\u{2705}"
            }
            
        }
        return cell
    }

    
    func exitTapped () {
        
        let alert = UIAlertController(title: "Alert", message: "Are you sure you want exit?", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: { (alert: UIAlertAction!) in
            //delete voter
            let request = NSMutableURLRequest(url: NSURL(string: "http://" + IP.getAddress() + ":8080/removeVoter.php")! as URL)
            request.httpMethod = "POST"
            let postString = "a=\(self.device)&b=\(self.sessionNumber!)"
            request.httpBody = postString.data(using: String.Encoding.utf8)
            let task = URLSession.shared.dataTask(with: request as URLRequest) {
                data, response, error in
                
                if error != nil {
                    print("error=\(error)")
                    return
                }
                
                print("response = \(response)")
                
                
                
                let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)!
                
                
                let res = responseString as String
                print("responseString = \(responseString)")
                print("res = \(res)")
                
            }
            task.resume()

            self.timer.invalidate()
            self.performSegue(withIdentifier: "home", sender: self)
            
            
        }))
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        

        
        //self.performSegue(withIdentifier: "home", sender: self)
        
        
    }
    
    func userDidEnterInformation(info: String) {
        if info == "I don't know" { // -2
            voteValue = -2.0
        } else if info == "Need a break" { //-3
            voteValue = -3.0
        } else if info == "Too complex"{ // -4
            voteValue = -4.0
        }
        else if info == "1/2"{ //
            voteValue = 0.5
        } else {
        voteValue = Float(info)
        }
        //update value in DB --- Make sure to convert those strings into some floats
        let request = NSMutableURLRequest(url: NSURL(string: "http://" + IP.getAddress() + ":8080/updateValue.php")! as URL)
        request.httpMethod = "POST"
        let postString = "a=\(self.device)&b=\(self.sessionNumber!)&c=\(self.voteValue!)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
            print("response = \(response)")
            
            
            
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)!
            
            
            let res = responseString as String
            print("responseString = \(responseString)")
            print("res = \(res)")
            
        }
        task.resume()
    }
    
    func voteTapped () {
        //self.timer.invalidate()
        //segue to the buttons, the segue back will update their vote value'
        if self.forComplexity! {
            performSegue(withIdentifier: "voterComplexity", sender: self)
        } else {
            performSegue(withIdentifier: "voterBusinessValue", sender: self)
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //send current value, check if nil in next controller
        if segue.identifier == "voterComplexity" {
            let nextViewController = segue.destination as! ComplexityViewController
            nextViewController.value = self.voteValue
            nextViewController.delegate = self
            
        }
        else if segue.identifier == "voterBusinessValue"{
            let nextViewController = segue.destination as! BusinessValueViewController
            nextViewController.value = self.voteValue
            nextViewController.delegate = self
        }
    }

    
    
    func setTitle() {
        if let a = self.forComplexity {
        if (a) {
            self.title = "Complexity"
        }
        else {
            self.title = "Business Value"
        }
    
            }
    }

    
}
