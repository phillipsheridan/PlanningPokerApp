//
//  SpecialCell.swift
//  GulfstreamProject
//
//  Created by Phil on 10/11/16.
//  Copyright © 2016 Armstrong. All rights reserved.
//

import UIKit

class SpecialCell: UITableViewCell {
    //name and vote value
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var value: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
