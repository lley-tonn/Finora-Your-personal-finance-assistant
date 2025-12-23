# Finora - Personal Finance Assistant

A production-ready SwiftUI iOS application built with MVVM architecture.

## Project Structure

```
Finora/
├── FinoraApp.swift                    # App entry point
│
├── Core/                              # Core infrastructure
│   ├── AppState.swift                 # App-wide state management
│   ├── Network/                       # Network layer
│   │   ├── NetworkClient.swift        # Generic API client
│   │   └── APIEndpoint.swift          # API endpoint definitions
│   ├── Services/                      # Business logic services
│   │   ├── AuthService.swift          # Authentication service
│   │   └── SessionManager.swift       # Session management
│   ├── Managers/                      # System managers
│   │   └── NetworkMonitor.swift       # Network connectivity monitor
│   └── Utilities/                     # Helper utilities
│       ├── Extensions/
│       │   ├── String+Extensions.swift
│       │   └── View+Extensions.swift
│       └── Constants/
│           └── AppConstants.swift
│
├── Models/                            # Data models
│   ├── User.swift                     # User domain model
│   └── Transaction.swift              # Transaction domain model
│
├── ViewModels/                        # ViewModels (MVVM)
│   ├── LoginViewModel.swift           # Login screen ViewModel
│   └── TransactionListViewModel.swift # Transaction list ViewModel
│
├── Views/                             # SwiftUI views
│   ├── RootView.swift                 # Root navigation view
│   ├── MainTabView.swift              # Main tab bar
│   ├── Auth/
│   │   └── LoginView.swift            # Login screen
│   └── Transactions/
│       └── TransactionListView.swift  # Transaction list screen
│
├── Components/                        # Reusable UI components
│   ├── Buttons/
│   │   └── PrimaryButton.swift        # Primary action button
│   ├── TextFields/
│   │   └── CustomTextField.swift      # Custom text field
│   ├── Cards/
│   │   ├── BalanceCard.swift          # Balance display card
│   │   └── TransactionRow.swift       # Transaction row
│   ├── FilterChip.swift               # Filter chip component
│   └── EmptyStateView.swift           # Empty state view
│
├── Resources/                         # App resources
│   ├── Colors/
│   │   └── AppColors.swift            # Color palette
│   └── Localizable/
│       └── Strings.swift              # Localizable strings
│
├── Routing/                           # Navigation & routing
│   └── AppRouter.swift                # Centralized router
│
├── Preview/                           # Preview helpers
│   ├── MockData.swift                 # Mock data for previews
│   ├── MockServices.swift             # Mock services
│   └── PreviewHelpers.swift           # SwiftUI preview helpers
│
└── Tests/                             # Unit tests
    ├── ViewModels/
    │   ├── LoginViewModelTests.swift
    │   └── TransactionListViewModelTests.swift
    ├── Services/
    │   └── AuthServiceTests.swift
    └── Utilities/
        └── StringExtensionsTests.swift
```

## Architecture

### MVVM Pattern
- **Models**: Codable data models representing domain entities
- **Views**: SwiftUI views that display UI and handle user interactions
- **ViewModels**: Observable objects that manage view state and business logic
- **Services**: Business logic and API integration
- **Core**: Infrastructure components (network, managers, utilities)

### Key Features
- ✅ Clean Architecture with separation of concerns
- ✅ Protocol-based dependency injection
- ✅ Combine for reactive programming
- ✅ Centralized navigation/routing
- ✅ Comprehensive unit testing setup
- ✅ Mock services for previews and testing
- ✅ Reusable UI components
- ✅ Network layer with error handling
- ✅ Session management
- ✅ iOS 16+ SwiftUI features

## Getting Started

1. Open the project in Xcode
2. Ensure iOS 16+ deployment target
3. Run the app in simulator or device

## Testing

Run unit tests using:
```bash
xcodebuild test -scheme Finora
```

## Best Practices Implemented

1. **Dependency Injection**: ViewModels accept protocols for services
2. **Protocol-Oriented**: Services use protocols for testability
3. **Reactive Programming**: Combine publishers for async operations
4. **Error Handling**: Comprehensive error types and handling
5. **State Management**: @Published properties in ViewModels
6. **Separation of Concerns**: Clear boundaries between layers
7. **Testability**: Mock services and testable ViewModels
8. **Reusability**: Shared components and utilities

## Example Usage

### ViewModel Example
```swift
@MainActor
final class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoading: Bool = false
    
    private let authService: AuthServiceProtocol
    
    func login() {
        // Handle login logic
    }
}
```

### View Example
```swift
struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    
    var body: some View {
        // UI implementation
    }
}
```

## License

[Your License Here]

