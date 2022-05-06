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
