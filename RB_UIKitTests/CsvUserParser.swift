import XCTest
@testable import RB_UIKit

class CsvUserParser: XCTestCase {
    let userName = "Name"
    let userLast = "Last"
    let userIssues = 666
    let userDate = "2022-05-04T00:00:00"
    
    func test_parseCsvData() {
        let user = [userName, userLast, String(userIssues), userDate]
        let data = try? UserCsvParser.parseCsvData(from: [user])
        XCTAssertNotNil(data)
        XCTAssert(data!.count == 1)
        XCTAssert(data!.first!.name == userName)
        XCTAssert(data!.first!.surName == userLast)
        XCTAssert(data!.first!.issueCount == userIssues)
    }
    
    func test_parseCsvData_noData() {
        let data = try? UserCsvParser.parseCsvData(from: [])
        XCTAssertNotNil(data)
        XCTAssert(data!.isEmpty)
    }
    
    func test_parseCsvData_missingValue() {
        let user = [userName, userLast]
        XCTAssertThrowsError(try UserCsvParser.parseCsvData(from: [user])) { error in
            XCTAssert(error as! CsvParseError == CsvParseError.corruptDataEntry)
        }
    }
    
    func test_parseCsvData_wrongIssueCount() {
        let userIssues = "6x6"
        let user = [userName, userLast, userIssues, userDate]
        XCTAssertThrowsError(try UserCsvParser.parseCsvData(from: [user])) { error in
            XCTAssert(error as! CsvParseError == CsvParseError.corruptCountEntry)
        }
    }
    
    func test_parseCsvData_wrongDate() {
        let userDate = "2022-05-04/00:00:00"
        let user = [userName, userLast, String(userIssues), userDate]
        XCTAssertThrowsError(try UserCsvParser.parseCsvData(from: [user])) { error in
            XCTAssert(error as! CsvParseError == CsvParseError.corruptDateEntry)
        }
    }
    
    func test_dateParser() {
        let parsedDate = UserCsvParser.parseDate(userDate)
        XCTAssertNotNil(parsedDate)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        XCTAssert(dateFormatter.string(from: parsedDate!) == "04")
        dateFormatter.dateFormat = "MM"
        XCTAssert(dateFormatter.string(from: parsedDate!) == "05")
        dateFormatter.dateFormat = "yyyy"
        XCTAssert(dateFormatter.string(from: parsedDate!) == "2022")
    }
}
