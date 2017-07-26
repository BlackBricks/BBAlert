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
    
    public static let shared: BBAlert = BBAlert()
    
    public var settings: Settings = Settings()
    
    private var controller: BBAlertController = BBAlertController()
    
    public func show(controller contentController: UIViewController) {
        controller = BBAlertController()
        controller.settings = settings
        controller.contentController = contentController
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
    
    public var settings: Settings = Settings()
    public var contentController: UIViewController = UIViewController()

    private var backgroundView: UIView = UIView()
    private var containerView: UIView = UIView()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clear
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        makeBackground()
        makeContentContainer()
    }
    
    private func makeBackground() {
        guard let viewController = presentingViewController else {
            return
        }
        
        updateBackgroundView(backgroundView, backgroundViewController: viewController, settings: settings)
        view.insertSubview(backgroundView, at: 0)
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
    
    private func makeContentContainer() {
        containerView = contentController.view
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        
        settings.positioning((mainView: view, subView: containerView))
    }
    
}
