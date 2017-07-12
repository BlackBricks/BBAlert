//
//  BBAlert.swift
//  Pods
//
//  Created by Egor Kryndach on 11/07/2017.
//
//

import Foundation
import UIImageEffects
import UIKit

open class BBAlert {
    
    public static let shared = BBAlert()
    
    public var blurSettings: BlurSettings = BlurSettings()
    
    public var controller = BBAlertController()
    
    public func show() {
        controller = BBAlertController()
        topMostController()?.present(controller, animated: false)
    }
    
    private func topMostController() -> UIViewController? {
        var topController = UIApplication.shared.keyWindow?.rootViewController
        
        while let presentedController = topController?.presentedViewController {
            topController = presentedController
        }
        
        return topController
    }
}

public struct BlurSettings {
    
    var radius: CGFloat = 10.0
    var tintColor: UIColor = UIColor(colorLiteralRed: 0.0, green: 0.0, blue: 0.0, alpha: 0.7)
    var saturationDeltaFactor: CGFloat = 1.0
    
}

public class BBAlertController: UIViewController {
    
    var alert: BBAlert = BBAlert.shared
    
    convenience init(alert: BBAlert = BBAlert.shared) {
        self.init(nibName: nil, bundle: nil)
        self.alert = alert
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        blurBackground()
    }
    
    private func blurBackground() {
        guard let viewController = presentingViewController else {
            return
        }
        UIGraphicsBeginImageContextWithOptions(viewController.view.bounds.size, true, 1)
        viewController.view.drawHierarchy(in: viewController.view.bounds, afterScreenUpdates: true)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        let bluredImage = screenshot?.applyBlur(withRadius: alert.blurSettings.radius,
                                                tintColor: alert.blurSettings.tintColor,
                                                saturationDeltaFactor: alert.blurSettings.saturationDeltaFactor,
                                                maskImage: nil)
        view.layer.contents = bluredImage?.cgImage
    }
    
}
