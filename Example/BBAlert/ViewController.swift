//
//  ViewController.swift
//  BBAlert
//
//  Created by kryndach on 07/10/2017.
//  Copyright (c) 2017 kryndach. All rights reserved.
//

import BBAlert
import Reusable
import UIKit

public class ViewController: UIViewController, StoryboardBased {

    override public func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func showAlert() {
        let vc = MessageAlert.instantiate()
        
        let button = AlertButton.create(withTitle: "Ok") {
            NSLog("Ok button pressed")
            vc.alert?.hide()
        }
        
        let button2 = AlertButton.create(withTitle: "Another Red Button") {
            vc.alert?.hide()
        }
        
        let button3 = AlertButton.create(withTitle: "3") {
            vc.alert?.hide()
        }
        
        // Create Layout
        let layout = HorizontalActionsLayout(withButtons: [button, button2, button3])
        vc.layout = layout
        
        BBAlert.show(controller: vc, inController: self)
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
