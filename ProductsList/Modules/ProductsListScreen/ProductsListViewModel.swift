//
//  ProductsListViewModel.swift
//  Weather
//
//  Created by Mohammed hassan on 10/21/20.
//  Copyright © 2020 Mohammed hassan. All rights reserved.
//

import RealmSwift

class ProductsListViewModel: ProductsListViewModel_Protocol {

    internal var changeHandler: ChangeHandler?
    internal var productsResponseModel: ProductsResponseModel
    internal var cellsModel: [ProductCellModel]
    internal var productsList: Results<ProductsDBModel>?
    internal let dbHandler: DBHandler

    init(dbHandler: DBHandler) {
        self.dbHandler = dbHandler
        productsResponseModel = ProductsResponseModel()
        cellsModel = [ProductCellModel]()
        productsList = nil
    }

    internal func getProductsListOffline() -> Results<ProductsDBModel>? {
        let realm = try! Realm()
        productsList = realm.objects(ProductsDBModel.self)
        return productsList
    }

    internal func getProductsList(completionHandler: @escaping (Results<ProductsDBModel>?, Int, Error_Response_Model) -> Void) {
        APIManager().getProductsList(completionHandler: {
            (result, statusCode, errorModel) in

            if result == nil {completionHandler(nil, statusCode, errorModel ?? Error_Response_Model())}
            self.dbHandler.saveToDB(data: result ?? ProductsResponseModel())
            let realm = try! Realm()
            let productsList = realm.objects(ProductsDBModel.self)
            self.cellsModel = self.prepareCellModel()
            completionHandler(productsList, statusCode, errorModel ?? Error_Response_Model())
        })
    }

    internal func prepareCellModel() -> [ProductCellModel] {

        guard self.productsList != nil else {return cellsModel}

        for row in self.productsList! {
            var model : ProductCellModel = ProductCellModel()
            model.productName = row.productName!
            model.productImage = row.productPicture ?? ""
            cellsModel.append(model)
        }
        self.changeHandler?()
        return cellsModel
    }
}
