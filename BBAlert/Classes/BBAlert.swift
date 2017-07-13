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
    var background: BackgroundSettings = BackgroundSettings()
    var view: ViewSettings = ViewSettings()
}

public struct BackgroundSettings {
    var color: UIColor = UIColor(colorLiteralRed: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
    var blur: BlurSettings = BlurSettings()
}

public struct BlurSettings {
    var blurEffectStyle: UIBlurEffectStyle = .dark
    var isCustomBlur: Bool = false
    var enabled: Bool = true
    var radius: CGFloat = 10.0
    var tintColor: UIColor = UIColor(colorLiteralRed: 0.0, green: 0.0, blue: 0.0, alpha: 0.7)
    var saturationDeltaFactor: CGFloat = 1.0
}

public struct ViewSettings {
    
}

open class BBAlert {
    
    public static let shared: BBAlert = BBAlert()
    
    public var settings: AlertSettings = AlertSettings()
    
    private var controller: BBAlertController = BBAlertController()
    
    public func show() {
        controller = BBAlertController(settings: settings)
        controller.modalPresentationStyle = .overCurrentContext
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
        view.backgroundColor = settings.background.color
        
        let blurSettings = settings.background.blur
        guard blurSettings.enabled else {
            return
        }
        if blurSettings.isCustomBlur {
            makeBlurBackground(blurSettings: blurSettings)
        } else {
            makeDefaultBlurBackground(blurSettings: blurSettings)
        }
    }
    
    private func makeBlurBackground(blurSettings: BlurSettings) {
        guard let viewController = presentingViewController else {
            return
        }
        UIGraphicsBeginImageContextWithOptions(viewController.view.bounds.size, true, 1)
        viewController.view.drawHierarchy(in: viewController.view.bounds, afterScreenUpdates: true)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        let bluredImage = screenshot?.applyBlur(withRadius: blurSettings.radius,
                                                tintColor: blurSettings.tintColor,
                                                saturationDeltaFactor: blurSettings.saturationDeltaFactor,
                                                maskImage: nil)
        let bluredImageView = UIImageView(image: bluredImage)
        bluredImageView.frame = view.bounds
        bluredImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(bluredImageView)
    }
    
    private func makeDefaultBlurBackground(blurSettings: BlurSettings) {
        let blurEffect = UIBlurEffect(style: blurSettings.blurEffectStyle)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
    }
    
}
