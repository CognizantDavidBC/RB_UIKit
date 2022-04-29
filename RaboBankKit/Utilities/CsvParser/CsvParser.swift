import UIKit

protocol CsvParser {
    associatedtype T
    
    static var fileName: String { get }
    
    static func parseCsvData(from data: [[String]]) throws -> [T]
}

extension CsvParser {
    static var lineSeparator:String { "\n" }
    static var componentSeparator: String { ";" }
    static var fileUrl: URL? {
        Bundle.main.url(forResource: fileName, withExtension: "csv")
    }
    
    static func importCSV() throws -> [T] {
        let rawData = try loadFile(from: fileUrl)
        let decodedData = decode(rawData)
        let data = try parseCsvData(from: decodedData)
        return data
    }
    
    static private func loadFile(from fileUrl: URL?) throws -> String {
        guard let url = fileUrl else { throw CsvParseError.missingFile }
        guard let data = try? String(contentsOf: url) else { throw CsvParseError.corruptFile }
        return data
    }
    
    static private func decode(_ rawData: String) -> [[String]] {
        var lines = rawData.components(separatedBy: lineSeparator)
        lines.removeFirst()
        lines.removeAll { $0.isEmpty }
        return lines.map { $0.components(separatedBy: componentSeparator) }
    }
}

