//
//  CustomProductCell.swift
//  Weather
//
//  Created by Mohammed hassan on 10/21/20.
//  Copyright © 2020 Mohammed hassan. All rights reserved.
//

import UIKit
import Kingfisher
import SnapKit

class CustomProductCell : UITableViewCell {

    var titleLabel: CustomLabel!

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel = CustomLabel(productTitle: "")
        self.addSubview(titleLabel)
        titleLabel.textColor = UIColor.magenta
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "Inconsolata-Regular", size: 30)
        titleLabel.snp.makeConstraints { (make) -> Void in
            make.width.lessThanOrEqualToSuperview()
            make.height.equalTo(30)
            make.centerX.equalToSuperview()
            make.topMargin.equalTo(20)
        }
    }

    func setModel(model : ProductCellModel)   {
        self.titleLabel.text = model.productName
        CellBackgroundImageSetter.setBackgroundImage(imageURL: model.productImage, cell: self)
    }
}
