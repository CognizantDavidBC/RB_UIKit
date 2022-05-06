import XCTest
@testable import RB_UIKit

class ModelUser: XCTestCase {
    let testDate: Date = {
        var dateComponents = DateComponents()
        dateComponents.day = 4
        dateComponents.month = 5
        dateComponents.year = 2022
        return Calendar(identifier: .gregorian).date(from: dateComponents)!
    }()
    
    func test_user_init() {
        let name = "Name"
        let surName = "Sur"
        let issues = 666
        let date = testDate
        
        let user = User(name: name, surName: surName, issueCount: issues, dateBirth: date)
        
        XCTAssert(user.name == name)
        XCTAssert(user.surName == surName)
        XCTAssert(user.issueCount == issues)
    }
    
    func test_user_dateFormat() {
        let date = "04/05/2022"
        
        let user = User(name: "Name", surName: "Sur", issueCount: 0, dateBirth: testDate)
        XCTAssert(user.birthDateFormatted == date)
    }

}
