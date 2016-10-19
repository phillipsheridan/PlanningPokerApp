//
//  HostController.swift
//  GulfstreamProject
//
//  Created by Phil on 10/10/16.
//  Copyright © 2016 Armstrong. All rights reserved.
//

import UIKit

class HostController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBAction func refresh(sender: AnyObject) {
        get()
    }
    var values:NSArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func get() {
        let url = NSURL(string: "http://localhost/get.php")
        let data = NSData(contentsOf: url! as URL)
        values = try! JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return values.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath) as! SpecialCell
        let maindata = values[indexPath.row]
        //cell.hostid.text = maindata["hostid"] as? String
       // cell.votersid.text = maindata["votersid"] as? String
       // cell.forcomplexity.text = maindata["forcomplexity"] as? String
        return cell
    }
    

    
}
