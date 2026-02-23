# PlaceholderUITextView - Detailed Documentation

## 🎛️ Complete Configuration Reference

### Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `placeholder` | `String?` | `nil` | Plain text placeholder |
| `attributedPlaceholder` | `NSAttributedString?` | `nil` | Rich text placeholder (takes precedence) |
| `placeholderTextColor` | `UIColor?` | `.placeholderText` | Placeholder text color |
| `becomeFirstResponderAnimationDuration` | `TimeInterval` | `0.25` | Animation duration for focus |
| `resignFirstResponderAnimationDuration` | `TimeInterval` | `0.25` | Animation duration for unfocus |
| `textContainerLineFragmentPadding` | `CGFloat` | `5.0` | Text container padding |

### Advanced Configuration

```swift
let textView = PlaceholderUITextView()

// Placeholder text
textView.placeholder = "Enter your message here..."
textView.placeholderTextColor = .systemGray

// Attributed placeholder (takes precedence over plain text)
let attributedPlaceholder = NSAttributedString(
    string: "Enter your message here...",
    attributes: [
        .foregroundColor: UIColor.systemGray,
        .font: UIFont.systemFont(ofSize: 16)
    ]
)
textView.attributedPlaceholder = attributedPlaceholder

// Animation configuration
textView.becomeFirstResponderAnimationDuration = 0.3
textView.resignFirstResponderAnimationDuration = 0.2

// Text container configuration  
textView.textContainerLineFragmentPadding = 8
textView.textContainerInset = UIEdgeInsets(top: 16, left: 12, bottom: 16, right: 12)
```

## ♿ Accessibility Features

PlaceholderUITextView is built with accessibility in mind:

- **VoiceOver support**: Placeholder text is announced when the field is empty
- **Dynamic Type**: Supports system font sizing preferences  
- **Voice Control**: Full compatibility with voice navigation
- **Accessibility hints**: Provides context-appropriate hints

### Custom Accessibility Configuration

```swift
// Accessibility is automatically configured, but you can customize:
textView.accessibilityLabel = "Message input"
textView.accessibilityHint = "Enter your message here"
```

## 🎨 Customization Examples

### Removing Default Text Container Spacing

UITextView has default spacing that you might want to eliminate:

```swift
// Remove all default spacing for pixel-perfect alignment
textView.textContainerInset = .zero
textView.textContainerLineFragmentPadding = 0
```

### Creating a Chat Input Field

```swift
let chatTextView = PlaceholderUITextView()
chatTextView.placeholder = "Type a message..."
chatTextView.layer.cornerRadius = 16
chatTextView.layer.borderWidth = 1
chatTextView.layer.borderColor = UIColor.systemGray4.cgColor
chatTextView.textContainerInset = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
chatTextView.isScrollEnabled = false // Auto-expand height
```

### Styled Placeholder

```swift
let attributedText = NSMutableAttributedString(string: "Share your thoughts...")
attributedText.addAttribute(.foregroundColor, value: UIColor.systemBlue, range: NSRange(location: 0, length: 5))
attributedText.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 16), range: NSRange(location: 0, length: 5))
textView.attributedPlaceholder = attributedText
```

### Multi-line Placeholder with Formatting

```swift
let placeholder = NSMutableAttributedString()

// Add title part
let title = NSAttributedString(
    string: "Add your thoughts\n",
    attributes: [
        .font: UIFont.boldSystemFont(ofSize: 16),
        .foregroundColor: UIColor.label
    ]
)
placeholder.append(title)

// Add subtitle part
let subtitle = NSAttributedString(
    string: "Share what's on your mind...",
    attributes: [
        .font: UIFont.systemFont(ofSize: 14),
        .foregroundColor: UIColor.secondaryLabel
    ]
)
placeholder.append(subtitle)

textView.attributedPlaceholder = placeholder
```

## 📐 Understanding UITextView Layout

UITextView has built-in spacing controlled by two properties:

- **`textContainerInset`**: Padding around the text container (default: `{8, 0, 8, 0}`)
- **`lineFragmentPadding`**: Padding around text lines (default: `5`)

![UITextView Structure](https://raw.githubusercontent.com/hoangtaiki/PlaceholderUITextView/master/Images/uitextview-structure.png)

PlaceholderUITextView automatically synchronizes the placeholder position with these values. To achieve pixel-perfect alignment with other UI elements:

```swift
textView.textContainerInset = .zero
textView.textContainerLineFragmentPadding = 0
```

### Layout Tips

#### Perfect Alignment with UITextField
```swift
// Make PlaceholderUITextView align exactly with UITextField
textView.textContainerInset = UIEdgeInsets.zero
textView.textContainerLineFragmentPadding = 0
textView.font = UIFont.systemFont(ofSize: 17) // Standard iOS text size
```

#### Auto-expanding Text View
```swift
textView.isScrollEnabled = false
textView.translatesAutoresizingMaskIntoConstraints = false

// Add height constraint that can grow
let heightConstraint = textView.heightAnchor.constraint(greaterThanOrEqualToConstant: 34)
heightConstraint.priority = UILayoutPriority(999)
heightConstraint.isActive = true
```

## 🧪 Testing Guidelines

PlaceholderUITextView includes comprehensive unit tests covering:

- Placeholder visibility logic
- Text and attributed text handling
- Accessibility compliance
- Layout and constraint management
- Animation behavior
- Performance characteristics

### Running Tests

```bash
# Xcode
⌘ + U

# Command line
swift test

# With coverage
swift test --enable-code-coverage
```

### Writing Custom Tests

```swift
import XCTest
@testable import PlaceholderUITextView

class CustomPlaceholderTests: XCTestCase {
    private var textView: PlaceholderUITextView!
    
    override func setUp() {
        super.setUp()
        textView = PlaceholderUITextView(frame: CGRect(x: 0, y: 0, width: 300, height: 100))
    }
    
    func testCustomBehavior() {
        textView.placeholder = "Test"
        textView.text = ""
        
        // Your custom test logic here
        XCTAssertFalse(textView.subviews.compactMap { $0 as? UILabel }.first?.isHidden ?? true)
    }
}
```

## 🎭 Animation Customization

### Custom Animation Curves

```swift
// Custom become first responder animation
textView.becomeFirstResponderAnimationDuration = 0.5

// Custom animation with completion
UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
    textView.becomeFirstResponder()
} completion: { finished in
    // Animation completed
}
```

### Disabling Animations

```swift
// Disable all animations
textView.becomeFirstResponderAnimationDuration = 0
textView.resignFirstResponderAnimationDuration = 0
```

## 🎨 Dark Mode Support

PlaceholderUITextView automatically supports dark mode through system colors:

```swift
// Colors that adapt to dark mode
textView.placeholderTextColor = .placeholderText  // Recommended
textView.placeholderTextColor = .systemGray       // Alternative
textView.placeholderTextColor = .secondaryLabel   // Subtitle style

// Custom dark mode colors
textView.placeholderTextColor = UIColor { traitCollection in
    return traitCollection.userInterfaceStyle == .dark ? .systemGray4 : .systemGray2
}
```

## 🌐 Localization Support

### RTL Language Support

```swift
// PlaceholderUITextView automatically supports RTL layouts
textView.textAlignment = .natural  // Respects device language direction

// Force LTR or RTL
textView.textAlignment = .left   // Always left-to-right
textView.textAlignment = .right  // Always right-to-left
```

### Localized Placeholders

```swift
// Using localized strings
textView.placeholder = NSLocalizedString("placeholder.message", comment: "Message input placeholder")

// Attributed localized placeholder
let localizedText = NSLocalizedString("placeholder.detailed", comment: "Detailed placeholder")
textView.attributedPlaceholder = NSAttributedString(
    string: localizedText,
    attributes: [.foregroundColor: UIColor.placeholderText]
)
```

## 🔧 Interface Builder Integration

### Setting Up in Storyboard

1. Drag a `UITextView` onto your storyboard
2. Set the **Custom Class** to `PlaceholderUITextView` in the Identity Inspector
3. Configure properties in the Attributes Inspector:
   - **Placeholder**: Set your placeholder text
   - **Placeholder Color**: Choose placeholder color
   - **Become Animation**: Set animation duration
   - **Resign Animation**: Set animation duration

### IBOutlet Connection

```swift
@IBOutlet weak var messageTextView: PlaceholderUITextView!

override func viewDidLoad() {
    super.viewDidLoad()
    
    // Additional configuration
    messageTextView.placeholder = "What's on your mind?"
    messageTextView.layer.cornerRadius = 8
}
```

## 🚀 Performance Optimization

### Memory Management

PlaceholderUITextView is optimized for memory efficiency:

```swift
// Lazy loading of placeholder label
// Automatic cleanup in deinit
// Efficient constraint management

// For high-performance scenarios
textView.becomeFirstResponderAnimationDuration = 0  // Disable animations
textView.resignFirstResponderAnimationDuration = 0
```

### Large Text Handling

```swift
// For handling large amounts of text
textView.layoutManager.allowsNonContiguousLayout = true
textView.isScrollEnabled = true
textView.textContainer.maximumNumberOfLines = 0  // Unlimited lines
```

## 📱 Platform Considerations

### iOS Version Compatibility

- **iOS 12.0+**: Full feature support
- **iOS 13.0+**: Enhanced dark mode and system colors
- **iOS 14.0+**: Additional layout improvements
- **iOS 15.0+**: Latest accessibility features

### Device Support

```swift
// iPad specific configuration
if UIDevice.current.userInterfaceIdiom == .pad {
    textView.textContainerInset = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
    textView.font = UIFont.systemFont(ofSize: 18)
}

// iPhone specific configuration
if UIDevice.current.userInterfaceIdiom == .phone {
    textView.textContainerInset = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
    textView.font = UIFont.systemFont(ofSize: 16)
}
```

## 🎯 Common Use Cases

### 1. Social Media Post Composer

```swift
let postTextView = PlaceholderUITextView()
postTextView.placeholder = "What's happening?"
postTextView.font = UIFont.systemFont(ofSize: 17)
postTextView.textContainerInset = UIEdgeInsets(top: 16, left: 20, bottom: 16, right: 20)
postTextView.layer.cornerRadius = 12
postTextView.backgroundColor = .systemBackground
postTextView.layer.borderWidth = 1
postTextView.layer.borderColor = UIColor.separator.cgColor
```

### 2. Comment Section

```swift
let commentTextView = PlaceholderUITextView()
commentTextView.placeholder = "Add a comment..."
commentTextView.isScrollEnabled = false
commentTextView.font = UIFont.systemFont(ofSize: 15)
commentTextView.textContainerInset = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
```

### 3. Note Taking App

```swift
let noteTextView = PlaceholderUITextView()
noteTextView.attributedPlaceholder = NSAttributedString(
    string: "Start writing your note...",
    attributes: [
        .font: UIFont.systemFont(ofSize: 16),
        .foregroundColor: UIColor.tertiaryLabel
    ]
)
noteTextView.font = UIFont.systemFont(ofSize: 16)
noteTextView.textContainerInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
```

## 🛠️ Troubleshooting

### Common Issues

**Placeholder not showing:**
- Check that `text` property is empty
- Verify `placeholder` or `attributedPlaceholder` is set
- Ensure the view is properly added to the view hierarchy

**Layout issues:**
- Review `textContainerInset` and `textContainerLineFragmentPadding` values
- Check Auto Layout constraints
- Verify font settings match your design

**Animation glitches:**
- Ensure animation durations are reasonable (0.1 - 0.5 seconds)
- Avoid conflicting animations
- Test on device for performance

### Debugging Tips

```swift
// Enable debug logging
#if DEBUG
print("Placeholder visible: \\(!textView.text.isEmpty)")
print("Text container inset: \\(textView.textContainerInset)")
print("Line fragment padding: \\(textView.textContainer.lineFragmentPadding)")
#endif
```

## 📚 Additional Resources

- [Swift API Design Guidelines](https://swift.org/documentation/api-design-guidelines/)
- [iOS Accessibility Programming Guide](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/iPhoneAccessibility/Introduction/Introduction.html)
- [UITextView Documentation](https://developer.apple.com/documentation/uikit/uitextview)
- [Auto Layout Guide](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/)