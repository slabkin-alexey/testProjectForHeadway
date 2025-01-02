//
//  ContentView.swift
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    private let chaptersCount = ChapterType.allCases.count
    
    @StateObject var playerManager = PlayerManager()
    @State var audioData: AudioData = .empty
    @State var currentChapter: ChapterType = .chapter1
    @State var isPlaying: Bool = false
    
    var body: some View {
        VStack {
            CoverComponent(chapter: $currentChapter)
            ChapterKeyPointComponent(chapter: $currentChapter)
            BookDescriptionComponent(chapter: $currentChapter)
            ChapterSliderComponent(chapter: $currentChapter, audioData: $audioData) {
                updatePlayerCurrentTime(time: $0)
            }
            SpeedButtonComponent(speed: $audioData.audioSpeed) { updateSpeed(speed: $0) }
            PlaybackControlsComponent(
                onPrevious: { previousChapter() },
                onRewind: { rewindAudio() },
                onPlayPause: { togglePlayPause() },
                onForward: { forwardAudio() },
                onNext: { nextChapter() },
                audioData: $audioData
            )
        }
        .onAppear {
            currentChapter = ChapterType.chapter1
            updateAudioData()
            setupPlayer(fileName: currentChapter.audioFileName)
        }
        .onReceive(playerManager.$currentTime) { updateCurrentTime(time: $0) }
        .onReceive(playerManager.$isPlaying) { isPlaying = $0 }
        .padding()
    }
}

#Preview {
    ContentView()
}
