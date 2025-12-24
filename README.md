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

## Architecture & User Interaction Flow

This section provides a comprehensive overview of how Finora is structured and how users navigate through the application. It demonstrates the privacy-first, decentralized architecture and illustrates the complete user journey from onboarding to daily financial management.

---

### 🏗 Architectural Map

Finora is designed as a **layered, modular, privacy-first system** that cleanly separates user interface, intelligence, security, and storage responsibilities. Each layer has a distinct purpose and communicates with adjacent layers through well-defined boundaries.

```
┌─────────────────────────────────────────┐
│       Presentation Layer (UI)           │
│   SwiftUI Views & Visual Components     │
└─────────────────────────────────────────┘
                  ↓
┌─────────────────────────────────────────┐
│      Navigation & App Flow              │
│   Screen Transitions & Route Guards     │
└─────────────────────────────────────────┘
                  ↓
┌─────────────────────────────────────────┐
│         Feature Domains                 │
│  Budgeting │ Investments │ Debt │ AI    │
└─────────────────────────────────────────┘
                  ↓
┌─────────────────────────────────────────┐
│       AI Analysis Engine                │
│   Pattern Recognition & Insights        │
└─────────────────────────────────────────┘
                  ↓
┌─────────────────────────────────────────┐
│    Security & Encryption Layer          │
│   Key Management & Data Protection      │
└─────────────────────────────────────────┘
                  ↓
┌─────────────────────────────────────────┐
│   Decentralized Storage Layer           │
│      IPFS / Blockchain References       │
└─────────────────────────────────────────┘
```

---

### Architecture Layers Overview

Each architectural layer has specific responsibilities and constraints to ensure scalability, security, and maintainability.

#### 🎨 Presentation Layer
- **Purpose:** Handles all UI rendering and user interaction
- **Contains:** SwiftUI views, visual components, animations, and design system elements
- **Responsibility:** Display data and capture user input only
- **Constraint:** No business logic or data processing occurs here
- **Privacy Note:** Never stores or caches sensitive financial data

#### 🧭 Navigation & App Flow
- **Purpose:** Controls all screen transitions and application routing
- **Contains:** AppRouter, route definitions, navigation guards
- **Responsibility:** Enforce onboarding completion, authentication status, and setup flows
- **Constraint:** Prevents access to protected screens without proper authorization
- **Privacy Note:** Ensures key generation and backup are completed before accessing financial data

#### 🎯 Feature Domains
- **Purpose:** Modular, isolated features for specific financial tasks
- **Contains:** Budgeting, Investments, Debt Management, Savings, Peer Benchmarking, AI Insights
- **Responsibility:** Feature-specific business logic and state management
- **Constraint:** Features are independent and communicate through shared services only
- **Privacy Note:** Each feature operates on encrypted data, decrypted only when needed

#### 🤖 AI Analysis Engine
- **Purpose:** Analyzes financial habits and generates personalized insights
- **Contains:** Machine learning models, pattern recognition algorithms, prediction engines
- **Responsibility:** Process financial data to produce actionable recommendations
- **Constraint:** Operates exclusively on decrypted data **locally** on the device
- **Privacy Note:** AI never sends raw financial data to external servers; all processing is on-device

#### 🔐 Security & Encryption Layer
- **Purpose:** Manages all encryption, decryption, and key management
- **Contains:** Private key generation, AES-256 encryption, decentralized identity (DID) management
- **Responsibility:** Ensure user-controlled data access and protection
- **Constraint:** User is the sole holder of encryption keys; keys never leave the device
- **Privacy Note:** Implements zero-knowledge architecture—app cannot access data without user authentication

#### 🌐 Decentralized Storage Layer
- **Purpose:** Stores encrypted financial data in a decentralized, immutable manner
- **Contains:** IPFS content-addressed storage, blockchain audit trails, encrypted data blobs
- **Responsibility:** Ensure data persistence, immutability, and user ownership
- **Constraint:** Only encrypted data is stored; plaintext never touches this layer
- **Privacy Note:** User owns their data; can export, migrate, or delete at any time

---

### 🔄 User Interaction Flow

This section illustrates how users interact with Finora across different scenarios, from their first launch to daily usage and advanced privacy controls.

---

#### 🌟 First-Time User Flow

New users experience a carefully designed onboarding journey that prioritizes trust, education, and secure setup.

```
App Launch
    ↓
Splash Screen (Brand Introduction)
    ↓
Premium Onboarding (3 Slides)
  → Slide 1: Finance, Elevated by Intelligence
  → Slide 2: Your Wealth. Your Data. Your Authority.
  → Slide 3: Context That Sharpens Judgment
    ↓
Account Creation
  → Email/Password or Biometric Setup
    ↓
Key Generation & Backup
  → Generate Encryption Keys (DID)
  → Display Recovery Phrase
  → Confirm Backup Completion
    ↓
Financial Profile Setup
  → Income & Expense Baseline
  → Financial Goals
  → Risk Tolerance (for investments)
    ↓
Dashboard (Main App Entry)
  → First AI Insight Generated
  → Quick Actions Highlighted
```

**Key Privacy Moments:**
- Recovery phrase is shown **only once** and must be backed up offline
- User acknowledges they are the **sole custodian** of their encryption keys
- App cannot recover lost keys—emphasizes user sovereignty

---

#### 📊 Daily Usage Flow

Returning users experience a streamlined, insight-driven dashboard as their central hub.

```
Open App
    ↓
Biometric Authentication (Face ID / Touch ID)
    ↓
Dashboard Overview
  → Net Worth Summary
  → Recent Transactions
  → Budget Status (% remaining)
  → AI Insight Highlight (e.g., "You're spending 20% more on dining this month")
    ↓
User Chooses Action:
  → View Budget Details
  → Add New Transaction
  → Review Investment Portfolio
  → Manage Debt Strategy
  → Chat with AI Assistant
  → Compare with Peers (opt-in)
```

**Insight Examples:**
- "You typically spend $80 more on weekends—consider setting a weekend budget."
- "Your emergency fund is below 3 months of expenses. Here's a savings plan."
- "Based on your debt, the Avalanche method will save you $2,400 in interest."

---

#### 💰 Expense & Insight Flow

Every financial transaction flows through a privacy-preserving pipeline from input to insight.

```
User Adds Expense
  → Title, Amount, Category, Date
    ↓
Local Encryption (on-device)
  → AES-256 encryption using user's private key
    ↓
AI Analysis (local processing)
  → Categorization (if manual category not chosen)
  → Pattern Detection (spending trends, anomalies)
  → Budget Impact Calculation
    ↓
Insight Generation
  → AI generates personalized recommendation
  → Explainable reasoning provided
    ↓
Encrypted Storage (decentralized)
  → Encrypted blob stored on IPFS
  → Content hash recorded on blockchain (audit trail)
  → User retains full ownership
```

**Privacy Guarantees:**
- Transaction details encrypted **before** storage
- AI processes data locally—never sent to cloud
- User can audit all data hashes and access logs

---

#### 👥 Peer Benchmarking Flow (Opt-In)

Users who opt into peer benchmarking can anonymously compare their financial health with similar users while preserving privacy.

```
User Opts Into Peer Benchmarking
    ↓
Data Anonymization (local)
  → Income tier identified (e.g., $60k-$80k)
  → Location generalized (e.g., "West Coast")
  → Spending categories aggregated
  → Personal identifiers stripped
    ↓
Aggregated Peer Metrics (privacy-preserving)
  → Federated learning or secure multi-party computation
  → No raw data shared—only statistical summaries
    ↓
Private Comparison Insights
  → "You save 15% more than peers in your income tier."
  → "Your housing costs are 10% below the median for your area."
  → "Users with similar incomes invest 20% more on average."
```

**Privacy Safeguards:**
- Fully **opt-in**—disabled by default
- Anonymized data only; no reverse-identification possible
- User can revoke consent and delete shared aggregates at any time

---

#### 🛡 Data Control & Privacy Flow

Finora provides complete transparency and control over user data—a core differentiator from traditional fintech apps.

```
Settings → Data Control
    ↓
View Stored Data
  → List of encrypted data blobs (by content hash)
  → Blockchain audit trail (who accessed, when)
  → Storage size and IPFS locations
    ↓
Export Encrypted Data
  → Download all encrypted financial data
  → Includes encryption keys (password-protected export)
  → Portable to other apps or backup storage
    ↓
Revoke Access
  → Disable third-party integrations
  → Rotate encryption keys
  → Re-encrypt all data with new keys
    ↓
Permanent Deletion
  → Irreversibly delete encryption keys (data becomes unrecoverable)
  → Remove IPFS content hashes
  → Clear blockchain audit trail references
  → User confirms with biometric authentication
```

**User Sovereignty Principles:**
- User has **full visibility** into what data exists and where
- User can **export everything** at any time (no vendor lock-in)
- User can **permanently delete** all data (right to be forgotten)
- App cannot access data after key deletion—truly user-owned

---

### 📝 Closing Notes

The architecture and flow documented here reflect Finora's commitment to **privacy-first fintech**:

- **Scalability:** Modular feature domains allow independent development and testing
- **Privacy:** Zero-knowledge architecture ensures user data sovereignty
- **Trust:** Transparent AI reasoning and blockchain audit trails build user confidence
- **Incremental Integration:** Core AI and blockchain components will be integrated progressively, starting with placeholders and evolving to full production systems

**Current Focus:**
- Establishing robust structure and navigation flows
- Building trust through clear privacy communication
- Setting architectural foundation for future AI and decentralized integrations

**Long-Term Vision:**
- Fully on-device AI processing for all financial insights
- Complete decentralization via IPFS and blockchain for data ownership
- Industry-leading privacy standards that set a new benchmark for fintech applications

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
