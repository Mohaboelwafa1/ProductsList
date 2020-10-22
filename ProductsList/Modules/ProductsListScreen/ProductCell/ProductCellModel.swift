//
//  ProductCellModel.swift
//  Weather
//
//  Created by Mohammed hassan on 8/7/20.
//  Copyright © 2020 Mohammed hassan. All rights reserved.
//

struct ProductCellModel: Codable {

    internal var productName : String
    internal var productImage: String

    enum CodingKeys: String, CodingKey {
        case productName = "productName"
        case productImage = "productImage"
    }

    init() {
        productName = ""
        productImage = ""
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        productName = try values.decodeIfPresent(String.self, forKey: .productName)!
        productImage = try values.decodeIfPresent(String.self, forKey: .productImage)!
    }
}
