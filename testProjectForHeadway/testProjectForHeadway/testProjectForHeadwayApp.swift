//
//  testProjectForHeadwayApp.swift
//

import SwiftUI
import ComposableArchitecture
import CombineSchedulers

@main
struct testProjectForHeadwayApp: App {
    let store = Store(
        initialState: AppFeature.State(),
        reducer: {
            AppFeature()
                .dependency(\.playerManager, PlayerManager())
                .dependency(\.mainQueue, DispatchQueue.main.eraseToAnyScheduler())
        }
    )
    
    var body: some Scene {
        WindowGroup {
            ContentView(store: store)
        }
    }
}
