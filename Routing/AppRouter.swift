//
//  AppRouter.swift
//  Finora
//
//  Centralized navigation and routing
//

import SwiftUI

enum AppRoute: Hashable {
    case login
    case transactions
    case transactionDetail(Transaction)
    case dashboard
    case profile
    case settings
}

final class AppRouter: ObservableObject {
    @Published var path = NavigationPath()
    
    func navigate(to route: AppRoute) {
        path.append(route)
    }
    
    func navigateBack() {
        path.removeLast()
    }
    
    func navigateToRoot() {
        path.removeLast(path.count)
    }
}

// Navigation destination view modifier
struct NavigationDestinationModifier: ViewModifier {
    @ObservedObject var router: AppRouter
    
    func body(content: Content) -> some View {
        content
            .navigationDestination(for: AppRoute.self) { route in
                destinationView(for: route)
            }
    }
    
    @ViewBuilder
    private func destinationView(for route: AppRoute) -> some View {
        switch route {
        case .login:
            LoginView()
        case .transactions:
            TransactionListView()
        case .transactionDetail(let transaction):
            TransactionDetailView(transaction: transaction)
        case .dashboard:
            DashboardView()
        case .profile:
            ProfileView()
        case .settings:
            SettingsView()
        }
    }
}

// Placeholder views
struct TransactionDetailView: View {
    let transaction: Transaction
    
    var body: some View {
        VStack {
            Text(transaction.description)
            Text(transaction.formattedAmount)
        }
        .navigationTitle("Transaction Details")
    }
}

struct SettingsView: View {
    var body: some View {
        Text("Settings")
            .navigationTitle("Settings")
    }
}

