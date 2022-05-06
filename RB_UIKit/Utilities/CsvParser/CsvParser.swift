import UIKit

protocol CsvParser {
    associatedtype T
    
    var fileName: String { get }
    var lineSeparator: String { get }
    var componentSeparator: String { get }
    
    static var rowItems: Int { get }
    static var hasHeading: Bool { get }
    
    static func parseCsvData(from data: [[String]]) throws -> [T]
}

extension CsvParser {
    var fileUrl: URL? {
        Bundle.main.url(forResource: fileName, withExtension: "csv")
    }
    
    func importCSV() throws -> [T] {
        let rawData = try loadFile(from: fileUrl)
        let decodedData = try decode(rawData)
        let data = try Self.parseCsvData(from: decodedData)
        return data
    }
    
    private func loadFile(from fileUrl: URL?) throws -> String {
        guard let url = fileUrl else { throw CsvParseError.missingFile }
        guard let data = try? String(contentsOf: url) else { throw CsvParseError.corruptFile }
        return data
    }
    
    private func decode(_ rawData: String) throws -> [[String]] {
        guard rawData.contains(lineSeparator) else { throw CsvParseError.wrongFormat }
        var lines = rawData.components(separatedBy: lineSeparator)
        lines.removeAll { $0.isEmpty }
        if Self.hasHeading {
            guard !lines.isEmpty else { throw CsvParseError.wrongFormat }
        }
        lines.removeFirst()
        guard lines.first!.contains(componentSeparator) else { throw CsvParseError.wrongFormat }
        return lines.map { $0.components(separatedBy: componentSeparator) }
    }
}

