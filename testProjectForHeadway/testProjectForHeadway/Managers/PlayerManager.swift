//
//  PlayerManager.swift
//

import Foundation
import AVFoundation
import UIKit
import Combine

class PlayerManager: ObservableObject {
    private var audioPlayer: AVAudioPlayer?
    private var timer: Timer?
    private let currentTimeSubject = PassthroughSubject<TimeInterval, Never>()
    var onReadyToPlay: ((TimeInterval) -> Void)?
    
    @Published var isPlaying: Bool = false
    @Published var currentTime: TimeInterval = 0
    @Published var duration: TimeInterval = 0
    @Published var playbackSpeed: Float = 1.0
    
    var currentTimePublisher: AnyPublisher<TimeInterval, Never> {
        currentTimeSubject.eraseToAnyPublisher()
    }
    
    func setupPlayer(withFileName fileName: String) {
        guard let dataAsset = NSDataAsset(name: fileName) else {
            print("File \(fileName) not found in Assets.xcassets")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(data: dataAsset.data)
            audioPlayer?.prepareToPlay()
            audioPlayer?.enableRate = true
            audioPlayer?.currentTime = .zero
            currentTime = .zero
            currentTimeSubject.send(.zero)
            duration = audioPlayer?.duration ?? .zero
            playbackSpeed = 1.0
        } catch {
            print("An error occurred while initializing the player: \(error.localizedDescription)")
        }
    }
    
    func togglePlayPause() {
        guard let audioPlayer else { return }
        
        if audioPlayer.isPlaying {
            audioPlayer.pause()
            isPlaying = false
            stopTimer()
        } else {
            audioPlayer.play()
            isPlaying = true
            startTimer()
        }
    }
    
    func forward10Seconds() {
        guard let audioPlayer else { return }
        
        let newTime = audioPlayer.currentTime + 10
        audioPlayer.currentTime = min(newTime, audioPlayer.duration)
        currentTime = audioPlayer.currentTime
    }
    
    func rewind5Seconds() {
        guard let audioPlayer else { return }
        
        let newTime = audioPlayer.currentTime - 5
        audioPlayer.currentTime = max(newTime, 0)
        currentTime = audioPlayer.currentTime
    }
    
    func setPlaybackSpeed(to speed: Float) {
        guard let audioPlayer else { return }
        
        playbackSpeed = speed
        audioPlayer.rate = speed
    }
    
    func updateCurrentTime() {
        guard let audioPlayer else { return }
        
        currentTime = audioPlayer.currentTime
    }
    
    func setCurrentTime(time: Double) {
        guard let audioPlayer else { return }
        
        audioPlayer.currentTime = time
        currentTime = time
    }
    
    func stop() {
        guard let audioPlayer else { return }
        
        audioPlayer.stop()
        audioPlayer.currentTime = 0
        currentTime = 0
        isPlaying = false
    }
    
    private func startTimer() {
        stopTimer()
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            DispatchQueue.main.async { [weak self] in
                guard let self, let audioPlayer else { return }

                currentTime = audioPlayer.currentTime
                currentTimeSubject.send(audioPlayer.currentTime)
            }
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}
