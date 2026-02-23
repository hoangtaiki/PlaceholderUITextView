# Contributing to PlaceholderUITextView

We love your input! We want to make contributing to PlaceholderUITextView as easy and transparent as possible, whether it's:

- Reporting a bug
- Discussing the current state of the code
- Submitting a fix
- Proposing new features
- Becoming a maintainer

## Development Process

We use GitHub to host code, to track issues and feature requests, as well as accept pull requests.

1. Fork the repo and create your branch from `main`.
2. If you've added code that should be tested, add tests.
3. If you've changed APIs, update the documentation.
4. Ensure the test suite passes.
5. Make sure your code lints with SwiftLint.
6. Issue that pull request!

## Development Setup

### Prerequisites

- Xcode 13.0 or later
- iOS 15.0+ deployment target
- Swift 5.0+
- SwiftLint (install via `brew install swiftlint`)

### Getting Started

1. **Fork and Clone**
   ```bash
   git clone https://github.com/yourusername/PlaceholderUITextView.git
   cd PlaceholderUITextView
   ```

2. **Open the Project**
   ```bash
   open PlaceholderUITextView.xcodeproj
   ```

3. **Install Dependencies** (for example project)
   ```bash
   cd Example
   pod install
   open "iOS Example.xcworkspace"
   ```

4. **Run Tests**
   - Press `⌘ + U` in Xcode
   - Or run from command line: `swift test`

5. **Run SwiftLint**
   ```bash
   swiftlint
   ```

## Code Style

We use SwiftLint to maintain consistent code style. The linting rules are defined in `.swiftlint.yml`.

### Key Guidelines

- Follow Swift API Design Guidelines
- Use meaningful variable and function names
- Add comprehensive documentation for public APIs
- Maintain test coverage for new features
- Use `// MARK:` comments to organize code sections

### Documentation

- All public APIs must have Swift documentation comments
- Use `///` for documentation comments
- Include parameter descriptions and return values
- Provide usage examples for complex APIs

Example:
```swift
/// Creates a new placeholder text view with the specified frame and text container.
///
/// - Parameters:
///   - frame: The frame rectangle for the text view.
///   - textContainer: The text container for the text view. Pass `nil` to create a default container.
/// - Returns: A configured placeholder text view ready for use.
public func createPlaceholderTextView(frame: CGRect, textContainer: NSTextContainer? = nil) -> PlaceholderUITextView {
    // Implementation
}
```

## Pull Request Process

1. **Create a Feature Branch**
   ```bash
   git checkout -b feature/amazing-new-feature
   ```

2. **Make Your Changes**
   - Write clean, documented code
   - Add tests for new functionality
   - Update README if needed

3. **Test Your Changes**
   ```bash
   # Run all tests
   swift test
   
   # Run SwiftLint
   swiftlint
   
   # Test example project
   cd Example && pod install
   # Build and run in Xcode
   ```

4. **Commit Your Changes**
   ```bash
   git add .
   git commit -m "Add amazing new feature"
   ```

5. **Push and Create PR**
   ```bash
   git push origin feature/amazing-new-feature
   ```

   Then create a pull request through GitHub's interface.

### PR Requirements

- [ ] All tests pass
- [ ] SwiftLint passes with no warnings
- [ ] New features have corresponding tests
- [ ] Public APIs are documented
- [ ] Example project builds and runs (if applicable)
- [ ] README updated (if needed)

## Testing Guidelines

### Unit Tests

- Test all public APIs
- Test edge cases and error conditions
- Use descriptive test names
- Group related tests using `// MARK:`
- Aim for high code coverage

Example test structure:
```swift
class PlaceholderUITextViewTests: XCTestCase {
    
    private var textView: PlaceholderUITextView!
    
    override func setUp() {
        super.setUp()
        textView = PlaceholderUITextView()
    }
    
    // MARK: - Initialization Tests
    
    func testInitialization() {
        XCTAssertNotNil(textView)
    }
    
    // MARK: - Placeholder Tests
    
    func testPlaceholderVisibility() {
        // Test implementation
    }
}
```

### Performance Tests

For performance-critical code, include performance tests:

```swift
func testPlaceholderUpdatePerformance() {
    measure {
        // Code to measure
    }
}
```

## Issue Reporting

### Bug Reports

When filing a bug report, please include:

1. **Environment**
   - iOS version
   - Xcode version
   - PlaceholderUITextView version

2. **Steps to Reproduce**
   - Detailed steps to reproduce the issue
   - Expected vs. actual behavior

3. **Code Example**
   - Minimal code example demonstrating the issue
   - Screenshots or GIFs if applicable

4. **Additional Context**
   - Stack traces, console logs
   - Any workarounds you've found

### Feature Requests

For feature requests, please:

1. **Describe the Problem**
   - What problem does this solve?
   - Why is this important?

2. **Proposed Solution**
   - How should this feature work?
   - API design suggestions

3. **Alternatives**
   - What alternatives have you considered?
   - Why is your solution better?

## Code of Conduct

### Our Pledge

We pledge to make participation in our project a harassment-free experience for everyone, regardless of age, body size, disability, ethnicity, gender identity and expression, level of experience, education, socio-economic status, nationality, personal appearance, race, religion, or sexual identity and orientation.

### Our Standards

Examples of behavior that contributes to creating a positive environment include:

- Using welcoming and inclusive language
- Being respectful of differing viewpoints and experiences
- Gracefully accepting constructive criticism
- Focusing on what is best for the community
- Showing empathy towards other community members

### Enforcement

Project maintainers are responsible for clarifying the standards of acceptable behavior and are expected to take appropriate and fair corrective action in response to any instances of unacceptable behavior.

## Recognition

Contributors who make significant improvements will be recognized in:
- README acknowledgments
- Release notes
- Twitter shoutouts (if desired)

## Questions?

Don't hesitate to reach out if you have questions:

- Open an issue for technical questions
- Contact maintainers directly for sensitive topics
- Join discussions in existing issues

Thank you for contributing! 🎉