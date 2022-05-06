import XCTest
@testable import RB_UIKit

class CsvParser: XCTestCase {
    func test_fileNotFound() {
        var parser = UserCsvParser()
        parser.fileName = "noFile"
        XCTAssertThrowsError(try parser.importCSV()) { error in
            XCTAssertEqual(error as! CsvParseError, CsvParseError.missingFile)
        }
    }
    
    func test_correctFormat() {
        var parser = UserCsvParser()
        parser.fileName = "wrongSeparator"
        XCTAssertThrowsError(try parser.importCSV()) { error in
            XCTAssertEqual(error as! CsvParseError, CsvParseError.wrongFormat)
        }
    }
}
