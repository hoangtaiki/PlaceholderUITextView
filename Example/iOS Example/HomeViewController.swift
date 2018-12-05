//
//  HomeViewController.swift
//  iOS Example
//
//  Created by Hoangtaiki on 12/5/18.
//  Copyright © 2018 Hoangtaiki. All rights reserved.
//

import UIKit
import PlaceholderUITextView

class HomeViewController: UITableViewController {
    
    @IBOutlet weak var attributedPlaceholderTextView: PlaceholderUITextView!
    @IBOutlet weak var noneInsetsLinePaddingTextView: PlaceholderUITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Placeholder TextView"
        setupTextViews()
    }
    
    private func setupTextViews() {
        noneInsetsLinePaddingTextView.textContainerInset = UIEdgeInsets.zero
        noneInsetsLinePaddingTextView.textContainerLineFragmentPadding = 0
        
        let description = "Add your professional advice for the test results. Once sent, your advice can not be editted."
        let font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        let attributedString = NSMutableAttributedString(string: description,
                                                         attributes: [.font: UIFont.systemFont(ofSize: 14),
                                                                      .foregroundColor: UIColor.black.withAlphaComponent(0.5)])
        attributedString.addAttribute(.font, value: font, range: NSRange(location: 73, length: 19))
        
        attributedPlaceholderTextView.attributedPlaceholder = attributedString
    }
}
