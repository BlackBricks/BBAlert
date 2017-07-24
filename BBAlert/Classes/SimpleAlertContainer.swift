//
//  SimpleAlertContainer.swift
//  Pods
//
//  Created by Egor Kryndach on 24/07/2017.
//
//

import Foundation
import Reusable

open class SimpleAlertContainer: UIViewController, StoryboardBased {
    
    @IBOutlet fileprivate weak var contentView: UIView!
    
}

extension SimpleAlertContainer: AlertDesignable {
    public var content: UIView {
        return contentView
    }
}
