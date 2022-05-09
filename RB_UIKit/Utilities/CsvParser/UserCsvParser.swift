import Foundation

struct UserCsvParser: CsvParser {
    let fileName: String
    let lineSeparator: String
    let componentSeparator: String
    
    static let rowItems = 4
    static let hasHeading = true
    
    init(csvFileName file: String = "issues", lineSeparator: String = "\r", componentSeparator: String = ";") {
//    init(csvFileName file: String = "testData", lineSeparator: String = "\n", componentSeparator: String = ";") {
        fileName = file
        self.lineSeparator = lineSeparator
        self.componentSeparator = componentSeparator
    }
    
    static func parseCsvData(from data: [[String]]) throws -> [User] {
        var users: [User] = []
        for line in data {
            guard line.count == UserCsvParser.rowItems else { throw CsvParseError.corruptDataEntry }
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
        guard let dateBirth = UserCsvParser.parseDate(components[3]) else { throw CsvParseError.corruptDateEntry }
        return User(name: name, surName: surName, issueCount: issueCount, dateBirth: dateBirth)
    }
    
    static func parseDate(_ rawDate: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T00:00:00'"
        return dateFormatter.date(from:rawDate)
    }
}

