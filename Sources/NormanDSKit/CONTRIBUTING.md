# Contributing to DSKit

Thank you for considering contributing! ❤️

## How to Contribute

### 1. Fork the repository
Clone your copy locally.

### 2. Create a feature branch
Example:
```
git checkout -b feature/my-component
```

### 3. Make your changes
Follow the existing architecture.

### 4. Run Swift format & lint (if available)

### 5. Submit a pull request
Include:
- Purpose of the change  
- Before/after screenshots for UI components  

---

## Code Style

- Prefer composition over inheritance.
- Follow SwiftUI and Swift evolution guidelines.
- Keep components isolated and testable.
- Avoid UIKit unless absolutely required.

---

## Component Requirements

Every component should include:
- A public API
- Previews for light/dark mode
- Support for DSTheme tokens
- Configurable model (if applicable)
