//
//  AudioData.swift
//

import Foundation

struct AudioData: Equatable {
    var fileName: String
    var audioSpeed: AudioSpeed
    var isAtStartOfList: Bool
    var isAtEndOfList: Bool
    var currentTime: Double
    var totalTime: Double
    var isPlaying: Bool
    
    static var empty: Self = .init(
        fileName: "",
        audioSpeed: .x1,
        isAtStartOfList: false,
        isAtEndOfList: false,
        currentTime: 0,
        totalTime: 0,
        isPlaying: false
    )
}
