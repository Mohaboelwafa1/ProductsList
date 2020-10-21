//
//  ViewController.swift
//  ProductsList
//
//  Created by Mohammed hassan on 10/21/20.
//  Copyright © 2020 Mohammed hassan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        let label = CustomLabel(productTitle: "Test Test Test Test")
        label.frame = CGRect(x: 50, y: 50, width: 100, height: 30)
        label.font = UIFont(name: "customFont", size: 60)
        self.view.addSubview(label)
        
    }


}

