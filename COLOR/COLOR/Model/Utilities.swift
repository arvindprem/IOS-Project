//
//  Utilities.swift
//  COLOR
//
//  Created by Arvind Prem on 01/02/19.
//  Copyright © 2019 Arvind. All rights reserved.
//

import UIKit

class Utilities: NSObject {
    static let shared = Utilities()
    
    func getStoryBoard() -> UIStoryboard? {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        return storyBoard
    }
}

