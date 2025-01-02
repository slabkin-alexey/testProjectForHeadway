//
//  PlayerManager.swift
//

import Foundation
import AVFoundation
import UIKit

class PlayerManager: ObservableObject {
    private var audioPlayer: AVAudioPlayer?
    private var timer: Timer?
    
    @Published var isPlaying: Bool = false
    @Published var currentTime: TimeInterval = 0
    @Published var duration: TimeInterval = 0
    @Published var playbackSpeed: Float = 1.0
    
    func setupPlayer(withFileName fileName: String) {
        guard let dataAsset = NSDataAsset(name: fileName) else {
            print("File \(fileName) not found in Assets.xcassets")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(data: dataAsset.data)
            audioPlayer?.prepareToPlay()
            audioPlayer?.enableRate = true
            duration = audioPlayer?.duration ?? 0
            currentTime = 0
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
            guard let self = self, let player = self.audioPlayer else { return }
            DispatchQueue.main.async {
                self.currentTime = player.currentTime
            }
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}
