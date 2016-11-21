//
//  HostCellTableViewCell.swift
//  GulfstreamProject
//
//  Created by Phil on 11/20/16.
//  Copyright © 2016 Armstrong. All rights reserved.
//

import UIKit

class HostCellTableViewCell: UITableViewCell {

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
