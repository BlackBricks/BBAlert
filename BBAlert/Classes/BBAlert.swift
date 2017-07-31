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

public protocol AlertHideable: AnyObject {
    func hide()
}

public protocol AlertContainable {
    weak var alert: AlertHideable? { get set }
    var content: UIView { get }
}

open class BBAlert: AlertHideable {

    public static let shared: BBAlert = BBAlert()

    public var settings: Settings = Settings()

    private var controller: BBAlertController = BBAlertController()

    public init() {

    }
    
    public static func show(controller contentController: UIViewController, inController mainController: UIViewController) {
        shared.show(controller: contentController, inController: mainController)
    }
    
    public func show(controller contentController: UIViewController, inController mainController: UIViewController) {
        controller = BBAlertController()
        controller.settings = settings
        controller.contentController = contentController
        controller.modalPresentationStyle = .overCurrentContext
        
        if var contentController = contentController as? AlertContainable {
            contentController.alert = self
        }
        
        mainController.present(controller, animated: false)
    }

    public func hide() {
        controller.hide()
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
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(backgroundTap(_:)))
        backgroundView.addGestureRecognizer(tap)
        backgroundView.isUserInteractionEnabled = true
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        makeBackground()
        makeContentContainer()
        settings.animation
            .backgroundAppearenceAnimator
            .runAnimationFor(mainView: view, subView: backgroundView)
        settings.animation
            .alertAppearenceAnimator
            .runAnimationFor(mainView: view, subView: containerView)
    }
    
    @objc
    private func backgroundTap(_ sender: UITapGestureRecognizer) {
        if settings.cancelable {
            hide()
        }
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
        // forcing contentController to load view hierarchy
        _ = contentController.view
        
        if var contentController = contentController as? AlertContainable {
            containerView = contentController.content
        }

        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)

        settings.positioning((mainView: view, subView: containerView))
    }

    fileprivate func hide() {
        settings.animation
            .backgroundDisappearenceAnimator
            .runAnimationFor(mainView: view, subView: backgroundView)
        settings.animation
            .alertDisappearenceAnimator
            .runAnimationFor(mainView: view, subView: containerView) { [weak self] in
                self?.dismiss(animated: false)
            }
    }

}
