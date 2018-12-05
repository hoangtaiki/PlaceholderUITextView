# PlaceholderUITextView

[![Platform](http://img.shields.io/badge/platform-ios-blue.svg?style=flat
)](https://developer.apple.com/iphone/index.action)
[![Language](http://img.shields.io/badge/language-swift-brightgreen.svg?style=flat
)](https://developer.apple.com/swift)
[![CI Status](https://img.shields.io/travis/hoangtaiki/PlaceholderUITextView.svg?style=flat)](https://travis-ci.org/hoangtaiki/PlaceholderUITextView)
[![Version](https://img.shields.io/cocoapods/v/PlaceholderUITextView.svg?style=flat)](https://cocoapods.org/pods/PlaceholderUITextView)
[![License](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat
)](http://mit-license.org)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)


`PlaceholderUITextView` is a simple subclass from UITextView with multiple line placeholder

## Requirements
- Xcode 10 or later
- iOS 10.0 or later
- Swift 4.2 or later

## Getting Started

### CocoaPods

Install with [CocoaPods](http://cocoapods.org) by adding the following to your `Podfile`:

```
platform :ios, '10.0'
use_frameworks!
pod 'PlaceholderUITextView'
```

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](https://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate PlaceholderUITextView into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "hoangtaiki/PlaceholderUITextView" ~> 1.1
```

Run `carthage update` to build the framework and drag the built `PlaceholderUITextView.framework` into your Xcode project.


### Swift Package Manager

Install with [Swift Package Manager](https://github.com/apple/swift-package-manager) by adding the following to your `Package.swift`:

```swift
dependencies: [
.package(url: "https://github.com/hoangtaiki/PlaceholderUITextView", from: "1.1.0"),
],
```

### Submodules

Or manually checkout the submodule with `git submodule add git@github.com:hoangtaiki/PlaceholderUITextView.git`, drag PlaceholderUITextView.xcodeproj to your project, and add PlaceholderUITextView as a build dependency.


## Usage

You can set the value of the `placeholder` property just like using UITextField.

### Interface Builder

1. Drag a UITextView object onto the canvas.
2. In the Identity inspector, set the Custom Class name to `PlaceholderUITextView`.
3. In the Attributes inspector, you can change the value of the `placeholder` property directly.

### Code

```swift
let placeholderTextView = PlaceholderUITextView(frame: view.bounds)
placeholderTextView.placeholder = "What's on your mind?"
view.addSubview(placeholderTextView)
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Some notes
If you run Example project you can see UITextView have some gap from four edges (top, right, bottom, left).
This gap is not a feature of PlaceholderUITextView. It is the default features of UITextView.
They are: `textContainerInset` and `lineFragmentPadding`.
![UITextView](https://raw.githubusercontent.com/hoangtaiki/PlaceholderUITextView/master/Images/uitextview-structure.png)

Defaut UITextView has `textContainerInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)` and `lineFragmentPadding = 5`. So that if you run Example Project you can see that: UITextField always  be moved a bit by these two default values. 
To avoid this happening you have two ways:
- Set `textContainerInset by .zero` and `lineFragmentPadding by 0`
- Change constraint between UITextView and superview.

## Author

Hoangtaiki, duchoang.vp@gmail.com

## Contributing

We’re glad you’re interested in Refreshable, and we’d love to see where you take it. If you have suggestions or bug reports, feel free to send pull request or create new issue.

Thanks, and please *do* take it for a joyride!
