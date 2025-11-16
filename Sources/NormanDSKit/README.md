//
//  README.md
//  DSKit
//
//  Created by Norman Sanchez on 16/11/25.
//

# DSKit
### 🍏 A modern Design System for SwiftUI — Liquid Glass Ready, Token-Driven, Modular and Scalable

DSKit is a **fully modular SwiftUI Design System** built for iOS using **Swift 6.2**, designed to offer a cohesive, scalable and elegant UI foundation for modern apps.
It provides:

- 🎨 **Design Tokens** (Colors, Typography, Spacing, Radius, Opacity)
- 🧩 **Reusable Components** (Buttons, Fields, Headers, Carousels, Cards, Dialogs, Toggles, etc.)
- 🧱 **Foundations** based on Apple’s **Human Interface Guidelines / Liquid Glass**
- 🪞 Native support for **Dynamic Color + Dark/Light mode**
- 🎬 Built-in support for **Lottie animations**
- 🧪 Preview-friendly components

---

## 📦 Installation (Swift Package Manager)

Add the package using Swift Package Manager:

1. In Xcode:
   **File → Add Packages…**
2. Use this repository URL:

```
https://github.com/<your-user>/DSKit.git
```

3. Select the latest version (tagged release).
4. Import it:

```swift
import DSKit
```

---

# 🧱 Design System Overview

DSKit is built around **design tokens**—atomic values that keep your interface consistent across all screens.

---

# 🎨 Design Tokens

## 🎨 Colors — `DSColors`

All colors support automatic Light/Dark mode via `DSDynamicColor`.

| Token | Description |
|-------|-------------|
| `primary` | Main brand color |
| `secondary` | Accent or supporting color |
| `tertiary` | Reinforcement color |
| `background` | App background |
| `surface` | Cards, panels |
| `surfaceSecondary` | Secondary surfaces |
| `textTitle` | Title text |
| `textSubtitle` | Subtitle text |
| `textBody` | Body text |
| `textCaption` | Caption/footnote |
| `success` | System success color |
| `warning` | Alerts/warnings |
| `error` | Error/destructive |

**Usage:**

```swift
theme.colors.primary.resolved(colorScheme)
```

---

## 🔠 Typography — `DSTypography`

Consistent typographic scale based on Apple’s HIG.

| Token | Font |
|-------|------|
| `largeTitle` |
| `title` |
| `headline` |
| `subheadline` |
| `body` |
| `caption` |
| `regular` |

Example:

```swift
Text("Hello")
    .font(theme.typography.title.font)
```

---

## 📏 Spacing — `DSSpacing`

Semantic layout spacing values:

| Token | Value |
|-------|--------|
| `xs` | 4 |
| `sm` | 8 |
| `md` | 12 |
| `lg` | 16 |
| `xl` | 24 |
| `xxl` | 32 |

Usage:

```swift
.padding(theme.spacing.lg)
```

---

## 🟦 Radius — `DSRadius`

| Token | Value |
|-------|--------|
| `xs` | 6 |
| `sm` | 12 |
| `md` | 16 |
| `lg` | 24 |
| `pill` | 999 |

Usage:

```swift
.cornerRadius(theme.radius.md)
```

---

## 🌫️ Opacity — `DSOpacity`

Includes Liquid Glass effects:

| Token | Value |
|--------|-------|
| `glassBackground` |
| `subtle` |
| `medium` |
| `strong` |

---

# 🧩 Components

## 🔘 Buttons — `DSButton`

DSKit includes:

- **Primary**
- **Secondary**
- **Tertiary**
- **Destructive**
- **Outline**

Usage:

```swift
DSButton.primary("Continue") {
    // Action
}
```

---

## ✏️ Text Field — `DSField`

Modern field with focus state, border animation, Liquid Glass header.

```swift
DSField(
    text: $username,
    placeholder: DSLabelModel(text: "Email", style: .subtitle)
)
```

---

## 📝 Multiline Field — `DSMultilineField`

```swift
DSMultilineField(
    text: $bio,
    placeholder: DSLabelModel(text: "About you", style: .subtitle)
)
```

---

## 🏷️ Label — `DSLabel`

Supports different styles:

```swift
DSLabel(
    DSLabelModel(text: "Mentorship Program", style: .title)
)
```

---

## 🧭 Header — `DSHeader`

Reusable per-screen header. Supports title, subtitle, actions.

```swift
DSHeader(model: DSHeaderModel(
    title: "Profile",
    subtitle: "Update your information",
    trailingIcon: "gearshape.fill",
    onTrailingTap: { }
))
```

---

## 🖼️ Image Components

### `DSCircularImage`
### `DSRoundedImage`

---

## 🎡 Carousels

### Horizontal

```swift
DSHorizontalCarousel(items: myItems) { item in
    MyCard(item)
}
```

### Vertical

```swift
DSVerticalCarousel(items: items) { item in
    MyRow(item)
}
```

---

## 🗂️ Grids

### `DSGridVertical`
### `DSGridVerticalWithSections`

```swift
DSGridVertical(items: myItems) { item in
    MyGridCell(item)
}
```

---

## 🎤 Dialog — `DSDialog`

Modal-like dialog with image, subtitle, actions.

---

## 🎬 Animations — `DSLottie`

Wrapper for Lottie animations:

```swift
DSLottie(
    animation: "success-check",
    height: 240
)
```

---

# 🛠 Architecture

- Fully SwiftUI-based
- Uses dependency injection via environment keys (`.dsTheme`)
- Zero UIKit dependency except optional video backgrounds
- Supports Liquid Glass using `.ultraThinMaterial`

---

# 🚀 Getting Started Example

```swift
struct ContentView: View {
    @Environment(\.dsTheme) private var theme

    var body: some View {
        VStack(spacing: theme.spacing.lg) {

            DSHeader(model: .init(title: "Welcome"))

            DSField(
                text: .constant(""),
                placeholder: .init(text: "Email")
            )

            DSButton.primary("Continue") { }
        }
        .padding(theme.spacing.lg)
    }
}
```

---

# 🗺 Roadmap

- [ ] DSList component
- [ ] DSCard V2 (multiple sizes)
- [ ] DSTable view
- [ ] DSNavigationBar (Liquid Glass native)
- [ ] Motion animation tokens
- [ ] DSModal / DSDrawer
- [ ] Full Markdown documentation site

---

# 🤝 Contributing

Pull requests are welcome!
For major changes, please open an issue first.

---

# 📄 License

DSKit is released under the **MIT License**.
