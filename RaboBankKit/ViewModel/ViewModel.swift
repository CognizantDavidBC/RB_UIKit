import UIKit

class ViewModel {
    private var users: [User]
    
    var userCount: Int { users.count }
    
    init() {
        users = []
    }
    
    func user(atIndex index: Int) -> User {
        users[index]
    }
    
    func loadData(onComplete completed: @escaping () -> Void) {
        DispatchQueue.global(qos: .background).async {
            self.users = UserCsvParser.importCSV()
            DispatchQueue.main.async {
                completed()
            }
        }
    }
}
