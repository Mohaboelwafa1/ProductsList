//
//  DBHandler.swift
//  Weather
//
//  Created by Mohammed hassan on 10/21/20.
//  Copyright © 2020 Mohammed hassan. All rights reserved.
//
import RealmSwift

class DBHandler {
    func saveToDB(data: ProductsResponseModel) {
        let realm = try! Realm()

        try! realm.write {
            realm.deleteAll()
        }

        for product in data.data.products {
            let productModel = ProductsDBModel()
            productModel.productName = product.nameEn
            productModel.productPicture = product.links.first?.link

            try! realm.write {
                realm.add(productModel)
            }
        }
    }
}
