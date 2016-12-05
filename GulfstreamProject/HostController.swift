//
//  HostController.swift
//  GulfstreamProject
//
//  Created by Phil on 10/10/16.
//  Copyright © 2016 Armstrong. All rights reserved.
//

import UIKit

class HostController: UITableViewController {
    var timer: Timer! //use this to update table
    var names = [String]()
    var values = [Double]()
    var forComplexity:Bool!
    var hostid: String!
    var device: String!
            
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "End", style: .plain, target: self, action: #selector(exitTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Average", style: .plain, target: self, action: #selector(averageTapped))
        let avgButton = UIBarButtonItem(title: "Average", style: .plain, target: self, action: #selector(averageTapped))
        let changeButton = UIBarButtonItem(title: "Topic", style: .plain, target: self, action: #selector(changeTopic))
        
        navigationItem.rightBarButtonItems = [changeButton, avgButton]
        
        get()
        
        //thread to update table view goes here
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(checkTimer), userInfo: nil, repeats: true)

    }
    
    func get() {
        
        
        let complex = self.forComplexity
        self.names = []
        self.values = []
       
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://" + IP.getAddress() + ":8080/insertHost.php")! as URL)
        
        request.httpMethod = "POST"
        let postString = "b=\(complex!)" //change query
        request.httpBody = postString.data(using: String.Encoding.utf8)
        let task1 = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
            print("response = \(response)")
            
            
            
            
            
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)!
            
            // AlertView to give the host the number
            DispatchQueue.main.async() {
                if (self.forComplexity!) {
                self.title = responseString as String! + "(Complexity)"
                } else {
                    self.title = responseString as String! + "(Business Value)"
                    
                }
            }
            
            
            let alert = UIAlertController(title: "Alert", message: "Your session code is: \(responseString)", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            self.hostid = responseString as String!
            
        
        print("responseString = \(responseString)")
            
            
           
            
        }
        task1.resume()
    }


        
    func changeTopic() {
        self.forComplexity! = !(self.forComplexity!)
        let request = NSMutableURLRequest(url: NSURL(string: "http://" + IP.getAddress() + ":8080/setForComplexity.php")! as URL)
        request.httpMethod = "POST"
        let postString = "a=\(hostid!)&b=\(forComplexity!)"
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
    

    
    func checkTimer() {
        
        if let sess = self.hostid {
            self.names = []
            self.values = []
            
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
                    
                    
                        if (self.forComplexity!) {
                            self.title = self.hostid as String! + "(Complexity)"
                        } else {
                            self.title = self.hostid as String! + "(Business Value)"
                            
                        }
                    

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
        let cell = tableView.dequeueReusableCell(withIdentifier:"hostCell", for: indexPath) as! HostCellTableViewCell
        cell.name.text = names[indexPath.row] as String
        if values[indexPath.row] == -1 {
            cell.value.text = "\u{274C}"
        }
        else if values[indexPath.row] == -2 {
            cell.value.text = "\u{2753}"
        }
        else if values[indexPath.row] == -3 {
            cell.value.text = "\u{2615}"
        }
        else if values[indexPath.row] == -4 {
            cell.value.text = "\u{1F914}"
        }
        else {
            cell.value.text = String(values[indexPath.row])
        }
        return cell
    }
    
    
    
    
    func averageTapped () {
        //get Average and null all votes
        let request = NSMutableURLRequest(url: NSURL(string: "http://" + IP.getAddress() + ":8080/getAverage.php")! as URL)
        request.httpMethod = "POST"
        let postString = "a=\(self.hostid!)"
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
            
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Alert", message: "The average is \(res)", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            
        }
        task.resume()

        
        
    }
    func exitTapped() {
        let alert = UIAlertController(title: "Alert", message: "Are you sure you want to end the session?", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: { (alert: UIAlertAction!) in
            //delete host, cascades voters
            let request = NSMutableURLRequest(url: NSURL(string: "http://" + IP.getAddress() + ":8080/removeHost.php")! as URL)
            request.httpMethod = "POST"
            let postString = "a=\(self.hostid!)"
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
            self.performSegue(withIdentifier: "HomeFromHost", sender: self)
            
            
        }))
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    

    
}
