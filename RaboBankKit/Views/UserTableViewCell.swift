//
//  UserTableViewCell.swift
//  RaboBankKit
//
//  Created by m_944879 on 28/4/22.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    static let id = "UserTableViewCell"
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userBirth: UILabel!
    @IBOutlet weak var userIssues: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        userImage.tintColor = UIColor.black
    }
}
