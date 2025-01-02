//
//  CoverComponent.swift
//

import SwiftUI
import Foundation

struct CoverComponent: View {
    @Binding var chapter: ChapterType
    
    var body: some View {
        ZStack {
            Image(uiImage: chapter.uiImage)
                .resizable()
                .scaledToFill()
                .frame(width: 225, height: 350)
                .cornerRadius(15)
                .clipped()
            
            VStack(alignment: .leading) {
                Text(chapter.title)
                    .font(.headline)
                    .foregroundColor(.white)
                    .bold()
                    .shadow(radius: 5)
                    .padding(.bottom, 6)
                
                Text(chapter.chapterNumber)
                    .font(.subheadline)
                    .bold()
                    .foregroundColor(.white.opacity(0.8))
                    .shadow(radius: 5)
                
                Spacer()
            }
            .padding(.horizontal, 10)
            .padding(.top, 20)
            .frame(maxWidth: .infinity, alignment: .topLeading)
        }
        .frame(width: 225, height: 350)
        .padding(.horizontal, 24)
        .padding(.bottom, 18)
    }
}

#Preview {
    CoverComponent(chapter: .init(projectedValue: .constant(.chapter1)))
}
