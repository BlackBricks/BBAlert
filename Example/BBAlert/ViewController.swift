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
        let vc = AlertExample.instantiate()
        BBAlert.show(controller: vc, inController: self)
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
