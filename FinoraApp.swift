//
//  FinoraApp.swift
//  Finora
//
//  Created on [Date]
//

import SwiftUI

@main
struct FinoraApp: App {
    @StateObject private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(appState)
        }
    }
}

