//
//  Animators.swift
//  Pods
//
//  Created by Egor Kryndach on 28/07/2017.
//
//

import Foundation

public enum Animators {
    case defaultAppearence
    case defaultDisappearence
    
    public func get() -> Animator {
        switch self {
        case .defaultAppearence:
            return defaultAppearenceAnimator
        case .defaultDisappearence:
            return defaultDisappearenceAnimator
        }
    }
}

public struct Animator {
    public var preanimations: ViewRelation = {
        _, _ in
    }
    public var animations: ViewRelation = {
        _, _ in
    }
    public var completion: ViewRelation = {
        _, _ in
    }
    public var duration: TimeInterval = 0.0
    public var animationOptions: UIViewAnimationOptions = []
    public var delay: TimeInterval = 0.0
    
    public func runAnimationFor(mainView: UIView, subView: UIView, completion: @escaping () -> Void = {
        }) {
        let views: ViewPair = (mainView: mainView, subView: subView)
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

private let defaultAppearenceAnimator: Animator = {
    alphaAnimator(from: 0.0, to: 1.0, duration: 0.4)
}()

private let defaultDisappearenceAnimator: Animator = {
    alphaAnimator(from: 1.0, to: 0.0, duration: 0.4)
}()

private func alphaAnimator(from startAlpha: CGFloat, to endAlpha: CGFloat, duration: TimeInterval) -> Animator {
    var animator = Animator()
    animator.duration = duration
    animator.animationOptions = [.curveEaseInOut]
    animator.preanimations = {
        (mainView, subView) in
        subView.alpha = startAlpha
    }
    animator.animations = {
        (mainView, subView) in
        subView.alpha = endAlpha
    }
    animator.completion = {
        (mainView, subView) in
        
    }
    return animator
}
