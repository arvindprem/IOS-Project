//
//  ContactListCell.swift
//  COLOR
//
//  Created by Arvind Prem on 01/02/19.
//  Copyright © 2019 Arvind. All rights reserved.
//

import UIKit

class ContactListCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView?
    @IBOutlet weak var nameLabel: UILabel?
    @IBOutlet weak var emailLabel: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(basicInfo: BasicInfo){
        if let fName = basicInfo.name?.first, let lName = basicInfo.name?.last {
            nameLabel?.text = "\(fName) \(lName)"
        }
        
        if let email = basicInfo.email {
            emailLabel?.text = email
        }
        
        if let imageUrl = URL(string: basicInfo.picture?.medium ?? "" ) {
            profileImageView?.image = nil
            profileImageView?.downloaded(from: imageUrl)
        }
        contentView.backgroundColor = ColorConstants.bgColors[Int.random(in: 0..<4)]
    }

}
