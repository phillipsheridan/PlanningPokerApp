//
//  HostController.swift
//  GulfstreamProject
//
//  Created by Phil on 10/10/16.
//  Copyright © 2016 Armstrong. All rights reserved.
//

import UIKit

class HostController: UITableViewController {

    var names = [String]()
    var values = [Double]()
    var forComplexity:Bool!
    var hostid: String!
    var name: String!
            
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Exit", style: .plain, target: self, action: #selector(exitTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Start Vote", style: .plain, target: self, action: #selector(startTapped))
        
        get()
        
        //thread to update table view goes here

    }
    
    func get() {
        
        let hostname = self.name
        let complex = self.forComplexity
        self.names = []
        self.values = []
       
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://" + IP.getAddress() + ":8080/insertHost.php")! as URL)
        
        request.httpMethod = "POST"
        let postString = "a=\(hostname!)&b=\(complex!)"
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
            self.title = responseString as String!
            let alert = UIAlertController(title: "Alert", message: "Your session code is: \(responseString)", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            self.hostid = responseString as String!
            
        
        print("responseString = \(responseString)")
            
            
            //start task 2
            let host = self.hostid
            let url = "http://" + IP.getAddress() + ":8080/showHostInTable.php"
            let request2 = NSMutableURLRequest(url: NSURL(string: url)! as URL)
            request2.httpMethod = "POST"
            let postString2 = "a=\(host!)"
            request2.httpBody = postString2.data(using: String.Encoding.utf8)
            let task2 = URLSession.shared.dataTask(with: request2 as URLRequest) {
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
                    DispatchQueue.main.async() {
                        self.tableView.reloadData()
                        
                        
                    }
                }
                
                
                
                
                
            }
            task2.resume()
            
        }
        task1.resume()
    }


        
        
        

        


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return values.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"hostCell", for: indexPath) as! HostCellTableViewCell
        cell.name.text = names[indexPath.row] as String
        if values[indexPath.row] == -1 {
            cell.value.text = "Has not voted"
        } else {
            cell.value.text = String(values[indexPath.row])
        }
        return cell
    }
    
    func startTapped () {
        //segue to the buttons, the segue back will update their vote value
        
    }
    
    func exitTapped() {
        let alert = UIAlertController(title: "Alert", message: "Are you sure you want to end the session?", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: { (alert: UIAlertAction!) in
            
            self.performSegue(withIdentifier: "HomeFromHost", sender: self)
            // next delete the host, which will delete the voters
            
        }))
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        self.performSegue(withIdentifier: "HomeFromHost", sender: self)
    }
    
    

    
}
