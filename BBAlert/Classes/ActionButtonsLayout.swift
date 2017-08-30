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
public protocol AlertPressable: AnyObject {
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
        guard let buttons = alertButtons as? [UIView] else {
            return nil
        }
        
        var frame = CGRect(origin: .zero, size: container.frame.size)
        let wrapperView = UIStackView(arrangedSubviews: buttons)
        wrapperView.spacing = 0.5
        wrapperView.axis = .vertical

        wrapperView.snp.makeConstraints { (make) in
            make.width.equalTo(container.frame.width)
        }
        
        wrapperView.layoutIfNeeded()
        
        return wrapperView
    }
}

open class HorizontalActionsLayout: ActionsLayout {
    public var alertButtons: [AlertPressable]?
    
    public init(withButtons buttons: [AlertPressable]?) {
        self.alertButtons = buttons
    }
    
    public func configureView(inContainer container: UIView) -> UIView? {
        guard let buttons = alertButtons as? [UIView] else {
            return nil
        }
        
        var arrangedViews = [UIView]()
        
        for chunk in buttons.chunks(2) {
            var horizontalStack = UIStackView()
            horizontalStack.layoutIfNeeded()
            horizontalStack.spacing = 0.5
            horizontalStack.distribution = .fillEqually
            horizontalStack.axis = .horizontal
            for button in chunk {
                horizontalStack.addArrangedSubview(button)
            }
            arrangedViews.append(horizontalStack)
        }

        let wrapperView = UIStackView(arrangedSubviews: arrangedViews)
        wrapperView.spacing = 0.5
        wrapperView.axis = .vertical
        
        wrapperView.snp.makeConstraints { (make) in
            make.width.equalTo(container.frame.width)
        }
        
        wrapperView.layoutIfNeeded()
        
        return wrapperView
    }
}

extension Array {
    func chunks(_ chunkSize: Int) -> [[Element]] {
        return stride(from: 0, to: self.count, by: chunkSize).map {
            Array(self[$0..<Swift.min($0 + chunkSize, self.count)])
        }
    }
}
