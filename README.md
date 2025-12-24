# Finora - AI-Powered Personal Finance Assistant

> Your financial data, your control. Powered by AI, secured by blockchain.

Finora is a privacy-first mobile app that uses AI to analyze financial habits, provide personalized budgeting, investment, and debt strategies, while using decentralized storage (IPFS/blockchain) for full user data control and privacy.

---

## 📱 App Flow Overview

This app is an AI-powered personal finance assistant with decentralized data ownership. The flow is designed to prioritize user trust, privacy, and explainable AI insights.

### High-Level User Flow

1. **Splash & Onboarding** - Welcome experience and feature introduction
2. **Authentication & Security Setup** - Secure account creation with biometric options
3. **Decentralized Identity & Key Management** - Generate and backup encryption keys
4. **Financial Profile Setup** - Initial financial data input
5. **Dashboard (Insights & Overview)** - Central hub for financial overview and AI insights
6. **Budgeting Management** - Track and optimize monthly spending
7. **Investment Guidance** - Risk assessment and portfolio recommendations
8. **Debt Optimization** - Smart debt payoff strategies
9. **Peer Benchmarking (Anonymized)** - Compare financial health with anonymous peers
10. **AI Assistant & Insights** - Conversational AI for financial queries
11. **Settings & Data Control** - Privacy controls and data management

---

## 🏗 Architecture Philosophy

- **MVVM Architecture** - Clear separation between Views, ViewModels, and Models
- **Feature-based Modular Structure** - Organized by domain, not file type
- **Privacy-First Design** - User data ownership is paramount
- **Decentralized Data Control** - IPFS/blockchain for data storage (future implementation)
- **AI as an Assistant** - AI provides insights, not authority
- **Explainable AI** - Transparent reasoning for all AI recommendations
- **Zero-Knowledge Architecture** - AI processes encrypted data locally

---

## 📁 Project Structure

```
Finora/
├── App/
│   └── FinoraApp.swift                    # Main app entry point
│
├── Core/
│   ├── Navigation/
│   │   ├── AppRouter.swift                # Central navigation coordinator
│   │   └── AppRoute.swift                 # All app routes/destinations
│   │
│   ├── Security/
│   │   └── EncryptionPlaceholder.swift    # Future: IPFS/blockchain encryption
│   │
│   └── AI/
│       └── AIEnginePlaceholder.swift      # Future: ML/AI integration
│
├── Features/
│   ├── Onboarding/
│   │   ├── Views/
│   │   │   ├── SplashView.swift
│   │   │   ├── OnboardingView.swift
│   │   │   └── PrivacyIntroView.swift
│   │   └── ViewModels/
│   │       └── OnboardingViewModel.swift
│   │
│   ├── Authentication/
│   │   ├── Views/
│   │   │   ├── LoginView.swift
│   │   │   ├── RegisterView.swift
│   │   │   └── BiometricSetupView.swift
│   │   └── ViewModels/
│   │       └── AuthViewModel.swift
│   │
│   ├── Identity/
│   │   ├── Views/
│   │   │   ├── KeyGenerationView.swift     # DID key generation
│   │   │   └── KeyBackupView.swift         # Recovery phrase backup
│   │   └── ViewModels/
│   │       └── IdentityViewModel.swift
│   │
│   ├── Dashboard/
│   │   ├── Views/
│   │   │   ├── DashboardView.swift         # Main financial overview
│   │   │   └── InsightCardView.swift       # AI insight display
│   │   └── ViewModels/
│   │       └── DashboardViewModel.swift
│   │
│   ├── Budgeting/
│   │   ├── Views/
│   │   │   ├── BudgetOverviewView.swift
│   │   │   └── BudgetEditView.swift
│   │   └── ViewModels/
│   │       └── BudgetViewModel.swift
│   │
│   ├── Investments/
│   │   ├── Views/
│   │   │   ├── InvestmentOverviewView.swift
│   │   │   └── RiskProfileView.swift
│   │   └── ViewModels/
│   │       └── InvestmentViewModel.swift
│   │
│   ├── Debt/
│   │   ├── Views/
│   │   │   ├── DebtOverviewView.swift
│   │   │   └── DebtStrategyView.swift      # Avalanche/Snowball methods
│   │   └── ViewModels/
│   │       └── DebtViewModel.swift
│   │
│   ├── PeerBenchmarking/
│   │   ├── Views/
│   │   │   └── PeerComparisonView.swift    # Anonymous peer comparison
│   │   └── ViewModels/
│   │       └── PeerBenchmarkViewModel.swift
│   │
│   ├── AIInsights/
│   │   ├── Views/
│   │   │   ├── AIChatView.swift            # Conversational AI assistant
│   │   │   └── AIInsightDetailView.swift   # Detailed insight explanation
│   │   └── ViewModels/
│   │       └── AIInsightsViewModel.swift
│   │
│   └── Settings/
│       ├── Views/
│       │   ├── SettingsView.swift
│       │   └── DataControlView.swift       # Data export/deletion
│       └── ViewModels/
│           └── SettingsViewModel.swift
│
├── DesignSystem/
│   └── Theme/
│       ├── Color+Finora.swift              # Comprehensive color system
│       ├── ColorSystemExamples.swift       # Color usage examples
│       └── FINORA_COLOR_SYSTEM.md          # Color documentation
│
└── README.md
```

---

## 🎨 Design System

Finora uses a production-ready SwiftUI color system with:

- **40+ semantic colors** with intelligent naming
- **Full Light/Dark mode support**
- **WCAG AAA accessibility compliance**
- **AI-specific colors** (teal gradients for AI features)
- **Financial data colors** (income green, expense orange, etc.)
- **Pre-configured gradients** and shadow modifiers

See `DesignSystem/Theme/FINORA_COLOR_SYSTEM.md` for complete documentation.

---

## 🚧 Current Status

### ✅ Completed

- **Project Structure** - Complete MVVM feature-based architecture
- **Navigation System** - Centralized routing with AppRouter
- **UI Flow Scaffolding** - All screens and navigation flows
- **Design System** - Production-ready color system
- **Placeholder Views** - All feature views implemented
- **ViewModels** - Stub view models for all features
- **Core Placeholders** - AI and Security integration points

### 🔄 In Progress

- UI flow scaffolding only
- No AI, blockchain, or encryption logic implemented yet
- Views and ViewModels are placeholders

### ⏳ Not Started

- AI/ML integration
- Blockchain/IPFS storage
- Actual authentication backend
- Real data persistence
- Biometric authentication implementation
- API integrations

---

## 🔮 Future Integrations

### AI & Machine Learning

- **Expense Categorization** - Auto-categorize transactions using NLP
- **Predictive Spending Analysis** - Forecast future expenses
- **Personalized Budgeting** - AI-generated budget recommendations
- **Investment Risk Assessment** - ML-powered risk profiling
- **Debt Optimization** - Intelligent payoff strategies
- **Anomaly Detection** - Identify unusual spending patterns
- **Natural Language Queries** - Conversational financial assistant

### Decentralized Technologies

- **IPFS Storage** - Decentralized file storage for encrypted data
- **Blockchain Audit Trail** - Immutable access logs
- **Decentralized Identity (DID)** - User-controlled identity
- **Smart Contracts** - Automated financial agreements
- **Zero-Knowledge Proofs** - Privacy-preserving authentication
- **Filecoin Integration** - Incentivized decentralized storage

### Privacy & Security

- **End-to-End Encryption** - AES-256 for all user data
- **Biometric Authentication** - Face ID / Touch ID
- **Key Management** - Secure key generation and backup
- **Privacy-Preserving Benchmarking** - Federated learning for peer comparison
- **Encrypted Sync** - Cross-device synchronization
- **Secure Enclaves** - Hardware-backed encryption

---

## 🚀 Getting Started

### Prerequisites

- **Xcode 15.0+**
- **iOS 16.0+**
- **Swift 5.9+**
- **SwiftUI**

### Building the Project

1. Clone the repository
2. Open `Finora.xcodeproj` in Xcode
3. Select a simulator or device
4. Press `Cmd + R` to build and run

### Navigation Flow

The app uses `NavigationStack` with programmatic navigation:

```swift
// Navigate to a screen
router.navigate(to: .budgetOverview)

// Navigate back
router.navigateBack()

// Replace entire stack
router.replaceStack(with: .dashboard)
```

### Adding New Features

1. Create feature folder: `Features/NewFeature/`
2. Add `Views/` and `ViewModels/` subfolders
3. Create view files and view model
4. Add routes to `AppRoute.swift`
5. Implement navigation in views

---

## 📐 Architecture Details

### MVVM Pattern

- **Model** - Data structures and business logic
- **View** - SwiftUI views (UI only, no business logic)
- **ViewModel** - State management and data transformation

### Feature Organization

Each feature is self-contained with:

```
FeatureName/
├── Views/           # SwiftUI views for this feature
├── ViewModels/      # ObservableObject view models
└── Models/          # Feature-specific data models (optional)
```

### Navigation

- **AppRouter** - Single source of truth for navigation state
- **AppRoute** - Enum defining all possible destinations
- **NavigationStack** - SwiftUI native navigation
- **@EnvironmentObject** - Router injected app-wide

### State Management

- **@Published** properties in ViewModels
- **@StateObject** for view model lifecycle
- **@EnvironmentObject** for shared state (router, auth)
- **@State** for local view state only

---

## 🔒 Security Principles

1. **User Owns Data** - All data encrypted with user-controlled keys
2. **Zero-Knowledge** - App cannot read user's raw financial data
3. **Decentralized Storage** - No single point of failure
4. **Local AI Processing** - Sensitive analysis done on-device
5. **Transparent Algorithms** - All AI decisions are explainable
6. **Privacy by Design** - GDPR/CCPA compliant from day one

---

## 🎯 Development Roadmap

### Phase 1: Foundation (Current)
- [x] Project structure
- [x] Navigation system
- [x] Design system
- [x] UI flow scaffolding
- [ ] Core Data models
- [ ] Local storage

### Phase 2: Core Features
- [ ] Actual authentication
- [ ] Budget tracking logic
- [ ] Transaction management
- [ ] Basic analytics

### Phase 3: AI Integration
- [ ] ML expense categorization
- [ ] Predictive analytics
- [ ] Personalized recommendations
- [ ] AI chat assistant

### Phase 4: Decentralization
- [ ] IPFS integration
- [ ] Blockchain audit trail
- [ ] Decentralized identity
- [ ] Encrypted sync

### Phase 5: Advanced Features
- [ ] Peer benchmarking
- [ ] Investment recommendations
- [ ] Debt optimization AI
- [ ] Financial goal planning

---

## 🧪 Testing Strategy

### Unit Tests
- ViewModels business logic
- Data transformation logic
- Navigation flow logic

### UI Tests
- Critical user flows
- Onboarding completion
- Authentication flow
- Data entry screens

### Integration Tests
- AI engine integration
- Blockchain storage
- Encryption/decryption
- Cross-feature workflows

---

## 📚 Documentation

- **Color System** - `DesignSystem/Theme/FINORA_COLOR_SYSTEM.md`
- **API Documentation** - Coming soon
- **AI Models** - Coming soon
- **Blockchain Integration** - Coming soon

---

## 🤝 Contributing

This is a personal finance app focused on privacy and AI. Contributions welcome for:

- UI/UX improvements
- AI model optimization
- Security enhancements
- Privacy-preserving features
- Accessibility improvements

---

## 📄 License

*License information to be added*

---

## 🙏 Acknowledgments

- **SwiftUI** - Apple's declarative UI framework
- **IPFS** - Decentralized storage protocol
- **Machine Learning** - Core ML and AI frameworks
- **Privacy Community** - For privacy-first principles

---

## 📞 Contact

*Contact information to be added*

---

**Built with ❤️ for financial empowerment and data privacy**
