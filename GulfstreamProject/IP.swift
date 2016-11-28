//
//  IP.swift
//  GulfstreamProject
//
//  Created by Phil on 10/31/16.
//  Copyright © 2016 Armstrong. All rights reserved.
//

import UIKit

class IP: NSObject {
    
    static let address = "localhost"  // This is for simulator testing
    //static let address = "10.0.0.12"   // Testing on real device at home
    //static let address = "130.254.88.174"   // Testing on real device at home


    static func getAddress() -> String {
        return self.address
    }
}
