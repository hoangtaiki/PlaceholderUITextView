//
//  PlaceholderUITextView.swift
//  PlaceholderUITextView
//
//  Created by Hoangtaiki on 10/3/18.
//  Copyright © 2018 Hoangtaiki. All rights reserved.
//

import UIKit

/// A UITextView subclass that provides built-in placeholder functionality.
///
/// `PlaceholderUITextView` displays a placeholder text when the text view is empty,
/// similar to UITextField's placeholder behavior. The placeholder automatically
/// shows/hides as the user types, with smooth animations and full accessibility support.
///
/// ## Usage
///
/// ```swift
/// let textView = PlaceholderUITextView()
/// textView.placeholder = "Enter your message here..."
/// textView.placeholderTextColor = .systemGray
/// ```
///
/// ## Accessibility
///
/// The component is fully accessible and properly announces placeholder content
/// to VoiceOver users. When empty, the placeholder text serves as the accessibility
/// value to provide context about expected input.
@IBDesignable
open class PlaceholderUITextView: UITextView {
    // MARK: - Public Properties
    
    /// Duration for the animation when the text view becomes first responder.
    ///
    /// - Note: Animation enhances user experience by providing visual feedback.
    /// Set to 0.0 to disable animation.
    @IBInspectable open var becomeFirstResponderAnimationDuration: TimeInterval = 0.25
    
    /// Duration for the animation when the text view resigns first responder.
    ///
    /// - Note: Animation enhances user experience by providing visual feedback.
    /// Set to 0.0 to disable animation.
    @IBInspectable open var resignFirstResponderAnimationDuration: TimeInterval = 0.25
    
    /// The placeholder text displayed when the text view is empty.
    ///
    /// When both `placeholder` and `attributedPlaceholder` are set,
    /// `attributedPlaceholder` takes precedence.
    @IBInspectable open var placeholder: String? {
        didSet {
            updatePlaceholderText()
        }
    }
    
    /// The color of the placeholder text.
    ///
    /// Defaults to `UIColor.placeholderText` for better system integration.
    /// Falls back to `.lightGray` for older iOS versions.
    @IBInspectable open var placeholderTextColor: UIColor? {
        didSet {
            placeholderLabel.textColor = placeholderTextColor
        }
    }
    
    /// The attributed placeholder text displayed when the text view is empty.
    ///
    /// When set, this takes precedence over the plain `placeholder` text.
    /// Useful for complex formatting requirements.
    open var attributedPlaceholder: NSAttributedString? {
        didSet {
            updatePlaceholderText()
        }
    }
    
    /// The padding for text container line fragments.
    ///
    /// This property mirrors `textContainer.lineFragmentPadding` and automatically
    /// updates the placeholder positioning when changed.
    @IBInspectable open var textContainerLineFragmentPadding: CGFloat {
        get {
            textContainer.lineFragmentPadding
        }
        set {
            textContainer.lineFragmentPadding = newValue
            updatePlaceholderConstraints()
        }
    }
    
    // MARK: - Private Properties
    
    /// The label that displays the placeholder text.
    private lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = defaultPlaceholderColor
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = false
        
        // Configure for accessibility
        label.isAccessibilityElement = false
        label.adjustsFontForContentSizeCategory = true
        
        return label
    }()
    
    /// Constraints for the placeholder label positioning
    private var placeholderLabelConstraints: [NSLayoutConstraint] = []
    
    /// Default placeholder color that respects system appearance
    private var defaultPlaceholderColor: UIColor {
        .placeholderText
    }
    
    // MARK: - Overrides
    
    /// The text content of the text view.
    override open var text: String! {
        didSet {
            updatePlaceholderVisibility()
        }
    }
    
    /// The styled text content of the text view.
    override open var attributedText: NSAttributedString! {
        didSet {
            updatePlaceholderVisibility()
        }
    }
    
    /// The font used for text display.
    ///
    /// When set, the placeholder label's font is automatically updated to match.
    override open var font: UIFont! {
        didSet {
            placeholderLabel.font = font
        }
    }
    
    /// The text alignment for both content and placeholder.
    ///
    /// Updates both the text view and placeholder label alignment simultaneously.
    override open var textAlignment: NSTextAlignment {
        didSet {
            placeholderLabel.textAlignment = textAlignment
        }
    }
    
    /// The inset of the text container's layout area within the text view.
    ///
    /// Updates placeholder positioning when changed to maintain proper alignment.
    override open var textContainerInset: UIEdgeInsets {
        didSet {
            updatePlaceholderConstraints()
        }
    }
    
    // MARK: - Accessibility
    
    /// Returns the accessibility value, providing placeholder context when text is empty.
    override open var accessibilityValue: String? {
        get {
            if !text.isEmpty {
                return text
            }
            return placeholder ?? attributedPlaceholder?.string
        }
        set {
            super.accessibilityValue = newValue
        }
    }
    
    /// Returns appropriate accessibility hints based on current state.
    override open var accessibilityHint: String? {
        get {
            if text.isEmpty && (placeholder != nil || attributedPlaceholder != nil) {
                return "Double tap to edit"
            }
            return super.accessibilityHint
        }
        set {
            super.accessibilityHint = newValue
        }
    }
    
    // MARK: - Initialization
    
    /// Creates a new placeholder text view with zero frame.
    public convenience init() {
        self.init(frame: .zero)
    }
    
    /// Creates a new placeholder text view with the specified frame and text container.
    ///
    /// - Parameters:
    ///   - frame: The frame rectangle for the text view.
    ///   - textContainer: The text container for the text view. Pass `nil` to create a default container.
    override public init(frame: CGRect, textContainer: NSTextContainer? = nil) {
        super.init(frame: frame, textContainer: textContainer)
        setupTextView()
    }
    
    /// Creates a new placeholder text view from a storyboard or XIB.
    ///
    /// - Parameter coder: The coder containing the archived data.
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTextView()
    }
    
    /// Clean up notification observers when deallocating.
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - First Responder Management
    
    /// Makes the text view the first responder with optional animation.
    ///
    /// - Returns: `true` if the text view successfully became first responder, `false` otherwise.
    @discardableResult
    override open func becomeFirstResponder() -> Bool {
        guard canBecomeFirstResponder else { 
            return false 
        }
        
        let duration = becomeFirstResponderAnimationDuration
        if duration > 0 {
            UIView.animate(withDuration: duration) {
                super.becomeFirstResponder()
            }
        } else {
            return super.becomeFirstResponder()
        }
        
        return isFirstResponder
    }
    
    /// Resigns first responder status with optional animation.
    ///
    /// - Returns: `true` if the text view successfully resigned first responder, `false` otherwise.
    @discardableResult
    override open func resignFirstResponder() -> Bool {
        guard canResignFirstResponder else { 
            return false 
        }
        
        let duration = resignFirstResponderAnimationDuration
        if duration > 0 {
            UIView.animate(withDuration: duration) {
                super.resignFirstResponder()
            }
        } else {
            return super.resignFirstResponder()
        }
        
        return !isFirstResponder
    }
}
// MARK: - Private Methods

private extension PlaceholderUITextView {
    /// Configures the text view with default settings and sets up the placeholder.
    func setupTextView() {
        // Configure text view properties
        configurateTextViewProperties()
        
        // Setup placeholder label
        setupPlaceholderLabel()
        
        // Setup notifications
        setupNotifications()
        
        // Configure accessibility
        setupAccessibility()
        
        // Initial state update
        updatePlaceholderVisibility()
    }
    
    /// Configures default properties of the text view for optimal behavior.
    func configurateTextViewProperties() {
        isEditable = true
        isSelectable = true
        isScrollEnabled = true
        scrollsToTop = false
        isDirectionalLockEnabled = true
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
        
        // Optimize text rendering
        layoutManager.allowsNonContiguousLayout = false
        
        // Configure scroll indicators with minimal offset
        scrollIndicatorInsets = UIEdgeInsets(
            top: .leastNonzeroMagnitude,
            left: .leastNonzeroMagnitude,
            bottom: .leastNonzeroMagnitude,
            right: .leastNonzeroMagnitude
        )
    }
    
    /// Sets up the placeholder label and its constraints.
    func setupPlaceholderLabel() {
        // Initialize placeholder color
        placeholderLabel.textColor = placeholderTextColor ?? defaultPlaceholderColor
        
        // Sync properties with text view
        placeholderLabel.font = font
        placeholderLabel.textAlignment = textAlignment
        
        // Add to view hierarchy
        addSubview(placeholderLabel)
        
        // Setup constraints
        setupPlaceholderConstraints()
    }
    
    /// Creates and activates constraints for the placeholder label.
    func setupPlaceholderConstraints() {
        // Remove existing constraints if any
        NSLayoutConstraint.deactivate(placeholderLabelConstraints)
        placeholderLabelConstraints.removeAll()
        
        let topConstraint = placeholderLabel.topAnchor.constraint(
            equalTo: topAnchor,
            constant: textContainerInset.top
        )
        
        let leadingConstraint = placeholderLabel.leadingAnchor.constraint(
            equalTo: leadingAnchor,
            constant: textContainerInset.left + textContainer.lineFragmentPadding
        )
        
        let trailingConstraint = placeholderLabel.trailingAnchor.constraint(
            lessThanOrEqualTo: trailingAnchor,
            constant: -(textContainerInset.right + textContainer.lineFragmentPadding)
        )
        
        let bottomConstraint = placeholderLabel.bottomAnchor.constraint(
            lessThanOrEqualTo: bottomAnchor,
            constant: -textContainerInset.bottom
        )
        
        // Priority adjustments for better layout
        bottomConstraint.priority = UILayoutPriority(999)
        
        placeholderLabelConstraints = [
            topConstraint,
            leadingConstraint,
            trailingConstraint,
            bottomConstraint
        ]
        
        NSLayoutConstraint.activate(placeholderLabelConstraints)
    }
    
    /// Updates placeholder label constraints when text container properties change.
    func updatePlaceholderConstraints() {
        guard placeholderLabelConstraints.count >= 4 else {
            setupPlaceholderConstraints()
            return
        }
        
        // Update constraint constants
        placeholderLabelConstraints[0].constant = textContainerInset.top
        placeholderLabelConstraints[1].constant = textContainerInset.left + textContainer.lineFragmentPadding
        placeholderLabelConstraints[2].constant = -(textContainerInset.right + textContainer.lineFragmentPadding)
        placeholderLabelConstraints[3].constant = -textContainerInset.bottom
        
        // Force layout update
        setNeedsLayout()
    }
    
    /// Sets up notification observers for text changes.
    func setupNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(textDidChangeNotification),
            name: UITextView.textDidChangeNotification,
            object: self
        )
    }
    
    /// Configures accessibility properties.
    func setupAccessibility() {
        // Ensure the text view is accessible
        isAccessibilityElement = true
        
        // Dynamic type support
        adjustsFontForContentSizeCategory = true
        placeholderLabel.adjustsFontForContentSizeCategory = true
    }
    
    /// Updates placeholder text based on current placeholder and attributedPlaceholder values.
    func updatePlaceholderText() {
        if let attributedPlaceholder = attributedPlaceholder {
            placeholderLabel.attributedText = attributedPlaceholder
        } else {
            placeholderLabel.text = placeholder
        }
        
        // Update accessibility
        notifyAccessibilityChange()
    }
    
    /// Updates the visibility of the placeholder based on text content.
    func updatePlaceholderVisibility() {
        let shouldShowPlaceholder = text.isEmpty
        
        if placeholderLabel.isHidden == shouldShowPlaceholder {
            // Animate visibility change for better UX
            UIView.animate(withDuration: 0.15, delay: 0, options: [.beginFromCurrentState, .allowUserInteraction]) {
                self.placeholderLabel.isHidden = !shouldShowPlaceholder
            }
        }
        
        // Update accessibility when visibility changes
        if !shouldShowPlaceholder {
            notifyAccessibilityChange()
        }
    }
    
    /// Notifies accessibility system of changes.
    func notifyAccessibilityChange() {
        UIAccessibility.post(notification: .layoutChanged, argument: self)
    }
    
    /// Handles text change notifications.
    @objc 
    func textDidChangeNotification(_ notification: Notification) {
        // Ensure the notification is for this text view
        guard notification.object as? UITextView == self else { 
            return
        }
        updatePlaceholderVisibility()
    }
}
