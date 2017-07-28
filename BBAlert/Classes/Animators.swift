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
    
    func get() -> Animator {
        switch self {
        case .defaultAppearence:
            return defaultAppearenceAnimator
        case .defaultDisappearence:
            return defaultDisappearenceAnimator
        }
    }
}

public struct Animator {
    var preanimations: ViewRelation = {
        _, _ in
    }
    var animations: ViewRelation = {
        _, _ in
    }
    var completion: ViewRelation = {
        _, _ in
    }
    var duration: TimeInterval = 0.0
    var animationOptions: UIViewAnimationOptions = []
    var delay: TimeInterval = 0.0
    
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
