# PlaceholderUITextView

[![Platform](https://img.shields.io/badge/platform-ios-blue.svg?style=flat)](https://developer.apple.com/iphone/index.action)
[![Language](https://img.shields.io/badge/language-swift-brightgreen.svg?style=flat)](https://developer.apple.com/swift)
[![Swift Version](https://img.shields.io/badge/swift-5.0+-orange.svg?style=flat)](https://swift.org)
[![iOS Version](https://img.shields.io/badge/iOS-15.0+-blue.svg?style=flat)](https://developer.apple.com/ios/)
[![CI Status](https://github.com/hoangtaiki/PlaceholderUITextView/workflows/CI/badge.svg)](https://github.com/hoangtaiki/PlaceholderUITextView/actions)
[![Version](https://img.shields.io/cocoapods/v/PlaceholderUITextView.svg?style=flat)](https://cocoapods.org/pods/PlaceholderUITextView)
[![License](https://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat)](http://mit-license.org)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![SPM compatible](https://img.shields.io/badge/SPM-compatible-brightgreen.svg?style=flat)](https://swift.org/package-manager/)

A drop-in replacement for `UITextView` with native placeholder support and accessibility features.

![PlaceholderUITextView Demo](https://raw.githubusercontent.com/hoangtaiki/PlaceholderUITextView/master/Images/demo.gif)

## ✨ Features

- 🎯 Native placeholder support like UITextField
- 🎨 Rich text placeholders with NSAttributedString
- ♿ Full accessibility and VoiceOver support
- 🎭 Smooth animations and modern Swift API
- 📱 iOS 15+ with Interface Builder support

## 🚀 Quick Start

```swift
import PlaceholderUITextView

let textView = PlaceholderUITextView()
textView.placeholder = "What's on your mind?"
textView.placeholderTextColor = .systemGray
```

## 📦 Installation

### Swift Package Manager
```swift
dependencies: [
    .package(url: "https://github.com/hoangtaiki/PlaceholderUITextView.git", from: "2.0.0")
]
```

### CocoaPods
```ruby
pod 'PlaceholderUITextView', '~> 2.0'
```

### Carthage
```ogdl
github "hoangtaiki/PlaceholderUITextView" ~> 2.0
```

## 📚 Documentation

- **[Complete Documentation](DOCUMENTATION.md)** - Advanced configuration, examples, and customization
- **[Contributing Guide](CONTRIBUTING.md)** - Development setup and contribution guidelines
- **[Best Practices Summary](BEST_PRACTICES_SUMMARY.md)** - Implementation details and improvements

## 📄 License

MIT License. See [LICENSE](LICENSE) for details.

## 🙏 Author

**Hoangtaiki** - [duchoang.vp@gmail.com](mailto:duchoang.vp@gmail.com)

---

**Questions?** Open an [issue](https://github.com/hoangtaiki/PlaceholderUITextView/issues) or check our [documentation](DOCUMENTATION.md)!
