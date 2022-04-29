import Foundation

struct UserCsvParser: CsvParser {
    static var fileName: String = "testData"
    
    internal static func parseCsvData(from data: [[String]]) -> [User] {
        var users: [User] = []
        for line in data {
            guard line.count == 4 else { continue }
            users.append(createUser(fromComponents: line))
        }
        return users
    }
    
    private static func createUser(fromComponents components: [String]) -> User {
        let name = components[0]
        let surName = components[1]
        let issueCount = Int(components[2]) ?? 0
        let dateBirth = parseDate(components[3]) ?? Date.now
        return User(name: name, surName: surName, issueCount: issueCount, dateBirth: dateBirth)
    }
    
    private static func parseDate(_ rawDate: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T00:00:00'"
        return dateFormatter.date(from:rawDate)
    }
}

