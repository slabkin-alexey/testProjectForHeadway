//
//  ChapterType+ToAudioInfo.swift
//

import Foundation
import AVFAudio
import UIKit

extension ChapterType {
    func toAudioData(isPlaying: Bool) -> AudioData {
        guard let audioDuration = getAudioDuration(named: audioFileName) else { return .empty }
                
        return .init(
            fileName: audioFileName,
            audioSpeed: .x1,
            isAtStartOfList: isAtStartOfList,
            isAtEndOfList: isAtEndOfList,
            currentTime: 0,
            totalTime: audioDuration,
            isPlaying: isPlaying
        )
    }
    
    private func getAudioDuration(named fileName: String) -> TimeInterval? {
        guard let dataAsset = NSDataAsset(name: fileName) else {
            print("File \(fileName) not found in Assets.xcassets")
            return nil
        }
        
        do {
            let audioPlayer = try AVAudioPlayer(data: dataAsset.data)
            return audioPlayer.duration
        } catch {
            print("An error occurred while loading the audio file: \(error.localizedDescription)")
            return nil
        }
    }
}
