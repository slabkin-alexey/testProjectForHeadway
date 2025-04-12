//
//  PlayerManager+Dependency.swift
//

import Foundation
import ComposableArchitecture

enum PlayerManagerKey: DependencyKey {
    static let liveValue = PlayerManager()
}

extension DependencyValues {
    var playerManager: PlayerManager {
        get { self[PlayerManagerKey.self] }
        set { self[PlayerManagerKey.self] = newValue }
    }
}
