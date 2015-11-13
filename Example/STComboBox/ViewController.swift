//
//  ViewController.swift
//  STComboBox
//
//  Created by Saulo Tauil on 11/13/2015.
//  Copyright (c) 2015 Saulo Tauil. All rights reserved.
//

import UIKit
import STComboBox

class ViewController: UIViewController {

    @IBOutlet weak var combo: STComboBox!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        combo.data = ["Orange", "Apple", "Banana", "Mellon", "Lemon", "Grape"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

