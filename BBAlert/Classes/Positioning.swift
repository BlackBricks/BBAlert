//
//  Positioning.swift
//  Pods
//
//  Created by Egor Kryndach on 28/07/2017.
//
//

import Foundation
import SnapKit

public enum Positioning {
    case `default`
    
    public func get() -> ViewRelation {
        switch self {
        case .default:
            return defaultPositioning
        }
    }
}

private let padding: UIEdgeInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)

private let defaultPositioning: ViewRelation = { (viewPair) in
    
    viewPair.subView.snp.makeConstraints { (make) in
        make.center.equalToSuperview()
    }
}
