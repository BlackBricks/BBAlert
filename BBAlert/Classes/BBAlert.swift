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

public struct Settings {
    var background: BackgroundSettings = BackgroundSettings()
    var animation: Animation = Animation()
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

public struct Animation {
    var appearance: Animator = Animator()
    var disappearance: Animator = Animator()
}

public struct Animator {

}

public protocol AlertDesignable {
    var container: UIView { get set }
}

open class BBAlert {
    
    public static let shared: BBAlert = BBAlert()
    
    public var settings: Settings = Settings()
    
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
    
    private var settings: Settings = Settings()
    private var animation: Animation = Animation()
    private var backgroundView: UIView = UIView()
    private var containerView: UIView = UIView()
    
    convenience init(settings: Settings = Settings(), animation: Animation = Animation()) {
        self.init(nibName: nil, bundle: nil)
        self.settings = settings
        self.animation = animation
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clear
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        makeBackground()
        makeContainer()
    }
    
    private func makeBackground() {
        guard let viewController = presentingViewController else {
            return
        }
        
        updateBackgroundView(backgroundView, backgroundViewController: viewController, settings: settings)
        if backgroundView.superview == nil {
            view.addSubview(backgroundView)
        }
    }
    
    private func updateBackgroundView(_ backgroundView: UIView, backgroundViewController: UIViewController, settings: Settings) {
        backgroundView.backgroundColor = settings.background.color
        backgroundView.frame = view.bounds
        backgroundView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        for subview in backgroundView.subviews {
            subview.removeFromSuperview()
        }
        
        let blurSettings = settings.background.blur
        guard blurSettings.enabled else {
            return
        }
        
        if blurSettings.isCustomBlur {
            let bluredView = makeBluredView(viewController: backgroundViewController, blurSettings: blurSettings)
            backgroundView.addSubview(bluredView)
        } else {
            let bluredView = makeDefaultBluredView(viewController: backgroundViewController, blurSettings: blurSettings)
            backgroundView.addSubview(bluredView)
        }
    }
    
    private func makeBluredView(viewController: UIViewController, blurSettings: BlurSettings) -> UIView {
        UIGraphicsBeginImageContextWithOptions(viewController.view.bounds.size, true, 1)
        viewController.view.drawHierarchy(in: viewController.view.bounds, afterScreenUpdates: true)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        let bluredImage = screenshot?.applyBlur(withRadius: blurSettings.radius,
                                                tintColor: blurSettings.tintColor,
                                                saturationDeltaFactor: blurSettings.saturationDeltaFactor,
                                                maskImage: nil)
        let bluredImageView = UIImageView(image: bluredImage)
        bluredImageView.frame = viewController.view.bounds
        bluredImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return bluredImageView
    }
    
    private func makeDefaultBluredView(viewController: UIViewController, blurSettings: BlurSettings) -> UIView {
        let blurEffect = UIBlurEffect(style: blurSettings.blurEffectStyle)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = viewController.view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return blurEffectView
    }
    
    private func makeContainer() {
        
    }
    
}
