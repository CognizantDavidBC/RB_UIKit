import UIKit

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.userCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.id, for: indexPath) as! UserTableViewCell
        
        let user = viewModel.user(atIndex: indexPath.row)
        cell.userImage.image = UIImage(systemName: "person.crop.circle.fill")
        cell.userName.text = "\(user.name) \(user.surName)"
        cell.userBirth.text = user.birthDateFormatted
        cell.userIssues.text = "\(user.issueCount)"
        
        return cell
    }
}
