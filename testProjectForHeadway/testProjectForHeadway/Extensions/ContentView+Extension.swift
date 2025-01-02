//
//  ContentView+Extension.swift
//

import Foundation

extension ContentView {
    func reset() {
        isPlaying = false
        playerManager.stop()
        updateSpeed(speed: .x1)
        setupPlayer(fileName: currentChapter.audioFileName)
        updateAudioData()
    }
    
    func updateSpeed(speed: AudioSpeed) {
        var updatedAudioData = audioData
        updatedAudioData.updateSpeed(speed: speed)
        audioData = updatedAudioData
        playerManager.setPlaybackSpeed(to: speed.rawValue)
    }
    
    func updateCurrentTime(time: Double) {
        var updatedAudioData = audioData
        updatedAudioData.updateCurrentTime(time: time)
        audioData = updatedAudioData

        guard isPlaying, time == 0.0 else { return }

        reset()
    }
    
    func updatePlayerCurrentTime(time: Double) {
        playerManager.setCurrentTime(time: time)
    }
    
    func rewindAudio() {
        var updatedAudioData = audioData
        updatedAudioData.onRewind()
        audioData = updatedAudioData
        playerManager.rewind5Seconds()
    }
    
    func forwardAudio() {
        var updatedAudioData = audioData
        updatedAudioData.onForward()
        audioData = updatedAudioData
        playerManager.forward10Seconds()
    }
    
    func setupPlayer(fileName: String) {
        playerManager.setupPlayer(withFileName: fileName)
    }
    
    func updateAudioData() {
        audioData = currentChapter.toAudioData(isPlaying: isPlaying)
    }
    
    func nextChapter() {
        let newID = currentChapter.id + 1
        
        guard
            !currentChapter.isAtEndOfList,
            let nextChapter = ChapterType(rawValue: newID)
        else { return }
        
        currentChapter = nextChapter
        reset()
    }
    
    func previousChapter() {
        let newID = currentChapter.id - 1
        
        guard
            !currentChapter.isAtStartOfList,
            let previousChapter = ChapterType(rawValue: newID)
        else { return }
        
        currentChapter = previousChapter
        reset()
    }
    
    func togglePlayPause() {
        playerManager.togglePlayPause()
    }
}
