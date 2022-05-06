import UIKit

protocol CsvParser {
    associatedtype T
    
    var fileName: String { get set }
    var lineSeparator: String { get set }
    var componentSeparator: String { get set }
    
    func parseCsvData(from data: [[String]]) throws -> [T]
}

extension CsvParser {
    var fileUrl: URL? {
        Bundle.main.url(forResource: fileName, withExtension: "csv")
    }
    
    func importCSV() throws -> [T] {
        let rawData = try loadFile(from: fileUrl)
        let decodedData = try decode(rawData)
        let data = try parseCsvData(from: decodedData)
        return data
    }
    
    private func loadFile(from fileUrl: URL?) throws -> String {
        guard let url = fileUrl else { throw CsvParseError.missingFile }
        guard let data = try? String(contentsOf: url) else { throw CsvParseError.corruptFile }
        return data
    }
    
    private func decode(_ rawData: String) throws -> [[String]] {
        var lines = rawData.components(separatedBy: lineSeparator)
        guard lines.count > 2 else { throw CsvParseError.wrongFormat }
        lines.removeFirst()
        lines.removeAll { $0.isEmpty }
        guard lines.first!.contains(componentSeparator) else { throw CsvParseError.wrongFormat }
        return lines.map { $0.components(separatedBy: componentSeparator) }
    }
}

