//
//  BookDescriptionComponent.swift
//

import Foundation
import SwiftUI

struct BookDescriptionComponent: View {
    @Binding var chapter: ChapterType
    
    var body: some View {
        Text(chapter.description)
            .multilineTextAlignment(.center)
            .font(.subheadline)
            .padding(.horizontal, 16)
            .frame(height: 60)
    }
}

#Preview {
    BookDescriptionComponent(chapter: .init(projectedValue: .constant(.chapter1)))
}
