//
//  AlertButton.swift
//  Pods
//
//  Created by Sviatoslav Semenikhin on 28/08/2017.
//
//

import Foundation
import Reusable
import UIKit

public class AlertButton: UIView, NibLoadable, Actionable {
    
    @IBOutlet private weak var buttonTitle: UILabel!
    public var actionBlock: (() -> Void)?
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        layer.backgroundColor = UIColor.red.cgColor
        buttonTitle.textColor = UIColor.white
        configurePress()
    }
    
    private func configurePress() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(buttonAction))
        addGestureRecognizer(tap)
    }
    
    @objc
    private func buttonAction() {
        guard let pressBlock = actionBlock else {
            return
        }
        
        pressBlock()
    }
    
    public class func create(withTitle title: String, completion: (() -> Void)?) -> AlertButton {
        let alertButton = AlertButton.loadFromNib()
        alertButton.buttonTitle.text = title
        alertButton.actionBlock = completion
        return alertButton
    }
}
