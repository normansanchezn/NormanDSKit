# DSKit  
### 🍏 A modern Design System for SwiftUI — Liquid Glass Ready, Token-Driven, Modular and Scalable

DSKit is a fully modular SwiftUI Design System built for iOS using Swift 6.2, designed to offer a cohesive, scalable and elegant UI foundation for modern apps.
It provides:

- 🎨 Design Tokens (Colors, Typography, Spacing, Radius, Opacity)
- 🧩 Reusable Components (Buttons, Fields, Headers, Carousels, Cards, Dialogs, Toggles, etc.)
- 🧱 Foundations based on Apple’s Human Interface Guidelines / Liquid Glass
- 🪞 Native support for Dynamic Color + Dark/Light mode
- 🎬 Built-in support for Lottie animations
- 🧪 Preview-friendly components

---

## 📦 Installation (Swift Package Manager)

Add the package using Swift Package Manager:

1. In Xcode:
   File → Add Packages…
2. Use this repository URL:

```
https://github.com/normansanchezn/NormanDSKit.git
```

3. Select the latest version.
4. Import it:

```swift
import NormanDSKit
```

---

## 🧱 Design System Overview

DSKit is built around design tokens—atomic values that keep your interface consistent across all screens.

---

## 🎨 Design Tokens

### DSColors
A complete brand color palette with automatic dark/light resolution.

### DSTypography
A consistent typographic scale based on Apple HIG.

### DSSpacing
Semantic spacing tokens (xs, sm, md, etc.)

### DSRadius
Corner radius scale.

### DSOpacity
Glass effects & subtle UI transparencies.

---

## 🧩 Components

### DSButton
Primary, Secondary, Tertiary, Outline, Destructive.

### DSField
Modern text field with focus animations.

### DSMultilineField
A multiline field for long content.

### DSLabel
Typography-driven text component.

### DSHeader
Reusable page header.

### Images
DSCircularImage  
DSRoundedImage

### Layouts
DSHorizontalCarousel  
DSVerticalCarousel  
DSGridVertical  
DSGridVerticalWithSections

### Dialogs
DSDialog

### Animations
DSLottie

---

## 🚀 Getting Started Example

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

            DSButton.primary("Continue") {}
        }
        .padding(theme.spacing.lg)
    }
}
```

---

## 🗺 Roadmap

- DSList
- DSModal
- DSNavigationBar
- DSCard V2
- Documentation site

---

## 🤝 Contributing

Pull requests are welcome!
For major changes, open an issue first.

---

## 📄 License
DSKit is released under the MIT License.
