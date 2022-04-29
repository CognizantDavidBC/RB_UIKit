import Foundation

struct UserCsvParser: CsvParser {
    static var fileName: String = "testData"
    
    internal static func parseCsvData(from data: [[String]]) throws -> [User] {
        var users: [User] = []
        for line in data {
            guard line.count == 4 else { throw CsvParseError.corruptDataEntry }
            do {
                users.append(try createUser(fromComponents: line))
            } catch {
                throw error
            }
        }
        return users
    }
    
    private static func createUser(fromComponents components: [String]) throws -> User {
        let name = components[0]
        let surName = components[1]
        guard let issueCount = Int(components[2]) else { throw CsvParseError.corruptCountEntry }
        guard let dateBirth = parseDate(components[3]) else { throw CsvParseError.corruptDateEntry }
        return User(name: name, surName: surName, issueCount: issueCount, dateBirth: dateBirth)
    }
    
    private static func parseDate(_ rawDate: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T00:00:00'"
        return dateFormatter.date(from:rawDate)
    }
}
