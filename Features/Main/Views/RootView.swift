//
//  RootView.swift
//  Finora
//
//  Root view that handles navigation based on auth state
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        Group {
            if appState.isAuthenticated {
                MainTabView()
            } else {
                LoginView()
            }
        }
        .animation(.default, value: appState.isAuthenticated)
    }
}

