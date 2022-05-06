import Foundation

enum CsvParseError: String, Error {
    case missingFile
    case corruptFile
    case wrongFormat
    case corruptDataEntry
    case corruptCountEntry
    case corruptDateEntry
}
