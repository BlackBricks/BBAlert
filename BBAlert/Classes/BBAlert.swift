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

public struct AlertSettings {
    var blurSettings: BlurSettings = BlurSettings()
}

public struct BlurSettings {
    var radius: CGFloat = 10.0
    var tintColor: UIColor = UIColor(colorLiteralRed: 0.0, green: 0.0, blue: 0.0, alpha: 0.7)
    var saturationDeltaFactor: CGFloat = 1.0
}

open class BBAlert {
    
    public static let shared: BBAlert = BBAlert()
    
    public var settings: AlertSettings = AlertSettings()
    
    private var controller: BBAlertController = BBAlertController()
    
    public func show() {
        controller = BBAlertController(settings: settings)
        topMostController()?.present(controller, animated: false)
    }
    
    public func hide() {
        controller.dismiss(animated: false)
    }
    
    private func topMostController() -> UIViewController? {
        var topController = UIApplication.shared.keyWindow?.rootViewController
        
        while let presentedController = topController?.presentedViewController {
            topController = presentedController
        }
        
        return topController
    }
}

public class BBAlertController: UIViewController {
    
    var settings: AlertSettings = AlertSettings()
    
    convenience init(settings: AlertSettings = AlertSettings()) {
        self.init(nibName: nil, bundle: nil)
        self.settings = settings
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        makeBackground()
    }
    
    private func makeBackground() {
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
        let blurSettings = settings.blurSettings
        let bluredImage = screenshot?.applyBlur(withRadius: blurSettings.radius,
                                                tintColor: blurSettings.tintColor,
                                                saturationDeltaFactor: blurSettings.saturationDeltaFactor,
                                                maskImage: nil)
        view.layer.contents = bluredImage?.cgImage
    }
    
}
