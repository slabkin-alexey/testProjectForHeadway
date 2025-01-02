//
//  ChapterKeyPointComponent.swift
//

import Foundation
import SwiftUI

struct ChapterKeyPointComponent: View {
    @State private var chaptersCount: Int = 0
    @Binding var chapter: ChapterType
    
    var body: some View {
        Text("KEY POINT \(chapter.id) OF \(chaptersCount)")
            .font(.subheadline)
            .foregroundStyle(.gray)
            .padding(.bottom, 4)
            .bold()
            .onAppear() { chaptersCount = ChapterType.allCases.count }
    }
}

#Preview {
    ChapterKeyPointComponent(chapter: .init(projectedValue: .constant(.chapter1)))
}
