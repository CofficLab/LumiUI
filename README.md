# LumiUI

<div align="center">

**✨ A polished SwiftUI design system for macOS and iOS applications**

[![Swift](https://img.shields.io/badge/Swift-6.0-orange.svg)](https://swift.org)
[![SwiftUI](https://img.shields.io/badge/SwiftUI-macOS%2014%2B%20%7C%20iOS%2017%2B-blue.svg)](https://developer.apple.com/xcode/swiftui/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

📖 English | [中文](README_zh.md)

[Features](#-features) • [Getting Started](#-getting-started) • [Components](#-components) • [Design System](#-design-system) • [Development](#-development)

</div>

---

LumiUI is a standalone Swift Package containing reusable SwiftUI design tokens, components, charts, themes, and supporting views. It has no dependency on the Lumi application or any local package, so it can be integrated into independent macOS and iOS projects.

## 🌟 Features

### 🎨 A cohesive design system

- Design tokens for colors, typography, spacing, corner radii, materials, shadows, and animation durations
- Light and dark appearance support with adaptive colors
- A consistent glass-inspired visual language
- Customizable themes through `LumiUITheme`
- Motion preferences and accessibility-conscious defaults

## 🧩 Components

### Reusable components

The package provides 30+ ready-to-use SwiftUI components, including:

| Category | Components |
| --- | --- |
| Controls | `AppButton`, `AppIconButton`, `AppCircularIconButton`, `AppInputField`, `AppSearchBar`, `AppSegmentedControl` |
| Identity and labels | `AppAvatar`, `AppTag`, `AppRoleBadge`, `AppSizeLabel`, `GlassBadge` |
| Cards and surfaces | `AppCard`, `GlassInfoCard`, `GlassSelectionCard`, `AppDisclosureCard`, `AppSurface` |
| Lists and settings | `AppListRow`, `AppToggleRow`, `AppSettingRow`, `AppSettingSection`, `AppSidebarRow` |
| Feedback and layout | `AppEmptyState`, `AppErrorBanner`, `AppLoadingOverlay`, `AppDivider`, `AppLabeledDivider`, `AppTooltip` |
| Content and charts | `AppHTTPResponseView`, `AppImagePreviewGrid`, `AppLineChart`, `AppBarChart`, `MessageBubble` |
| Product scaffolding | Settings, onboarding, landing-page, menu-bar, and status-bar building blocks |

## 🚀 Getting Started

### Requirements

- macOS 14 or later
- iOS 17 or later
- Swift 6.0 or later
- Xcode with Swift 6 support

### Add the package in Swift Package Manager

Add LumiUI to your `Package.swift` dependencies:

```swift
dependencies: [
    .package(url: "https://github.com/CofficLab/LumiUI.git", from: "1.0.1")
]
```

Then add `LumiUI` to the target that uses it:

```swift
targets: [
    .target(
        name: "MyApp",
        dependencies: ["LumiUI"]
    )
]
```

In Xcode, you can also choose **File > Add Package Dependencies** and enter the repository URL.

### Basic usage

```swift
import LumiUI
import SwiftUI

struct ContentView: View {
    var body: some View {
        AppCard {
            VStack(alignment: .leading, spacing: DesignTokens.Spacing.md) {
                Text("Hello, LumiUI")
                    .font(DesignTokens.Typography.title1)

                AppButton(
                    "Continue",
                    systemImage: "arrow.right",
                    style: .primary
                ) {
                    // Handle the action
                }
            }
        }
        .padding()
    }
}
```

## 🎭 Design System

### Design tokens

Use the shared tokens to keep spacing and visual hierarchy consistent:

```swift
VStack(spacing: DesignTokens.Spacing.lg) {
    Text("A consistent interface")
        .font(DesignTokens.Typography.headline)
}
```

Available token groups include `Spacing`, `Radius`, `Typography`, `Material`, `Shadow`, and `Duration`. Color tokens adapt to the current color scheme and are available through `ColorTokens`.

### Themes

Use the built-in theme or provide a custom `LumiUITheme` to a view hierarchy:

```swift
struct ThemedView: View {
    @LumiTheme private var theme

    var body: some View {
        Text("Themed content")
            .foregroundStyle(theme.textPrimary)
    }
}
```

`LumiDefaultTheme` is used by default. Themes can be updated with `setTheme(_:)` when an application needs its own visual identity.

### Localization

LumiUI includes its localization resources and runtime support through `LumiUILocalization`. The package can be used independently without the Lumi application's localization package.

## 🗂 Project Structure

```text
Sources/
├── Charts/          # Chart primitives and visualizations
├── Components/      # Reusable SwiftUI components
├── DesignSystem/    # Tokens, colors, materials, and motion
├── Support/         # Localization and package support
└── Theme/           # Theme definitions and environment support
Tests/               # Package tests
Resources/           # Localization resources
```

## 🛠 Development

Clone the repository and run the package checks:

```bash
git clone https://github.com/CofficLab/LumiUI.git
cd LumiUI
swift package dump-package
swift test
```

When adding a component, prefer the existing design tokens and theme environment so new views remain consistent with the rest of the package.

## 🤝 Contributing

Issues and pull requests are welcome. Please keep public APIs documented, add or update tests for behavior changes, and preserve macOS and iOS compatibility where applicable.

## 📄 License

LumiUI is released under the [MIT License](LICENSE).

## 🚀 Projects Using LumiUI

- [Lumi](https://github.com/CofficLab/Lumi) — an AI-powered personal desktop assistant for macOS.
- [GitOK](https://github.com/CofficLab/GitOK) — a macOS project and Git management tool.

## 🔗 Links

- [LumiUI on GitHub](https://github.com/CofficLab/LumiUI)
- [Lumi — the host application](https://github.com/CofficLab/Lumi)

<div align="center">

Made with ❤️ by [CofficLab](https://github.com/CofficLab)

</div>
