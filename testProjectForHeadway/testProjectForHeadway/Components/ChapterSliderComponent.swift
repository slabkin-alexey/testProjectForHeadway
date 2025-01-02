//
//  ChapterSliderComponent.swift
//

import Foundation
import SwiftUI

struct ChapterSliderComponent: View {
    @Binding var chapter: ChapterType
    @Binding var audioData: AudioData
    
    @State private var isDragging: Bool = false
    @State private var sliderValue: TimeInterval = 0
    
    var onSeek: (TimeInterval) -> Void
    
    var body: some View {
        HStack {
            Text(String.timeString(from: isDragging ? sliderValue : $audioData.currentTime.wrappedValue))
                .font(.caption)
                .frame(width: 35)
                .foregroundColor(.gray)
            
            Slider(
                value: Binding(
                    get: { isDragging ? sliderValue : audioData.currentTime },
                    set: { newValue in
                        sliderValue = newValue
                        guard !isDragging else { return }
                        
                        onSeek(newValue)
                    }
                ),
                in: 0...audioData.totalTime,
                onEditingChanged: { dragging in
                    isDragging = dragging
                    guard !isDragging else {
                        sliderValue = audioData.currentTime
                        return
                    }
                    
                    onSeek(sliderValue)
                }
            )
            .accentColor(.blue)
            
            Text(String.timeString(from: audioData.totalTime))
                .font(.caption)
                .frame(width: 35)
                .foregroundColor(.gray)
        }
        .padding(.horizontal)
        .padding(.vertical, 6)
    }
}

#Preview {
    ChapterSliderComponent(
        chapter: .init(projectedValue: .constant(.chapter1)),
        audioData: .init(projectedValue: .constant(.empty)),
        onSeek: { _ in }
    )
}
