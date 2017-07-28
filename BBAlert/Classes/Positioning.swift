//
//  Positioning.swift
//  Pods
//
//  Created by Egor Kryndach on 28/07/2017.
//
//

import Foundation

public enum Positioning {
    case `default`
    
    func get() -> ViewRelation {
        switch self {
        case .default:
            return defaultPositioning
        }
    }
}

private let padding: UIEdgeInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)

private let defaultPositioning: ViewRelation = {
    (mainView, subView) in
    let horizontalConstraint = NSLayoutConstraint(item: subView, attribute: .centerX, relatedBy: .equal, toItem: mainView, attribute: .centerX, multiplier: 1, constant: 0)
    let verticalConstraint = NSLayoutConstraint(item: subView, attribute: .centerY, relatedBy: .equal, toItem: mainView, attribute: .centerY, multiplier: 1, constant: 0)
    
    let topConstraint = NSLayoutConstraint(item: subView, attribute: .top, relatedBy: .greaterThanOrEqual, toItem: mainView, attribute: .top, multiplier: 1, constant: padding.top)
    let leftConstraint = NSLayoutConstraint(item: subView, attribute: .left, relatedBy: .greaterThanOrEqual, toItem: mainView, attribute: .left, multiplier: 1, constant: padding.left)
    let bottomConstraint = NSLayoutConstraint(item: subView, attribute: .bottom, relatedBy: .greaterThanOrEqual, toItem: mainView, attribute: .bottom, multiplier: 1, constant: padding.bottom)
    let rightConstraint = NSLayoutConstraint(item: subView, attribute: .right, relatedBy: .greaterThanOrEqual, toItem: mainView, attribute: .right, multiplier: 1, constant: padding.right)
    
    NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, topConstraint, leftConstraint, bottomConstraint, rightConstraint])
}
