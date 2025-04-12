//
//  SpeedButtonComponent.swift
//

import Foundation
import SwiftUI

struct SpeedButtonComponent: View {
    @Binding var speed: AudioSpeed
    var onSpeedChange: (AudioSpeed) -> Void
    
    var body: some View {
        Button(action: {
            speed = speed.isNormalSpeed ? .x2 : .x1
            onSpeedChange(speed)
        }) {
            Text("Speed \(speed)")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.black)
                .padding(8)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
        }
        .padding(.bottom, 12)
    }
}
