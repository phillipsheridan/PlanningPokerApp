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
            
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.setHidesBackButton(true, animated: true)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Exit", style: .plain, target: self, action: #selector(exitTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Start Vote", style: .plain, target: self, action: #selector(startTapped))

    }
    
    func get() {
        /*
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

        */
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return values.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath) as! SpecialCell
        //let maindata = values[indexPath.row]
        return cell
    }
    
    func startTapped () {
        
    }
    
    func exitTapped() {
        self.performSegue(withIdentifier: "HomeFromHost", sender: self)
    }
    

    
}
