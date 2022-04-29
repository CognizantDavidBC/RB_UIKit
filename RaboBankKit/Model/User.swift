import Foundation

struct User {
    let name: String
    let surName: String
    let issueCount: Int
    private let dateBirth: Date
    
    var birthDateFormatted: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: dateBirth)
    }
    
    init(name: String, surName: String, issueCount: Int, dateBirth: Date) {
        self.name = name
        self.surName = surName
        self.issueCount = issueCount
        self.dateBirth = dateBirth
    }
}
