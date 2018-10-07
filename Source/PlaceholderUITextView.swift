//
//  PlaceholderUITextView.swift
//  PlaceholderUITextView
//
//  Created by Hoangtaiki on 10/3/18.
//  Copyright © 2018 Hoangtaiki. All rights reserved.
//

import UIKit

@IBDesignable
open class PlaceholderUITextView: UITextView {
    
    // MARK: - Properties
    public var resignFirstResponderTimeAnimate: TimeInterval = 0.25
    public var becomeFirstResponderTimeAnimate: TimeInterval = 0.25
    
    /// A UILabel that holds the InputTextView's placeholder text
    open var placeholderLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .lightGray
        label.text = "Aa"
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /// The placeholder text that appears when there is no text
    @IBInspectable open var placeholder: String? = "Aa" {
        didSet {
            if attributedPlaceholder == nil {
                placeholderLabel.text = placeholder
            }
        }
    }
    
    /// The placeholderLabel's textColor
    @IBInspectable open var placeholderTextColor: UIColor? = .lightGray {
        didSet {
            placeholderLabel.textColor = placeholderTextColor
        }
    }
    
    /// The attributed placeholder
    open var attributedPlaceholder: NSAttributedString? {
        didSet {
            placeholderLabel.attributedText = attributedPlaceholder
        }
    }
    
    /// The text of the UITextView.
    override open var text: String! {
        didSet {
            textDidChange()
        }
    }
    
    /// The attributed text of the UITextView.
    open override var attributedText: NSAttributedString! {
        didSet {
            textDidChange()
        }
    }

    /// The font of the UITextView. When set the placeholderLabel's font is also updated
    open override var font: UIFont! {
        didSet {
            placeholderLabel.font = font
        }
    }
    
    /// The textAlignment of the InputTextView. When set the placeholderLabel's textAlignment is also updated
    open override var textAlignment: NSTextAlignment {
        didSet {
            placeholderLabel.textAlignment = textAlignment
        }
    }
    
    /// The Text Container Inset.  When update textContainerInset we will update placholer constaints
    override open var textContainerInset: UIEdgeInsets {
        didSet {
            updatePlaceholderLabelConstraints()
        }
    }
    
    open var textContainerLineFragmentPadding: CGFloat = 5 {
        didSet {
            textContainer.lineFragmentPadding = textContainerLineFragmentPadding
            updatePlaceholderLabelConstraints()
        }
    }

    /// The constraints of the placeholderLabel
    private var placeholderLabelTopConstraint: NSLayoutConstraint!
    private var placeholderLabelBottomConstraint: NSLayoutConstraint!
    private var placeholderLabelLeadingConstraint: NSLayoutConstraint!
    private var placeholderLabelTrailingConstraint: NSLayoutConstraint!
    private var placeholderLabelWidthConstraint: NSLayoutConstraint!

    public convenience init() {
        self.init(frame: .zero)
    }
    
    public override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    open override func becomeFirstResponder() -> Bool {
        if !canBecomeFirstResponder { return false }
        
        UIView.animate(withDuration: becomeFirstResponderTimeAnimate, animations: {
            super.becomeFirstResponder()
        })
        
        return true
    }
    
    // Override resignFirstResponder to set animation duration to zero
    open override func resignFirstResponder() -> Bool {
        if !canResignFirstResponder { return false }
        
        UIView.animate(withDuration: resignFirstResponderTimeAnimate, animations: {
            super.resignFirstResponder()
        })
        
        return true
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UITextView.textDidChangeNotification, object: nil)
    }
}

extension PlaceholderUITextView {
    
    /// Sets up the default properties
    fileprivate func setup() {
        isEditable = true
        isSelectable = true
        isScrollEnabled = true
        scrollsToTop = false
        isDirectionalLockEnabled = true
        backgroundColor = .clear
        layoutManager.allowsNonContiguousLayout = false
        translatesAutoresizingMaskIntoConstraints = false
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(textDidChange),
                                               name: UITextView.textDidChangeNotification,
                                               object: nil)
        
        scrollIndicatorInsets = UIEdgeInsets(top: .leastNonzeroMagnitude,
                                             left: .leastNonzeroMagnitude,
                                             bottom: .leastNonzeroMagnitude,
                                             right: .leastNonzeroMagnitude)
        
        placeholderLabel.font = font
        placeholderLabel.textColor = placeholderTextColor
        placeholderLabel.textAlignment = textAlignment
        placeholderLabel.text = placeholder
        placeholderLabel.numberOfLines = 0
        addSubview(placeholderLabel)
        setPlaceholderLabelConstraints()
    }
    
    /// Set up constraints for placeholderLabel
    private func setPlaceholderLabelConstraints() {
        placeholderLabelTopConstraint = placeholderLabel.topAnchor
            .constraint(equalTo: topAnchor, constant: textContainerInset.top)
        placeholderLabelBottomConstraint = placeholderLabel.bottomAnchor
            .constraint(equalTo: bottomAnchor, constant: -textContainerInset.bottom)
        placeholderLabelLeadingConstraint = placeholderLabel.leadingAnchor
            .constraint(equalTo: leadingAnchor, constant: textContainerInset.left + textContainer.lineFragmentPadding)
        placeholderLabelTrailingConstraint = placeholderLabel.trailingAnchor
            .constraint(equalTo: trailingAnchor, constant: -(textContainerInset.right + textContainer.lineFragmentPadding))
        
        placeholderLabelWidthConstraint = placeholderLabel.widthAnchor
            .constraint(equalTo: widthAnchor, multiplier: 1.0,
                        constant: -(textContainerInset.left + textContainerInset.right + textContainer.lineFragmentPadding * 2))
        
        placeholderLabelTopConstraint.isActive = true
        placeholderLabelBottomConstraint.isActive = true
        placeholderLabelLeadingConstraint.isActive = true
        placeholderLabelTrailingConstraint.isActive = true
        placeholderLabelWidthConstraint.isActive = true
    }
    
    /// Updates the placeholderLabel constraints constants to match the textContainerInset and textContainer
    private func updatePlaceholderLabelConstraints() {
        placeholderLabelTopConstraint.constant = textContainerInset.top
        placeholderLabelBottomConstraint.constant = -textContainerInset.bottom
        placeholderLabelLeadingConstraint.constant = textContainerInset.left + textContainer.lineFragmentPadding
        placeholderLabelTrailingConstraint.constant = -(textContainerInset.right + textContainer.lineFragmentPadding)
        placeholderLabelWidthConstraint.constant = -(textContainerInset.left + textContainerInset.right + textContainer.lineFragmentPadding * 2)
    }
    
    @objc private func textDidChange() {
        placeholderLabel.isHidden = !text.isEmpty
    }
    
}
