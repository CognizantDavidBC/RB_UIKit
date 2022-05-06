import XCTest
@testable import RB_UIKit

class CsvParser: XCTestCase {
    func test_fileNotFound() {
        let parser = UserCsvParser(csvFileName: "noFile")
        XCTAssertThrowsError(try parser.importCSV()) { error in
            XCTAssertEqual(error as! CsvParseError, CsvParseError.missingFile)
        }
    }
    
    func test_emptyLines() {
        let parser = UserCsvParser(csvFileName: "testFile")
        let output = try? parser.importCSV()
        XCTAssertNotNil(output)
        XCTAssert(output!.count == 2)
    }
    
    func test_correctFormat_lineSeparator() {
        let parser = UserCsvParser(csvFileName: "testFile", lineSeparator: "\t")
        XCTAssertThrowsError(try parser.importCSV()) { error in
            XCTAssert(error as! CsvParseError == CsvParseError.wrongFormat)
        }
    }
    
    func test_correctFormat_componentSeparator() {
        let parser = UserCsvParser(csvFileName: "testFile", componentSeparator: "/")
        XCTAssertThrowsError(try parser.importCSV()) { error in
            XCTAssert(error as! CsvParseError == CsvParseError.wrongFormat)
        }
    }
    
    func test_correctFormat_noHeading() {
        let parser = UserCsvParser(csvFileName: "noData")
        XCTAssertThrowsError(try parser.importCSV()) { error in
            XCTAssert(error as! CsvParseError == CsvParseError.wrongFormat)
        }
    }
}
