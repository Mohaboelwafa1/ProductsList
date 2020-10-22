//
//  productsDBModel.swift
//  Weather
//
//  Created by Mohammed hassan on 10/21/20.
//  Copyright © 2020 Mohammed hassan. All rights reserved.
//
import RealmSwift

class ProductsDBModel: Object {
    @objc dynamic var productName: String?
    @objc dynamic var productPicture: String?
}
