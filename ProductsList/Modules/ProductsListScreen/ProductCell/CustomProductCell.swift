//
//  CustomProductCell.swift
//  Weather
//
//  Created by Mohammed hassan on 8/7/20.
//  Copyright © 2020 Mohammed hassan. All rights reserved.
//

import UIKit
import Kingfisher

class CustomProductCell : UITableViewCell {

    var titleLabel: CustomLabel!

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        titleLabel = CustomLabel(productTitle: "")
        titleLabel.frame = CGRect(x: 0, y: 20, width: self.frame.width, height: 30)
        titleLabel.textColor = UIColor.black
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "customFont", size: 30)
        self.addSubview(titleLabel)
    }

    func setModel(model : ProductCellModel)   {
        self.titleLabel.text = model.productName
        CellBackgroundImageSetter.setBackgroundImage(imageURL: model.productImage, cell: self)
    }

}
