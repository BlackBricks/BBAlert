//
//  Settings.swift
//  Pods
//
//  Created by Egor Kryndach on 26/07/2017.
//
//

import Foundation

typealias ViewRelation = (mainView: UIView, subView: UIView)

public struct Settings {
    var background: BackgroundSettings = BackgroundSettings()
    var animation: Animation = Animation()
    var positioning: (ViewRelation) -> Void = defaultPositioning
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
    var backgroundAppearenceAnimator: Animator = Animator()
    var backgroundDisappearenceAnimator: Animator = Animator()
    var alertAppearenceAnimator: Animator = Animator()
    var alertDisappearenceAnimator: Animator = Animator()
}

public struct Animator {
    var preanimations: () -> Void = {}
    var animations: () -> Void = {}
    var completion: () -> Void = {}
    var duration: TimeInterval = 0.0
    var animationOptions: UIViewAnimationOptions = []
    var delay: TimeInterval = 0.0
    
    public func run() {
        preanimations()
        UIView.animate(withDuration: duration, delay: delay, options: animationOptions, animations: animations, completion: { _ in
            self.completion()
        })
    }
}

private let padding: UIEdgeInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)

private let defaultPositioning: (ViewRelation) -> Void = { (mainView, subView) in
    let horizontalConstraint = NSLayoutConstraint(item: subView, attribute: .centerX, relatedBy: .equal, toItem: mainView, attribute: .centerX, multiplier: 1, constant: 0)
    let verticalConstraint = NSLayoutConstraint(item: subView, attribute: .centerY, relatedBy: .equal, toItem: mainView, attribute: .centerY, multiplier: 1, constant: 0)
    
    let topConstraint = NSLayoutConstraint(item: subView, attribute: .top, relatedBy: .greaterThanOrEqual, toItem: mainView, attribute: .top, multiplier: 1, constant: padding.top)
    let leftConstraint = NSLayoutConstraint(item: subView, attribute: .left, relatedBy: .greaterThanOrEqual, toItem: mainView, attribute: .left, multiplier: 1, constant: padding.left)
    let bottomConstraint = NSLayoutConstraint(item: subView, attribute: .bottom, relatedBy: .greaterThanOrEqual, toItem: mainView, attribute: .bottom, multiplier: 1, constant: padding.bottom)
    let rightConstraint = NSLayoutConstraint(item: subView, attribute: .right, relatedBy: .greaterThanOrEqual, toItem: mainView, attribute: .right, multiplier: 1, constant: padding.right)
    
    NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, topConstraint, leftConstraint, bottomConstraint, rightConstraint])
}
