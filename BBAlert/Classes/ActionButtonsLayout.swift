//
//  ActionButtonsLayout.swift
//  Pods
//
//  Created by Sviatoslav Semenikhin on 28/08/2017.
//
//

import Foundation
import SnapKit

// Protocol for any button in alerts
public protocol AlertPressable {
    var pressBlock: (() -> Void)? { get set }
}

// Protocol for any buttons layout
public protocol ActionsLayout {
    var alertButtons: [AlertPressable]? { get set }
    func configureView(inContainer container: UIView) -> UIView?
}

open class VerticalActionsLayout: ActionsLayout {
    public var alertButtons: [AlertPressable]?
    
    public init(withButtons buttons: [AlertPressable]?) {
        self.alertButtons = buttons
    }
    
    public func configureView(inContainer container: UIView) -> UIView? {
        guard let buttons = alertButtons else {
            return nil
        }
        
        var frame = CGRect(origin: .zero, size: container.frame.size)
        let wrapperView = UIView(frame: frame)
        
        var i = 0
        var resultHeight: CGFloat = 0
        for actionButton in buttons {
            guard let actionButton = actionButton as? UIView else {
                continue
            }
            
            let buttonFrame = CGRect(x: 0, y: CGFloat(i) * actionButton.frame.height, width: frame.width, height: actionButton.frame.height)
            actionButton.frame = buttonFrame
            wrapperView.addSubview(actionButton)
            
            actionButton.snp.makeConstraints { (make) in
                make.top.equalTo(CGFloat(i) * actionButton.frame.height)
                make.left.equalTo(0)
                make.right.equalTo(0)
                make.height.equalTo(actionButton.frame.height)
            }
            
            resultHeight += buttonFrame.height
            i += 1
        }
        
        wrapperView.snp.makeConstraints { (make) in
            make.width.equalTo(container.frame.width)
            make.height.equalTo(resultHeight)
        }
        
        wrapperView.layoutIfNeeded()
        
        return wrapperView
    }
}
