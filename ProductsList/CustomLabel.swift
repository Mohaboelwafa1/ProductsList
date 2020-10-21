//
//  CustomLabel.swift
//  ProductsList
//
//  Created by Mohammed hassan on 10/21/20.
//  Copyright © 2020 Mohammed hassan. All rights reserved.
//

import Foundation
import UIKit

class CustomLabel: UILabel {
    var productTitle: String?

    init(productTitle:String) {
        self.productTitle = productTitle
        super.init(frame: CGRect.zero)
        self.text = productTitle
        self.font = UIFont(name: "customFont", size: 60)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

