//
//  AlertExample.swift
//  BBAlert
//
//  Created by Egor Kryndach on 25/07/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import BBAlert
import Reusable
import UIKit

public class AlertExample: UIViewController, StoryboardBased, AlertContainable {
    
    public var content: UIView {
        return contentView
    }
    
    @IBOutlet private weak var contentView: UIView!
    
    public weak var alert: AlertHideable?
    
    @IBAction func close() {
        alert?.hide()
    }
}
