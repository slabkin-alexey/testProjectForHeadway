//
//  PlayerManagerTests.swift
//

@testable import testProjectForHeadway
import XCTest
import SwiftUI

final class PlayerManagerTests: XCTestCase {
    var playerManager: PlayerManager!
    
    override func setUp() {
        super.setUp()
        playerManager = PlayerManager()
        playerManager.setupPlayer(withFileName: "chapter_2")
    }
    
    override func tearDown() {
        playerManager = nil
        super.tearDown()
    }
    
    func testSetupPlayer() {
        XCTAssertNotNil(playerManager, "PlayerManager should not be nil.")
        XCTAssertEqual(playerManager.currentTime, 0, "Current time should be 0 after setup.")
    }
    
    func testTogglePlayPause() {
        // Test play
        playerManager.togglePlayPause()
        XCTAssertTrue(playerManager.isPlaying, "Player should be playing after toggle.")
        
        // Test pause
        playerManager.togglePlayPause()
        XCTAssertFalse(playerManager.isPlaying, "Player should be paused after toggle.")
    }
    
    func testForward10Seconds() {
        playerManager.setCurrentTime(time: 10)
        playerManager.forward10Seconds()
        XCTAssertEqual(playerManager.currentTime, 20, "AudioPlayer should move forward by 10 seconds.")
    }
    
    func testRewind5Seconds() {
        playerManager.setCurrentTime(time: 10)
        playerManager.rewind5Seconds()
        XCTAssertEqual(playerManager.currentTime, 5, "AudioPlayer should rewind by 5 seconds.")
    }
    
    func testRewind5SecondsAtStart() {
        playerManager.setCurrentTime(time: 0)
        playerManager.rewind5Seconds()
        XCTAssertEqual(playerManager.currentTime, 0, "AudioPlayer should not rewind below 0.")
    }
    
    func testSetPlaybackSpeed() {
        playerManager.setPlaybackSpeed(to: 1.5)
        XCTAssertEqual(playerManager.playbackSpeed, 1.5, "Playback speed in PlayerManager should match the audio player's speed.")
    }
    
    func testSetCurrentTime() {
        playerManager.setCurrentTime(time: 30)
        XCTAssertEqual(playerManager.currentTime, 30, "PlayerManager currentTime should match the audio player's currentTime.")
    }
    
    func testStop() {
        playerManager.setCurrentTime(time: 10)
        playerManager.togglePlayPause()
        playerManager.stop()
        
        XCTAssertFalse(playerManager.isPlaying, "Player should be stopped.")
        XCTAssertEqual(playerManager.currentTime, 0, "PlayerManager currentTime should be reset to 0.")
    }
}
