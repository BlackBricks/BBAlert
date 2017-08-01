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
    public var background: BackgroundSettings = BackgroundSettings()
    public var animation: Animation = Animation()
    public var positioning: ViewRelation = Positioning.default.get()
    public var cancelable: Bool = true
}

public struct BackgroundSettings {
    public var color: UIColor = UIColor(colorLiteralRed: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
    public var blur: BlurSettings = BlurSettings()
}

public struct BlurSettings {
    public var blurEffectStyle: UIBlurEffectStyle = .dark
    public var isCustomBlur: Bool = false
    public var enabled: Bool = true
    public var radius: CGFloat = 10.0
    public var tintColor: UIColor = UIColor(colorLiteralRed: 0.0, green: 0.0, blue: 0.0, alpha: 0.7)
    public var saturationDeltaFactor: CGFloat = 1.0
}

public struct Animation {
    public var backgroundAppearenceAnimator: Animator = Animators.defaultAppearence.get()
    public var backgroundDisappearenceAnimator: Animator = Animators.defaultDisappearence.get()
    public var alertAppearenceAnimator: Animator = Animators.defaultAppearence.get()
    public var alertDisappearenceAnimator: Animator = Animators.defaultDisappearence.get()
}
