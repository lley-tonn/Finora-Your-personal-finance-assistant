# Finora Project Structure

## Complete Folder Tree

```
Finora/
│
├── FinoraApp.swift                    # App entry point (@main)
│
├── Core/                              # Core infrastructure layer
│   ├── AppState.swift                 # App-wide observable state
│   │
│   ├── Network/                       # Network layer
│   │   ├── NetworkClient.swift        # Generic API client with Combine
│   │   └── APIEndpoint.swift          # Endpoint protocol & implementations
│   │
│   ├── Services/                      # Business logic services
│   │   ├── AuthService.swift          # Authentication service
│   │   └── SessionManager.swift       # Session & token management
│   │
│   ├── Managers/                      # System managers
│   │   └── NetworkMonitor.swift       # Network connectivity monitoring
│   │
│   └── Utilities/                     # Helper utilities
│       ├── Extensions/
│       │   ├── String+Extensions.swift    # Email/password validation
│       │   └── View+Extensions.swift      # SwiftUI view helpers
│       └── Constants/
│           └── AppConstants.swift         # App-wide constants
│
├── Models/                            # Domain models (Codable)
│   ├── User.swift                     # User model with computed properties
│   └── Transaction.swift              # Transaction model with categories
│
├── ViewModels/                        # MVVM ViewModels
│   ├── LoginViewModel.swift           # Login screen state & logic
│   └── TransactionListViewModel.swift # Transaction list state & logic
│
├── Views/                             # SwiftUI views (feature-grouped)
│   ├── RootView.swift                 # Root navigation controller
│   ├── MainTabView.swift              # Main tab bar with placeholders
│   │
│   ├── Auth/                          # Authentication feature
│   │   └── LoginView.swift            # Login screen UI
│   │
│   └── Transactions/                  # Transactions feature
│       └── TransactionListView.swift  # Transaction list UI
│
├── Components/                        # Reusable UI components
│   ├── Buttons/
│   │   └── PrimaryButton.swift        # Primary action button
│   │
│   ├── TextFields/
│   │   └── CustomTextField.swift      # Custom text & secure fields
│   │
│   ├── Cards/
│   │   ├── BalanceCard.swift          # Balance display card
│   │   └── TransactionRow.swift       # Transaction list row
│   │
│   ├── FilterChip.swift               # Filter chip component
│   └── EmptyStateView.swift           # Empty state placeholder
│
├── Resources/                         # App resources
│   ├── Colors/
│   │   └── AppColors.swift            # Color palette extension
│   └── Localizable/
│       └── Strings.swift              # Localizable strings enum
│
├── Routing/                           # Navigation & deep linking
│   └── AppRouter.swift                # Centralized router with NavigationPath
│
├── Preview/                           # SwiftUI preview helpers
│   ├── MockData.swift                 # Mock User & Transaction data
│   ├── MockServices.swift             # Mock AuthService & NetworkClient
│   └── PreviewHelpers.swift           # Preview providers
│
├── Tests/                             # Unit tests
│   ├── ViewModels/
│   │   ├── LoginViewModelTests.swift      # LoginViewModel tests
│   │   └── TransactionListViewModelTests.swift
│   │
│   ├── Services/
│   │   └── AuthServiceTests.swift        # AuthService tests
│   │
│   └── Utilities/
│       └── StringExtensionsTests.swift   # String extension tests
│
├── README.md                          # Project documentation
└── PROJECT_STRUCTURE.md               # This file
```

## Folder Explanations

### App/
- **FinoraApp.swift**: Main app entry point using `@main`. Initializes `AppState` and sets up the root view hierarchy.

### Core/
Core infrastructure that supports the entire application:

- **AppState**: Observable object managing app-wide state (authentication, current user, loading states)
- **Network/**: Protocol-based network layer with Combine publishers for reactive API calls
- **Services/**: Business logic services (authentication, transactions, etc.) using protocol-oriented design
- **Managers/**: System-level managers (network monitoring, location, etc.)
- **Utilities/**: Reusable extensions, helpers, and constants

### Models/
Domain models conforming to `Codable` for API serialization. Models include computed properties for presentation logic.

### ViewModels/
MVVM ViewModels that:
- Use `@Published` properties for reactive state
- Handle business logic and API calls
- Accept protocol dependencies for testability
- Are marked with `@MainActor` for UI updates

### Views/
SwiftUI views organized by feature:
- Views are "dumb" - they only handle UI presentation
- All business logic lives in ViewModels
- Views use `@StateObject` or `@ObservedObject` to bind to ViewModels

### Components/
Reusable UI components that can be used across multiple screens:
- Buttons, text fields, cards, chips, etc.
- Self-contained and configurable via parameters

### Resources/
App-wide resources:
- Colors: Centralized color palette
- Localizable: String constants for localization

### Routing/
Centralized navigation handling using SwiftUI's `NavigationPath`:
- Type-safe routing with enum-based routes
- Deep linking support ready

### Preview/
Helpers for SwiftUI previews:
- Mock data for previews
- Mock services that implement protocols
- Preview providers

### Tests/
Comprehensive unit test coverage:
- ViewModel tests with mock services
- Service tests with mock network clients
- Utility function tests

## Example Files

### Model Example: `User.swift`
```swift
struct User: Codable, Identifiable {
    let id: String
    let email: String
    let firstName: String
    let lastName: String
    var fullName: String { "\(firstName) \(lastName)" }
}
```

### ViewModel Example: `LoginViewModel.swift`
```swift
@MainActor
final class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoading: Bool = false
    
    private let authService: AuthServiceProtocol
    
    func login() {
        // Handle login with Combine
    }
}
```

### View Example: `LoginView.swift`
```swift
struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    
    var body: some View {
        VStack {
            CustomTextField(title: "Email", text: $viewModel.email)
            PrimaryButton(title: "Login") {
                viewModel.login()
            }
        }
    }
}
```

## Architecture Principles

1. **Separation of Concerns**: Clear boundaries between layers
2. **Dependency Injection**: Protocols for testability
3. **Reactive Programming**: Combine for async operations
4. **Protocol-Oriented**: Services use protocols
5. **Testability**: Mock services and testable ViewModels
6. **Scalability**: Modular structure for growth
7. **Maintainability**: Clear organization and naming

