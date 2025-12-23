//
//  MainTabView.swift
//  Finora
//
//  Main tab bar navigation
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        TabView {
            TransactionListView()
                .tabItem {
                    Label("Transactions", systemImage: "list.bullet")
                }
            
            DashboardView()
                .tabItem {
                    Label("Dashboard", systemImage: "chart.pie.fill")
                }
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
        .tint(Color.actionPrimary)
    }
}

// Placeholder views
struct DashboardView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color.backgroundPrimary
                    .ignoresSafeArea()
                
                Text("Dashboard")
                    .foregroundColor(Color.textPrimary)
            }
            .navigationTitle("Dashboard")
        }
    }
}

struct ProfileView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.backgroundPrimary
                    .ignoresSafeArea()
                
                VStack {
                    if let user = appState.currentUser {
                        Text("Welcome, \(user.fullName)")
                            .foregroundColor(Color.textPrimary)
                    }
                    
                    PrimaryButton(title: "Logout") {
                        SessionManager.shared.clearSession()
                        appState.isAuthenticated = false
                    }
                    .padding(.horizontal, 24)
                }
            }
            .navigationTitle("Profile")
        }
    }
}

