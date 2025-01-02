//
//  ChapterType+Extension.swift
//

import Foundation
import UIKit

extension ChapterType {
    var id: Int { self.rawValue }
    
    var title: String { "book_title".localized }
    
    var chapterNumber: String { "chapter_number".localized(with: self.id) }
    
    var audioFileName: String { "chapter_\(self.id)" }
    
    var description: String { "chapter_\(self.id)".localized }
    
    var uiImage: UIImage { UIImage(named: "Cover_\(self.rawValue)") ?? .init() }
    
    var isAtStartOfList: Bool { self == Self.allCases.first }
    
    var isAtEndOfList: Bool { self == Self.allCases.last }
}
