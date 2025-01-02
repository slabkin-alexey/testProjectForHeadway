//
//  String+Extension.swift
//

import Foundation

extension String {
    static func timeString(from seconds: Double) -> String {
        let minutes = Int(seconds) / 60
        let seconds = Int(seconds) % 60
        
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    var localized: String {
        NSLocalizedString(self, tableName: nil, bundle: .main, comment: "")
    }
    
    func localized(with arguments: CVarArg...) -> String {
        let format = NSLocalizedString(self, tableName: nil, bundle: .main, comment: "")
        
        guard !format.isEmpty else { return self }

        return String(format: format, arguments: arguments)
    }
}
