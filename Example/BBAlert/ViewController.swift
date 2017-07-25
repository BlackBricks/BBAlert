//
//  ViewController.swift
//  BBAlert
//
//  Created by kryndach on 07/10/2017.
//  Copyright (c) 2017 kryndach. All rights reserved.
//

import BBAlert
import UIKit

private class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func showAlert() {
        BBAlert.shared.show(controller: UIViewController())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
