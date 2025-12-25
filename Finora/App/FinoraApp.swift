//
//  FinoraApp.swift
//  Finora
//
//  Main app entry point for Finora - AI-Powered Personal Finance Assistant
//  with decentralized data ownership and privacy-first design
//

import SwiftUI

@main
struct FinoraApp: App {

    // MARK: - State

    @StateObject private var appRouter = AppRouter()
    @StateObject private var appState = AppState()

    // MARK: - Body

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $appRouter.path) {
                SplashView()
                    .navigationDestination(for: AppRoute.self) { route in
                        route.view
                    }
            }
            .environmentObject(appRouter)
            .environmentObject(appState)
        }
    }
}
