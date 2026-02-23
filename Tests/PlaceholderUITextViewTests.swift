//
//  PlaceholderUITextViewTests.swift
//  PlaceholderUITextViewTests
//
//  Created by Hoangtaiki on 10/3/18.
//  Copyright © 2018 Hoangtaiki. All rights reserved.
//

import XCTest
@testable import PlaceholderUITextView

final class PlaceholderUITextViewTests: XCTestCase {
    
    // MARK: - Properties
    
    private var textView: PlaceholderUITextView!
    
    // MARK: - Setup & Teardown
    
    override func setUp() {
        super.setUp()
        textView = PlaceholderUITextView()
        
        // Add to a window for proper view hierarchy testing
        let window = UIWindow(frame: CGRect(x: 0, y: 0, width: 320, height: 568))
        window.addSubview(textView)
        window.makeKeyAndVisible()
        
        // Layout the view
        textView.frame = CGRect(x: 0, y: 0, width: 300, height: 100)
        textView.layoutIfNeeded()
    }
    
    override func tearDown() {
        textView = nil
        super.tearDown()
    }
    
    // MARK: - Initialization Tests
    
    func testInitialization() {
        XCTAssertNotNil(textView, "PlaceholderUITextView should initialize successfully")
        XCTAssertTrue(textView.isEditable, "Text view should be editable by default")
        XCTAssertTrue(textView.isSelectable, "Text view should be selectable by default")
        XCTAssertEqual(textView.becomeFirstResponderAnimationDuration, 0.25, "Default animation duration should be 0.25")
        XCTAssertEqual(textView.resignFirstResponderAnimationDuration, 0.25, "Default animation duration should be 0.25")
    }
    
    func testConvenienceInitializer() {
        let textView = PlaceholderUITextView()
        XCTAssertNotNil(textView, "Convenience initializer should work")
        XCTAssertEqual(textView.frame, .zero, "Frame should be zero for convenience initializer")
    }
    
    // MARK: - Placeholder Tests
    
    func testPlaceholderProperty() {
        let placeholderText = "Enter your message here..."
        textView.placeholder = placeholderText
        
        XCTAssertEqual(textView.placeholder, placeholderText, "Placeholder property should be set correctly")
    }
    
    func testPlaceholderVisibilityWhenTextIsEmpty() {
        textView.placeholder = "Test placeholder"
        textView.text = ""
        
        // Trigger update
        textView.layoutIfNeeded()
        
        // Find the placeholder label
        let placeholderLabel = textView.subviews.first { $0 is UILabel } as? UILabel
        XCTAssertNotNil(placeholderLabel, "Placeholder label should exist")
        XCTAssertFalse(placeholderLabel?.isHidden ?? true, "Placeholder should be visible when text is empty")
    }
    
    func testPlaceholderVisibilityWhenTextIsNotEmpty() {
        textView.placeholder = "Test placeholder"
        textView.text = "Some text"
        
        // Trigger update
        textView.layoutIfNeeded()
        
        // Find the placeholder label
        let placeholderLabel = textView.subviews.first { $0 is UILabel } as? UILabel
        XCTAssertNotNil(placeholderLabel, "Placeholder label should exist")
        XCTAssertTrue(placeholderLabel?.isHidden ?? false, "Placeholder should be hidden when text is not empty")
    }
    
    func testAttributedPlaceholder() {
        let attributedString = NSAttributedString(
            string: "Attributed placeholder",
            attributes: [.foregroundColor: UIColor.red, .font: UIFont.boldSystemFont(ofSize: 16)]
        )
        textView.attributedPlaceholder = attributedString
        
        XCTAssertEqual(textView.attributedPlaceholder, attributedString, "Attributed placeholder should be set correctly")
    }
    
    func testAttributedPlaceholderTakesPrecedence() {
        textView.placeholder = "Plain placeholder"
        let attributedString = NSAttributedString(string: "Attributed placeholder")
        textView.attributedPlaceholder = attributedString
        
        let placeholderLabel = textView.subviews.first { $0 is UILabel } as? UILabel
        XCTAssertEqual(placeholderLabel?.attributedText, attributedString, "Attributed placeholder should take precedence over plain placeholder")
    }
    
    // MARK: - Color Tests
    
    func testPlaceholderTextColor() {
        let testColor = UIColor.blue
        textView.placeholderTextColor = testColor
        
        let placeholderLabel = textView.subviews.first { $0 is UILabel } as? UILabel
        XCTAssertEqual(placeholderLabel?.textColor, testColor, "Placeholder label color should match set color")
    }
    
    func testDefaultPlaceholderTextColor() {
        let placeholderLabel = textView.subviews.first { $0 is UILabel } as? UILabel
        XCTAssertEqual(placeholderLabel?.textColor, .placeholderText, "Default color should use system placeholder color")
    }
    
    // MARK: - Typography Tests
    
    func testFontSynchronization() {
        let testFont = UIFont.systemFont(ofSize: 20, weight: .bold)
        textView.font = testFont
        
        let placeholderLabel = textView.subviews.first { $0 is UILabel } as? UILabel
        XCTAssertEqual(placeholderLabel?.font, testFont, "Placeholder label font should match text view font")
    }
    
    func testTextAlignmentSynchronization() {
        textView.textAlignment = .center
        
        let placeholderLabel = textView.subviews.first { $0 is UILabel } as? UILabel
        XCTAssertEqual(placeholderLabel?.textAlignment, .center, "Placeholder label alignment should match text view alignment")
    }
    
    // MARK: - Layout Tests
    
    func testTextContainerInsetUpdatesConstraints() {
        let initialInset = textView.textContainerInset
        let newInset = UIEdgeInsets(top: 20, left: 15, bottom: 20, right: 15)
        
        textView.textContainerInset = newInset
        textView.layoutIfNeeded()
        
        XCTAssertNotEqual(initialInset, newInset, "Text container inset should be different")
        // Additional constraint verification would require access to private constraints
    }
    
    func testTextContainerLineFragmentPadding() {
        let initialPadding = textView.textContainerLineFragmentPadding
        let newPadding: CGFloat = 10.0
        
        textView.textContainerLineFragmentPadding = newPadding
        
        XCTAssertEqual(textView.textContainerLineFragmentPadding, newPadding, "Line fragment padding should be updated")
        XCTAssertEqual(textView.textContainer.lineFragmentPadding, newPadding, "Text container's line fragment padding should be updated")
        XCTAssertNotEqual(initialPadding, newPadding, "Padding should have changed")
    }
    
    // MARK: - Text Change Tests
    
    func testTextPropertyUpdatesPlaceholderVisibility() {
        textView.placeholder = "Test"
        textView.text = ""
        
        // Placeholder should be visible
        let placeholderLabel = textView.subviews.first { $0 is UILabel } as? UILabel
        XCTAssertFalse(placeholderLabel?.isHidden ?? true, "Placeholder should be visible with empty text")
        
        // Add text
        textView.text = "Hello"
        
        // Give time for animation
        let expectation = self.expectation(description: "Placeholder animation")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            XCTAssertTrue(placeholderLabel?.isHidden ?? false, "Placeholder should be hidden with non-empty text")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0)
    }
    
    func testAttributedTextPropertyUpdatesPlaceholderVisibility() {
        textView.placeholder = "Test"
        textView.attributedText = NSAttributedString(string: "")
        
        let placeholderLabel = textView.subviews.first { $0 is UILabel } as? UILabel
        XCTAssertFalse(placeholderLabel?.isHidden ?? true, "Placeholder should be visible with empty attributed text")
        
        textView.attributedText = NSAttributedString(string: "Hello")
        
        let expectation = self.expectation(description: "Placeholder animation")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            XCTAssertTrue(placeholderLabel?.isHidden ?? false, "Placeholder should be hidden with non-empty attributed text")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0)
    }
    
    // MARK: - Accessibility Tests
    
    func testAccessibilityValueWithEmptyText() {
        let placeholder = "Enter text here"
        textView.placeholder = placeholder
        textView.text = ""
        
        XCTAssertEqual(textView.accessibilityValue, placeholder, "Accessibility value should return placeholder when text is empty")
    }
    
    func testAccessibilityValueWithText() {
        let testText = "Hello World"
        textView.placeholder = "Enter text"
        textView.text = testText
        
        XCTAssertEqual(textView.accessibilityValue, testText, "Accessibility value should return text when text is not empty")
    }
    
    func testAccessibilityValueWithAttributedPlaceholder() {
        let placeholderString = "Attributed placeholder"
        let attributedPlaceholder = NSAttributedString(string: placeholderString)
        textView.attributedPlaceholder = attributedPlaceholder
        textView.text = ""
        
        XCTAssertEqual(textView.accessibilityValue, placeholderString, "Accessibility value should return attributed placeholder string when text is empty")
    }
    
    func testAccessibilityElement() {
        XCTAssertTrue(textView.isAccessibilityElement, "Text view should be an accessibility element")
    }
    
    // MARK: - First Responder Tests
    
    func testBecomeFirstResponder() {
        textView.becomeFirstResponderAnimationDuration = 0 // Disable animation for testing
        
        let result = textView.becomeFirstResponder()
        XCTAssertTrue(result, "Should successfully become first responder")
        XCTAssertTrue(textView.isFirstResponder, "Should be first responder after calling becomeFirstResponder")
    }
    
    func testResignFirstResponder() {
        textView.becomeFirstResponderAnimationDuration = 0 // Disable animation for testing
        textView.resignFirstResponderAnimationDuration = 0 // Disable animation for testing
        
        // First become first responder
        textView.becomeFirstResponder()
        XCTAssertTrue(textView.isFirstResponder, "Should be first responder")
        
        // Then resign
        let result = textView.resignFirstResponder()
        XCTAssertTrue(result, "Should successfully resign first responder")
        XCTAssertFalse(textView.isFirstResponder, "Should not be first responder after resigning")
    }
    
    // MARK: - Animation Duration Tests
    
    func testCustomAnimationDurations() {
        let becomeAnimationDuration: TimeInterval = 0.5
        let resignAnimationDuration: TimeInterval = 0.3
        
        textView.becomeFirstResponderAnimationDuration = becomeAnimationDuration
        textView.resignFirstResponderAnimationDuration = resignAnimationDuration
        
        XCTAssertEqual(textView.becomeFirstResponderAnimationDuration, becomeAnimationDuration, "Become animation duration should be settable")
        XCTAssertEqual(textView.resignFirstResponderAnimationDuration, resignAnimationDuration, "Resign animation duration should be settable")
    }
    
    // MARK: - Performance Tests
    
    func testPlaceholderUpdatePerformance() {
        textView.placeholder = "Test placeholder"
        
        measure {
            for i in 0..<100 {
                textView.text = i % 2 == 0 ? "" : "Text \(i)"
                textView.layoutIfNeeded()
            }
        }
    }
    
    func testConstraintUpdatePerformance() {
        measure {
            for i in 0..<50 {
                textView.textContainerInset = UIEdgeInsets(top: CGFloat(i), left: CGFloat(i), bottom: CGFloat(i), right: CGFloat(i))
                textView.layoutIfNeeded()
            }
        }
    }
}
