//
//  DetailedViewController.swift
//  COLOR
//
//  Created by Arvind Prem on 01/02/19.
//  Copyright © 2019 Arvind. All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController {
    
    @IBOutlet weak var bluredImageView: UIImageView?
    @IBOutlet weak var profileImageView: UIImageView?
    @IBOutlet weak var nameLabel: UILabel?
    @IBOutlet weak var emailLabel: UILabel?
    @IBOutlet weak var cellLabel: UILabel?
    @IBOutlet weak var streetLabel: UILabel?
    @IBOutlet weak var cityLabel: UILabel?
    @IBOutlet weak var bgView: UIView?
    
    var contactInfo: BasicInfo?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setuView()
    }
    
    func setuView(){
        self.title = "Profile"
        if let url = URL(string: contactInfo?.picture?.large ?? "") {
            bluredImageView?.downloaded(from: url)
            profileImageView?.downloaded(from: url)
            profileImageView?.layer.cornerRadius = 80
            profileImageView?.clipsToBounds = true
            self.bgView?.backgroundColor = UIColor(red: 102.0/255.0, green: 153.0/255.0, blue: 1, alpha: 0.1)
            
        }
        
        if let title = contactInfo?.name?.title, let fName = contactInfo?.name?.first, let lName = contactInfo?.name?.last {
            nameLabel?.text = "\(title). \(fName) \(lName)"
        }
        emailLabel?.text = contactInfo?.email
        cellLabel?.text = contactInfo?.cell
        streetLabel?.text = contactInfo?.location?.street
        cityLabel?.text = contactInfo?.location?.city
        
    }
}
