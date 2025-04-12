//
//  ContentView.swift
//

import SwiftUI
import ComposableArchitecture

struct ContentView: View {
    let store: StoreOf<AppFeature>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack {
                CoverComponent(chapter: viewStore.binding(
                    get: \.currentChapter,
                    send: AppFeature.Action.setChapter
                ))
                
                ChapterKeyPointComponent(chapter: viewStore.binding(
                    get: \.currentChapter,
                    send: AppFeature.Action.setChapter
                ))
                
                BookDescriptionComponent(chapter: viewStore.binding(
                    get: \.currentChapter,
                    send: AppFeature.Action.setChapter
                ))
                
                ChapterSliderComponent(
                    chapter: viewStore.binding(
                        get: \.currentChapter,
                        send: AppFeature.Action.setChapter
                    ),
                    audioData: viewStore.binding(
                        get: \.audioData,
                        send: AppFeature.Action.updateAudioData
                    ),
                    onSeek: { time in
                        viewStore.send(.setCurrentTime(time))
                    }
                )
                
                SpeedButtonComponent(
                    speed: viewStore.binding(
                        get: \.audioData.audioSpeed,
                        send: AppFeature.Action.updateSpeed
                    ),
                    onSpeedChange: { newSpeed in
                        viewStore.send(.updateSpeed(newSpeed))
                    }
                )
                
                PlaybackControlsComponent(
                    onPrevious: { viewStore.send(.previousChapter) },
                    onRewind: { viewStore.send(.rewind) },
                    onPlayPause: { viewStore.send(.togglePlayPause) },
                    onForward: { viewStore.send(.forward) },
                    onNext: { viewStore.send(.nextChapter) },
                    audioData: viewStore.binding(
                        get: \.audioData,
                        send: AppFeature.Action.updateAudioData
                    )
                )
            }
            .padding()
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
    }
}
