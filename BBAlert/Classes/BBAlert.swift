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
    
    public static func topMostController() -> UIViewController? {
        var topController = UIApplication.shared.keyWindow?.rootViewController
        
        while let presentedController = topController?.presentedViewController {
            topController = presentedController
        }
        
        return topController
    }
    
}

struct BlurSettings {
    var radius: CGFloat = 10.0
    var tintColor: UIColor = UIColor(colorLiteralRed: 0.0, green: 0.0, blue: 0.0, alpha: 0.7)
    var saturationDeltaFactor: CGFloat = 1.0
}

class BBAlertController: UIViewController {
    
    var blurSettings: BlurSettings = BlurSettings()
    
    func blurBackground() {
        guard let viewController = presentingViewController else {
            return
        }
        UIGraphicsBeginImageContextWithOptions(viewController.view.bounds.size, true, 1)
        viewController.view.drawHierarchy(in: viewController.view.bounds, afterScreenUpdates: true)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        let bluredImage = screenshot?.applyBlur(withRadius: blurSettings.radius, tintColor: blurSettings.tintColor, saturationDeltaFactor: blurSettings.saturationDeltaFactor, maskImage: nil)
        view.layer.contents = bluredImage?.cgImage
    }
    
}
