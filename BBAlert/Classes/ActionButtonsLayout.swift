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
public protocol Actionable: AnyObject {
    var actionBlock: (() -> Void)? { get set }
}

// Protocol for any buttons layout
public protocol ActionsLayout {
    var actionViews: [Actionable]? { get set }
    func configureView(inContainer container: UIView) -> UIView?
}

private let defaultSpacing: CGFloat = 0.5

open class VerticalActionsLayout: ActionsLayout {
    public var actionViews: [Actionable]?
    
    public init(withActionViews views: [Actionable]?) {
        self.actionViews = views
    }
    
    public func configureView(inContainer container: UIView) -> UIView? {
        guard let views = actionViews as? [UIView] else {
            return nil
        }
        
        var frame = CGRect(origin: .zero, size: container.frame.size)
        let wrapperView = UIStackView(arrangedSubviews: views)
        wrapperView.spacing = defaultSpacing
        wrapperView.axis = .vertical

        wrapperView.snp.makeConstraints { (make) in
            make.width.equalTo(container.frame.width)
        }
        
        wrapperView.layoutIfNeeded()
        
        return wrapperView
    }
}

open class GridActionsLayout: ActionsLayout {
    public var actionViews: [Actionable]?
    
    let columnsCount: Int = 2
    
    public init(withActionViews views: [Actionable]?) {
        self.actionViews = views
    }
    
    public func configureView(inContainer container: UIView) -> UIView? {
        guard let views = actionViews as? [UIView] else {
            return nil
        }
        
        var arrangedViews = [UIView]()
        
        for chunk in views.chunks(columnsCount) {
            var horizontalStack = UIStackView()
            horizontalStack.layoutIfNeeded()
            horizontalStack.spacing = defaultSpacing
            horizontalStack.distribution = .fillEqually
            horizontalStack.axis = .horizontal
            for actionView in chunk {
                horizontalStack.addArrangedSubview(actionView)
            }
            arrangedViews.append(horizontalStack)
        }

        let wrapperView = UIStackView(arrangedSubviews: arrangedViews)
        wrapperView.spacing = defaultSpacing
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
