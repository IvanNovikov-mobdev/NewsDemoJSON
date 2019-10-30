//
//  NewsDetailViewController.swift
//  NewsDemoJSON
//
//  Created by Иван Новиков on 22.10.2019.
//  Copyright © 2019 Иван Новиков. All rights reserved.
//

import UIKit
import Foundation

class NewsDetailViewController: UIViewController {
    var selectedNews: News!
    @IBOutlet weak var detailNewsTextView: UITextView!
    @IBOutlet weak var detailLinkTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailNewsTextView.isEditable = false
        detailNewsTextView.isSelectable = true
        detailLinkTextView.isEditable = false
        detailLinkTextView.isSelectable = true
        
        if selectedNews.description != nil {
            detailNewsTextView.text = "\(selectedNews.description!)"
            let attributedString = NSMutableAttributedString(string: "\(selectedNews.url)")
            attributedString.addAttribute(.link, value: "\(selectedNews.url)", range: NSRange(location: 0, length: selectedNews.url.count))
            detailLinkTextView.attributedText = attributedString
        } else {
            let attributedString = NSMutableAttributedString(string: "\(selectedNews.url)")
            attributedString.addAttribute(.link, value: "\(selectedNews.url)", range: NSRange(location: 0, length: selectedNews.url.count))
            detailLinkTextView.attributedText = attributedString
        }
        
    }
    
    func detailLinkTextView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        UIApplication.shared.open(URL)
        return false
    }
}
