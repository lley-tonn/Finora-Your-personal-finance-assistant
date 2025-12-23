# Finora - Personal Finance Assistant

A production-ready SwiftUI iOS application built with MVVM architecture, featuring clean separation of concerns and comprehensive testing.

## Project Structure

The project follows a feature-based MVVM architecture:

```
Finora/
├── App/
│   └── FinoraApp.swift                    # App entry point
│
├── Features/                              # Feature modules (MVVM triads)
│   ├── Auth/
│   │   ├── Views/
│   │   │   └── LoginView.swift
│   │   └── ViewModels/
│   │       └── LoginViewModel.swift
│   │
│   ├── Transactions/
│   │   ├── Views/
│   │   │   └── TransactionListView.swift
│   │   └── ViewModels/
│   │       └── TransactionListViewModel.swift
│   │
│   └── Main/
│       └── Views/
│           ├── RootView.swift
│           └── MainTabView.swift
│
├── Models/                                # Shared domain models
│   ├── User.swift
│   └── Transaction.swift
│
├── Core/                                  # Infrastructure layer
│   ├── AppState.swift                     # App-wide state management
│   ├── Network/
│   │   ├── NetworkClient.swift            # Generic API client
│   │   └── APIEndpoint.swift              # API endpoint definitions
│   ├── Services/
│   │   ├── AuthService.swift              # Authentication service
│   │   └── SessionManager.swift           # Session management
│   ├── Managers/
│   │   └── NetworkMonitor.swift           # Network connectivity monitor
│   └── Utilities/
│       ├── Extensions/
│       │   ├── String+Extensions.swift
│       │   └── View+Extensions.swift
│       └── Constants/
│           └── AppConstants.swift
│
├── Components/                            # Reusable UI components
│   ├── Buttons/
│   │   └── PrimaryButton.swift
│   ├── TextFields/
│   │   └── CustomTextField.swift
│   ├── Cards/
│   │   ├── BalanceCard.swift
│   │   └── TransactionRow.swift
│   ├── FilterChip.swift
│   └── EmptyStateView.swift
│
├── Resources/                             # App resources
│   ├── Colors/
│   │   └── AppColors.swift
│   └── Localizable/
│       └── Strings.swift
│
├── Routing/                               # Navigation & routing
│   └── AppRouter.swift
│
├── Preview/                               # Preview helpers
│   ├── MockData.swift
│   ├── MockServices.swift
│   └── PreviewHelpers.swift
│
└── Tests/                                 # Unit tests
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
- **Views**: SwiftUI views organized by feature, handling only UI presentation
- **ViewModels**: Observable objects managing view state and business logic
- **Services**: Business logic and API integration in the Core layer

### Key Features
- ✅ Clean MVVM architecture with feature-based organization
- ✅ Protocol-based dependency injection for testability
- ✅ Combine for reactive programming
- ✅ Centralized navigation/routing
- ✅ Comprehensive unit testing setup
- ✅ Mock services for previews and testing
- ✅ Reusable UI components
- ✅ Network layer with error handling
- ✅ Session management
- ✅ iOS 16+ SwiftUI features

## Getting Started

### Prerequisites
- Xcode 15.0 or later
- iOS 16.0+ deployment target
- XcodeGen (for project regeneration)

### Setup
1. Clone the repository
2. Open `Finora.xcodeproj` in Xcode
3. Select an iOS 16+ simulator or device
4. Build and run with `Cmd + R`

### Regenerating the Project
If you modify `project.yml` or need to regenerate the Xcode project:

```bash
xcodegen generate
```

Or use the provided script:

```bash
./setup_xcode_project.sh
```

## Building and Testing

### Build the Project
```bash
# Using Xcode
Cmd + B

# Using command line
xcodebuild -scheme Finora -sdk iphonesimulator build
```

### Run Tests
```bash
# Using Xcode
Cmd + U

# Using command line
xcodebuild test -scheme Finora
```

## Architecture Principles

1. **Separation of Concerns**: Clear boundaries between layers (Models, Views, ViewModels, Services)
2. **Dependency Injection**: ViewModels accept protocol dependencies for testability
3. **Protocol-Oriented**: Services use protocols for flexibility and testing
4. **Reactive Programming**: Combine publishers for async operations
5. **Feature-Based Organization**: Related Views and ViewModels grouped by feature
6. **Testability**: Mock services and comprehensive unit tests
7. **Scalability**: Modular structure for easy growth
8. **Maintainability**: Clear organization and consistent naming

## Code Examples

### ViewModel Example
```swift
@MainActor
final class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoading: Bool = false

    private let authService: AuthServiceProtocol

    init(authService: AuthServiceProtocol = AuthService()) {
        self.authService = authService
    }

    func login() {
        // Handle login logic with Combine
    }
}
```

### View Example
```swift
struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()

    var body: some View {
        VStack {
            CustomTextField(title: "Email", text: $viewModel.email)
            CustomTextField(title: "Password", text: $viewModel.password, isSecure: true)
            PrimaryButton(title: "Login", isLoading: viewModel.isLoading) {
                viewModel.login()
            }
        }
    }
}
```

### Model Example
```swift
struct User: Codable, Identifiable {
    let id: String
    let email: String
    let firstName: String
    let lastName: String

    var fullName: String {
        "\(firstName) \(lastName)"
    }
}
```

## Project Configuration

### Targets
- **Finora**: Main application target
- **FinoraTests**: Unit test target

### Settings
- Bundle Identifier: `com.finora.app`
- iOS Deployment Target: 16.0
- Swift Version: 5.9
- Supported Devices: iPhone & iPad

## Troubleshooting

### Build Errors
- Clean build folder: `Cmd + Shift + K`
- Rebuild: `Cmd + B`
- Verify iOS 16.0+ deployment target

### "No such module" errors
- Ensure all Swift files are included in the target
- Clean and rebuild the project

### Signing Issues
1. Select the `Finora` target in Xcode
2. Go to "Signing & Capabilities"
3. Select your development team
4. Xcode will automatically manage provisioning profiles

## License

[Your License Here]
