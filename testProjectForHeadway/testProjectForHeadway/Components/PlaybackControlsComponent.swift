//
//  PlaybackControlsComponent.swift
//

import SwiftUI

struct PlaybackControlsComponent: View {
    var onPrevious: () -> Void
    var onRewind: () -> Void
    var onPlayPause: () -> Void
    var onForward: () -> Void
    var onNext: () -> Void
    
    @Binding var audioData: AudioData
        
    var body: some View {
        HStack(spacing: 30) {
            Button(action: onPrevious) {
                Image(systemName: "backward.end.fill")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .font(.title)
                    .foregroundColor(.black.opacity(audioData.isAtStartOfList ? 0.3 : 1.0))
            }
            .disabled(audioData.isAtStartOfList)
            
            Button(action: onRewind) {
                VStack {
                    Image(systemName: "gobackward.5")
                        .resizable()
                        .frame(width: 27, height: 30)
                        .font(.title)
                        .foregroundColor(.black.opacity(audioData.isAtStartOfTrack ? 0.3 : 1.0))
                }
            }
            .disabled(audioData.isAtStartOfTrack)
            
            Button(action: {
                audioData.isPlaying.toggle()
                onPlayPause()
            }) {
                Image(systemName: audioData.isPlaying ? "pause.fill" : "play.fill")
                    .resizable()
                    .frame(width: 35, height: 35)
                    .font(.title)
                    .foregroundColor(.black)
            }
            
            Button(action: onForward) {
                VStack {
                    Image(systemName: "goforward.10")
                        .resizable()
                        .frame(width: 27, height: 30)
                        .font(.title)
                        .foregroundColor(.black.opacity(audioData.isAtEndOfTrack ? 0.3 : 1.0))
                }
            }
            .disabled(audioData.isAtEndOfTrack)
            
            Button(action: onNext) {
                Image(systemName: "forward.end.fill")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .font(.title)
                    .foregroundColor(.black.opacity(audioData.isAtEndOfList ? 0.3 : 1.0))
            }
            .disabled(audioData.isAtEndOfList)
        }
        .padding()
    }
}

#Preview {
    PlaybackControlsComponent(
        onPrevious: { print("Previous track") },
        onRewind: { print("Rewind 5 seconds") },
        onPlayPause: { print("Play/Pause toggled") },
        onForward: { print("Forward 10 seconds") },
        onNext: { print("Next track") },
        audioData: .init(projectedValue: .constant(.empty))
    )
}
