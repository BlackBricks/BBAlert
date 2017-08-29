//
//  ActionButtonsLayout.swift
//  Pods
//
//  Created by Sviatoslav Semenikhin on 28/08/2017.
//
//

import Foundation
import SnapKit

public protocol ActionsLayout {
    var actions: [AlertPressable]? { get set }
    func configureView(inContainer container: UIView) -> UIView?
}

open class DefaultActionsLayout: ActionsLayout {
    public var actions: [AlertPressable]?
    
    public init(withActions actions: [AlertPressable]?) {
        self.actions = actions
    }
    
    public func configureView(inContainer container: UIView) -> UIView? {
        guard let actions = actions else {
            return nil
        }
        
        var frame = CGRect(origin: .zero, size: container.frame.size)
        let wrapperView = UIView(frame: frame)
        
        var i = 0
        var resultHeight: CGFloat = 0
        for actionButton in actions {
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
