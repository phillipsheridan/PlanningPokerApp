//
//  ValidVoterSessionRoom.swift
//  GulfstreamProject
//
//  Created by Phil on 10/22/16.
//  Copyright © 2016 Armstrong. All rights reserved.
//

import UIKit



class ValidVoterSessionRoom: UITableViewController {

    
    
    
    var name : String!
    var names = [String]()
    var values = [Double]()
    // host id
    var sessionNumber:Int!
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

        
        //self.tableView.delegate = self
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Exit", style: .plain, target: self, action: #selector(exitTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Vote", style: .plain, target: self, action: #selector(voteTapped))
       
        
        //need to know which viewController to show (forComplexity or not?) and add voter if not added yet
        let request = NSMutableURLRequest(url: NSURL(string: "http://" + IP.getAddress() + ":8080/getForComplexity.php")! as URL)
        request.httpMethod = "POST"
        let postString = "a=\(sessionNumber!)b=\(device)"
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
            self.forComplexity = self.parseJSONBool(text: res)
            DispatchQueue.main.async(execute: { () -> Void in
                self.setTitle()
                
            })
            
        }
        task.resume()
        
        

        // update table view
        
        get()
        
    
    

        // Do any additional setup after loading the view.
    }
    // get a json array of everyone with same hostid (show voter's cell first)
    func get() {
        self.names = []
        self.values = []
        
        let url = "http://" + IP.getAddress() + ":8080/getRowsForVoter.php"
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
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
            
            // responseString = {"items":[{"name":"Phil","value":null},{"name":"HostPhil","value":null}]}

            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)!
            print("responseString = \(responseString)")
            
            let json = try! JSONSerialization.jsonObject(with:data! as Data, options: .allowFragments) as! [String: Any]
            let items = json["items"] as! [[String: Any]]
            for item in items {
                self.names.append(item["name"] as! String)
                if let v = item["value"] as? Double{
                    self.values.append(v)
                } else {
                    self.values.append(-1.0)
                }
                for t in self.values {
                print("value: " + String(t))
                }
                for k in self.names {
                    print("name: " + String(k))
                }
                //self.values.append(item["value"] as! Double)
                //names are in names array, values are now in values array
            }
            
            DispatchQueue.main.async() {
                self.tableView.reloadData()
                
                
            }

            
            
                    }
        task.resume()
        
        
        
            }

            
    
    
        
    
        
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return values.count
    }
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath) as! SpecialCell
        
        cell.name.text = names[indexPath.row] as String
        if values[indexPath.row] == -1 {
            cell.value.text = "?"
        } else {
            cell.value.text = String(values[indexPath.row])
        }
        return cell
    }

    
    func exitTapped () {
        //_ = self.navigationController?.popViewController(animated: true)
        
        self.performSegue(withIdentifier: "home", sender: self)
        
        
    }
    func voteTapped () {
        //get()
    }
    
    func parseJSONBool(text: String) -> Bool {
        var substring = ""
        if let startRange = text.range(of:":"), let endRange = text.range(of:"}") {
            substring = text[startRange.upperBound..<endRange.lowerBound]
        }
        return Bool(substring)!
    }
    func setTitle() {
        self.title = self.name
    
    
    }

    
}
