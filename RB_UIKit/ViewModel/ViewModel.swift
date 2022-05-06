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
    
    func loadData(onSuccess success: @escaping () -> Void, onFailure failure: @escaping(CsvParseError) -> Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                self.users = try UserCsvParser().importCSV()
                
                DispatchQueue.main.async {
                    success()
                }
            } catch {
                guard let csvError = error as? CsvParseError else { return }
                
                DispatchQueue.main.async {
                    failure(csvError)
                }
            }
        }
    }
}
