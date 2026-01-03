# DSKit (NormanDSKit)

### 🍏 A modern, token-driven Design System for SwiftUI — Liquid Glass–ready, modular, and scalable

DSKit is a fully modular **SwiftUI Design System** built for iOS. It provides a cohesive UI foundation powered by **design tokens**, consistent components, and a clean theming API.

**What you get**
- 🎨 **Design Tokens**: colors, typography, spacing, radius, opacity
- 🧩 **Reusable Components**: buttons, fields, headers, carousels, cards, dialogs, toggles, banners, avatars, etc.
- 🪞 **Dynamic Color**: native Dark/Light support with token resolution
- 📐 **Consistency by default**: semantic spacing/type scales aligned with Apple HIG
- 🎬 **Lottie support**: drop-in animations via a DS wrapper
- 🧪 **Preview-friendly**: components designed for fast SwiftUI iteration

---

## Requirements
- iOS **15.0+**
- Xcode **15+** (recommended)
- Swift **5.9+** (Swift 6 compatible)

---

## 📦 Installation (Swift Package Manager)

1. In Xcode: **File → Add Packages…**
2. Use this repository URL:

```text
https://github.com/normansanchezn/NormanDSKit.git
```

3. Select the latest version.
4. Import it:

```swift
import NormanDSKit
```

---

## 🚀 Quick Start

### 1) Provide a theme
DSKit reads tokens from `DSTheme` through the SwiftUI environment.

```swift
import SwiftUI
import NormanDSKit

@main
struct DemoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                // If your DSKit exposes a default theme factory, use it here.
                // .environment(\.dsTheme, .default)
        }
    }
}
```

> If your app already injects `dsTheme` globally (recommended), you usually won’t need to do anything else.

### 2) Build screens using tokens + components

```swift
import SwiftUI
import NormanDSKit

struct ContentView: View {
    @Environment(\.dsTheme) private var theme

    var body: some View {
        VStack(spacing: theme.spacing.lg) {
            DSScreenHeader(titleScreen: "Welcome")

            DSField(
                text: .constant(""),
                placeholder: .init(text: "Email")
            )

            DSButton.primary("Continue") {}
        }
        .padding(theme.spacing.lg)
    }
}
```

---

## 🧱 Design System Overview

DSKit is built around **design tokens**—atomic values that keep your interface consistent across all screens.

The mental model:
- **Tokens** define the *rules* (color, spacing, type, radius, opacity).
- **Components** implement the *patterns* (buttons, fields, dialogs, banners…).
- **Screens** compose components, rarely raw styles.

---

## 🎨 Design Tokens

Tokens are typically accessed via `@Environment(\.dsTheme)`:

```swift
@Environment(\.dsTheme) private var theme
```

### Colors (`DSColors`)
- Brand palette + semantic colors (background/surface/text/states)
- Automatic light/dark resolution

### Typography (`DSTypography`)
- Consistent type scale aligned with Apple HIG
- Supports Dynamic Type (your DS should map to SwiftUI text styles)

### Spacing (`DSSpacing`)
- Semantic spacing: `xs`, `sm`, `md`, `lg`, `xl`, …

### Radius (`DSRadius`)
- Corner radius scale for consistent rounding

### Opacity (`DSOpacity`)
- Glass/translucency presets for “Liquid Glass” style surfaces

---

## 🧩 Components

> Names below match DSKit conventions used across MentorConnect.

### Buttons
- `DSButton.primary(...)`
- `DSButton.secondary(...)`
- `DSButton.tertiary(...)`
- `DSButton.destructive(...)`

### Text & Labels
- `DSLabel` (typography-driven text)
- `DSScreenHeader` / `DSHeader` (screen titles + subtitles)

### Inputs
- `DSField`
- `DSMultilineField`

### Surfaces & Layout
- `DSBackground` / `DSBackgroundLayer`
- `DSPill`
- Carousels / grids:
  - `DSHorizontalCarousel`, `DSVerticalCarousel`
  - `DSGridVertical`, `DSGridVerticalWithSections`

### Media
- `DSRemoteAvatar`
- `DSCircularImage`, `DSRoundedImage`

### Feedback / Status
- `DSInlineBanner` (info/warning/error states)
- `Loading` / `EmptyState` helpers (project-specific or DS-level depending on your setup)

### Dialogs
- `DSDialog` (modal dialog with image, title/subtitle, actions)

### Animations
- `DSLottie` (Lottie wrapper)

---

## 🪞 Dark/Light Mode & Dynamic Color

DSKit components should avoid hardcoded colors.

Preferred pattern:
- Pull semantic colors from `theme.colors.*`
- Resolve against the current color scheme when needed

```swift
@Environment(\.colorScheme) private var scheme
@Environment(\.dsTheme) private var theme

let color = theme.colors.background.resolved(scheme)
```

---

## 🎬 Lottie

DSKit provides a wrapper component (`DSLottie`) to keep animation usage consistent.

Typical expectations:
- Animations are bundled in the package or app resources
- Views expose a small, predictable API (name, loop mode, size)

(Implementation details depend on your DSKit module setup.)

---

## 🧪 Previews

DSKit is designed to make previews fast and consistent.

Suggested approach:
- Maintain a small set of preview helpers (e.g. `PreviewThemeProvider`)
- Always preview in Light + Dark

```swift
#Preview("Button — Light") {
    DSButton.primary("Continue") {}
}

#Preview("Button — Dark") {
    DSButton.primary("Continue") {}
        .preferredColorScheme(.dark)
}
```

---

## ♿️ Accessibility

Design systems succeed when accessibility is built-in.

Guidelines:
- Prefer semantic text styles so Dynamic Type scales correctly
- Provide `accessibilityLabel`/`accessibilityHint` in interactive components
- Ensure focus order makes sense (especially dialogs)
- Maintain sufficient contrast in token palettes

---

## 🌍 Localization (i18n)

DSKit should be **string-agnostic**:
- Components should accept text as input (String / LocalizedStringKey)
- App strings should live in the app/module string catalogs (`Localizable.xcstrings`)

---

## 🗺 Roadmap
- DSList
- DSModal
- DSNavigationBar
- DSCard V2
- Documentation site

---

## 🤝 Contributing

Pull requests are welcome.

Suggested PR expectations:
- No hardcoded colors: use tokens
- No UI strings embedded in DS components
- Previews for new components
- Accessibility: labels + Dynamic Type

---

## 📄 License
DSKit is released under the **MIT License**.

