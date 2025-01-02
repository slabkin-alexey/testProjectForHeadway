//
//  AudioData+Extension.swift
//

import Foundation

extension AudioData {
    mutating func updateCurrentTime(time: Double) {
        currentTime = time
    }
    
    mutating func updateSpeed(speed: AudioSpeed) {
        audioSpeed = speed
    }
    
    mutating func onForward() {
        let newTime = currentTime + 10
        
        guard newTime > totalTime else {
            currentTime = newTime
            return
        }
        
        currentTime = totalTime
    }
    
    mutating func onRewind() {
        let newTime = currentTime - 5
        
        guard newTime < 0 else {
            currentTime = newTime
            return
        }
        
        currentTime = 0
    }
}

extension AudioData {
    var isAtStartOfTrack: Bool {
        currentTime == .zero
    }
    
    var isAtEndOfTrack: Bool {
        currentTime == totalTime
    }
}
