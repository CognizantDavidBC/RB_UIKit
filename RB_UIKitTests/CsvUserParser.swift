import XCTest
@testable import RB_UIKit

class CsvUserParser: XCTestCase {
    func test_dateParser() {
        let date = "2000-01-01T00:00:00"
        let parsedDate = UserCsvParser.parseDate(date)
        XCTAssertNotNil(parsedDate)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        XCTAssert(dateFormatter.string(from: parsedDate!) == "2000")
        dateFormatter.dateFormat = "MM"
        XCTAssert(dateFormatter.string(from: parsedDate!) == "01")
        dateFormatter.dateFormat = "dd"
        XCTAssert(dateFormatter.string(from: parsedDate!) == "01")
    }
    
    func test_userParser() {
        let date = "2000-01-01T00:00:00"
        let data: [[String]] = [["Name", "Last", "0", date]]
        let user = User(name: "Name", surName: "Last", issueCount: 0, dateBirth: UserCsvParser.parseDate(date)!)
        var users: [User]?
        do {
            users = try UserCsvParser().parseCsvData(from: data)
        } catch {
            XCTFail("\(error)")
        }
        XCTAssert(users?.count == 1)
        XCTAssert(users?.first == user)
    }
}
