//
//  Settings.swift
//  Pods
//
//  Created by Egor Kryndach on 26/07/2017.
//
//

import Foundation

public typealias ViewRelation = (mainView: UIView, subView: UIView)

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
    var backgroundAppearenceAnimator: Animator = defaultAppearenceAnimator
    var backgroundDisappearenceAnimator: Animator = defaultDisappearenceAnimator
    var alertAppearenceAnimator: Animator = defaultAppearenceAnimator
    var alertDisappearenceAnimator: Animator = defaultDisappearenceAnimator
}

public struct Animator {
    var preanimations: (ViewRelation) -> Void = {
        _, _ in
    }
    var animations: (ViewRelation) -> Void = {
        _, _ in
    }
    var completion: (ViewRelation) -> Void = {
        _, _ in
    }
    var duration: TimeInterval = 0.0
    var animationOptions: UIViewAnimationOptions = []
    var delay: TimeInterval = 0.0

    public func runAnimationFor(mainView: UIView, subView: UIView, completion: @escaping () -> Void = {
    }) {
        let views: ViewRelation = (mainView: mainView, subView: subView)
        preanimations(views)
        UIView.animate(
                withDuration: duration,
                delay: delay,
                options: animationOptions,
                animations: {
                    self.animations(views)
                },
                completion: { _ in
                    self.completion(views)
                    completion()
                })
    }
}

private let padding: UIEdgeInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)

private let defaultPositioning: (ViewRelation) -> Void = {
    (mainView, subView) in
    let horizontalConstraint = NSLayoutConstraint(item: subView, attribute: .centerX, relatedBy: .equal, toItem: mainView, attribute: .centerX, multiplier: 1, constant: 0)
    let verticalConstraint = NSLayoutConstraint(item: subView, attribute: .centerY, relatedBy: .equal, toItem: mainView, attribute: .centerY, multiplier: 1, constant: 0)

    let topConstraint = NSLayoutConstraint(item: subView, attribute: .top, relatedBy: .greaterThanOrEqual, toItem: mainView, attribute: .top, multiplier: 1, constant: padding.top)
    let leftConstraint = NSLayoutConstraint(item: subView, attribute: .left, relatedBy: .greaterThanOrEqual, toItem: mainView, attribute: .left, multiplier: 1, constant: padding.left)
    let bottomConstraint = NSLayoutConstraint(item: subView, attribute: .bottom, relatedBy: .greaterThanOrEqual, toItem: mainView, attribute: .bottom, multiplier: 1, constant: padding.bottom)
    let rightConstraint = NSLayoutConstraint(item: subView, attribute: .right, relatedBy: .greaterThanOrEqual, toItem: mainView, attribute: .right, multiplier: 1, constant: padding.right)

    NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, topConstraint, leftConstraint, bottomConstraint, rightConstraint])
}

private let defaultAppearenceAnimator: Animator = {
    var animator = Animator()
    animator.duration = 0.4
    animator.animationOptions = [.curveEaseInOut]
    animator.preanimations = {
        (mainView, subView) in
        subView.alpha = 0.0
    }
    animator.animations = {
        (mainView, subView) in
        subView.alpha = 1.0
    }
    animator.completion = {
        (mainView, subView) in

    }
    return animator
}()

private let defaultDisappearenceAnimator: Animator = {
    var animator = Animator()
    animator.duration = 0.4
    animator.animationOptions = [.curveEaseInOut]
    animator.preanimations = {
        (mainView, subView) in
        subView.alpha = 1.0
    }
    animator.animations = {
        (mainView, subView) in
        subView.alpha = 0.0
    }
    animator.completion = {
        (mainView, subView) in
        
    }
    return animator
}()
