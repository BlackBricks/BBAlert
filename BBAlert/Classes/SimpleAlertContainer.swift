//
//  SimpleAlertContainer.swift
//  Pods
//
//  Created by Egor Kryndach on 24/07/2017.
//
//

import Foundation

open class SimpleAlertContainer: UIViewController {
    
    @IBOutlet fileprivate weak var contentView: UIView!
    
}

extension SimpleAlertContainer: AlertDesignable {
    public var content: UIView {
        return contentView
    }
}
