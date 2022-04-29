import Foundation

extension Double {
    func displayRound(to decimalDigits: Int = 2) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = decimalDigits
        return formatter.string(from: self as NSNumber)!
    }
}
