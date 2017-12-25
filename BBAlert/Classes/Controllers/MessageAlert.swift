//
//  MessageAlert.swift
//  Pods
//
//  Created by Egor Kryndach on 31/07/2017.
//
//

import Foundation
import Reusable
import SnapKit

public class MessageAlert: UIViewController, StoryboardBased, AlertContainable {
    
    public weak var alert: AlertHideable?
    public var content: UIView {
        return contentView
    }
    public var layout: ActionsLayout?

    public var titleText: String = "Title"
    public var messageText: String = "Message"
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var buttonsContainer: UIView!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = titleText
        messageLabel.text = messageText
        
        contentView.layer.cornerRadius = 5.0
        contentView.layer.masksToBounds = true
        
        setupLayout()
    }
    
    private func setupLayout() {
        guard let layout = layout, let actionsView = layout.configureView(inContainer: buttonsContainer) else {
            return
        }
        buttonsContainer.addSubview(actionsView)
        
        actionsView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        buttonsContainer.snp.remakeConstraints { (remake) in
            remake.height.equalTo(actionsView.frame.height)
        }
        
    }
    
    public static func instantiate(withActionViews views: [Actionable]?) -> MessageAlert {
        let alert = instantiate()
        let layout = VerticalActionsLayout(withActionViews: views)
        alert.layout = layout
        return alert
    }
    
    @IBAction func close() {
        alert?.hide() {}
    }
}
