//
//  MessageAlert.swift
//  Pods
//
//  Created by Egor Kryndach on 31/07/2017.
//
//

import Foundation
import Reusable

public class MessageAlert: UIViewController, StoryboardBased, AlertContainable {
    
    public weak var alert: AlertHideable?
    public var content: UIView {
        return contentView
    }

    public var titleText: String = "Title"
    public var messageText: String = "Message"
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private weak var contentView: UIView!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = titleText
        messageLabel.text = messageText
        
        contentView.layer.cornerRadius = 5.0
        contentView.layer.masksToBounds = false
    }
    
    @IBAction func close() {
        alert?.hide()
    }
    
}
