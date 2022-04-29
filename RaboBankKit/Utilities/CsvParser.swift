import UIKit

protocol CsvParser {
    associatedtype T
    
    static var fileName: String { get }
    
    static func parseCsvData(from data: [[String]]) -> [T]
}

extension CsvParser {
    static var lineSeparator:String { "\n" }
    static var componentSeparator: String { ";" }
    static var fileUrl: URL {
        Bundle.main.url(forResource: fileName, withExtension: "csv")!
    }
    
    static func importCSV() -> [T] {
        let rawData = loadFile(from: fileUrl)
        let decodedData = decode(rawData)
        return parseCsvData(from: decodedData)
    }
    
    static private func loadFile(from fileUrl: URL) -> String {
        guard let data = try? String(contentsOf: fileUrl) else { return "" }
        return data
    }
    
    static private func decode(_ rawData: String) -> [[String]] {
        var lines = rawData.components(separatedBy: lineSeparator)
        lines.removeFirst()
        return lines.map { $0.components(separatedBy: componentSeparator) }
    }
}

