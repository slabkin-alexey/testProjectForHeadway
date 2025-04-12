//
//  MainQueue+Dependency.swift
//

import Foundation
import ComposableArchitecture
import CombineSchedulers

enum MainQueueKey: DependencyKey {
    static let liveValue = DispatchQueue.main.eraseToAnyScheduler()
}

extension DependencyValues {
    var mainQueue: AnySchedulerOf<DispatchQueue> {
        get { self[MainQueueKey.self] }
        set { self[MainQueueKey.self] = newValue }
    }
}
