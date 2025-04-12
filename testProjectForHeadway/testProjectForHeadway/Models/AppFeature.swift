//
//  AppFeature.swift
//

import ComposableArchitecture
import CombineSchedulers
import Foundation

@Reducer
struct AppFeature {
    @Dependency(\.playerManager) var playerManager
    @Dependency(\.mainQueue) var mainQueue
    
    struct State: Equatable {
        var audioData: AudioData = .empty
        var currentChapter: ChapterType = .chapter1
        var isPlaying: Bool = false
    }
    
    enum AppAction: Equatable {
        case onAppear
        case updateCurrentTime(TimeInterval)
        case setCurrentTime(TimeInterval)
        case updateIsPlaying(Bool)
        case updateSpeed(AudioSpeed)
        case setChapter(ChapterType)
        case updateAudioData(AudioData)
        case togglePlayPause
        case rewind
        case forward
        case nextChapter
        case previousChapter
    }
    
    func reduce(into state: inout State, action: AppAction) -> Effect<AppAction> {
        switch action {
        case .onAppear:
            playerManager.setupPlayer(withFileName: state.currentChapter.audioFileName)
            state.currentChapter = .chapter1
            state.audioData = .empty
            state.audioData.totalTime = playerManager.duration
            
            return .run { send in
                for await time in playerManager.currentTimePublisher.values {
                    
                    await send(.updateCurrentTime(time))
                }
            }
        case let .updateCurrentTime(time):
            state.audioData.currentTime = time
            return .none
        case let .setCurrentTime(time):
            state.audioData.currentTime = time
            playerManager.setCurrentTime(time: time)
            return .none
        case let .updateIsPlaying(isPlaying):
            state.isPlaying = isPlaying
            return .none
        case let .updateSpeed(speed):
            state.audioData.audioSpeed = speed
            state.audioData.updateSpeed(speed: speed)
            playerManager.setPlaybackSpeed(to: speed.rawValue)
            return .none
        case let .setChapter(chapter):
            state.currentChapter = chapter
            playerManager.setupPlayer(withFileName: chapter.audioFileName)
            return .none
        case let .updateAudioData(audioData):
            state.audioData = audioData
            return .none
        case .togglePlayPause:
            playerManager.togglePlayPause()
            return .none
        case .rewind:
            state.audioData.onRewind()
            playerManager.rewind5Seconds()
            return .none
        case .forward:
            state.audioData.onForward()
            playerManager.forward10Seconds()
            return .none
        case .nextChapter:
            if !state.currentChapter.isAtEndOfList, let next = ChapterType(rawValue: state.currentChapter.id + 1) {
                state.currentChapter = next
                playerManager.stop()
                playerManager.setPlaybackSpeed(to: AudioSpeed.x1.rawValue)
                playerManager.setupPlayer(withFileName: next.audioFileName)
                state.audioData = next.toAudioData(isPlaying: false)
                state.isPlaying = false
            }
            return .none
        case .previousChapter:
            if !state.currentChapter.isAtStartOfList, let prev = ChapterType(rawValue: state.currentChapter.id - 1) {
                state.currentChapter = prev
                playerManager.setPlaybackSpeed(to: AudioSpeed.x1.rawValue)
                playerManager.setupPlayer(withFileName: prev.audioFileName)
                state.audioData = prev.toAudioData(isPlaying: false)
                state.isPlaying = false
            }
            return .none
        }
    }
}
