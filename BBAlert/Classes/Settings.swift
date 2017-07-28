//
//  Settings.swift
//  Pods
//
//  Created by Egor Kryndach on 26/07/2017.
//
//

import Foundation

public typealias ViewPair = (mainView: UIView, subView: UIView)

public typealias ViewRelation = (ViewPair) -> Void

public struct Settings {
    var background: BackgroundSettings = BackgroundSettings()
    var animation: Animation = Animation()
    var positioning: ViewRelation = Positioning.default.get()
    var cancelable: Bool = true
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
    var backgroundAppearenceAnimator: Animator = Animators.defaultAppearence.get()
    var backgroundDisappearenceAnimator: Animator = Animators.defaultDisappearence.get()
    var alertAppearenceAnimator: Animator = Animators.defaultAppearence.get()
    var alertDisappearenceAnimator: Animator = Animators.defaultDisappearence.get()
}
