//
//  SplashViewModel.swift
//  Weather
//
//  Created by Mohammed hassan on 8/8/20.
//  Copyright © 2020 Mohammed hassan. All rights reserved.
//
import RealmSwift

class SplashViewModel: NSObject, SplashViewModel_Protocol {

    internal var changeHandler: ChangeHandler?
    internal let dbHandler: DBHandler
    init(dbHandler: DBHandler) {
        self.dbHandler = dbHandler
    }

    internal func getProductsList(completionHandler: @escaping (Results<ProductsDBModel>?, Int, Error_Response_Model) -> Void) {
        APIManager().getProductsList(completionHandler: {
            (result, statusCode, errorModel) in
            
            if result == nil {completionHandler(nil, statusCode, errorModel ?? Error_Response_Model())}

            self.dbHandler.saveToDB(data: result ?? ProductsResponseModel())

            let realm = try! Realm()
            let productsList = realm.objects(ProductsDBModel.self)

            self.changeHandler?()
            completionHandler(productsList, statusCode, errorModel ?? Error_Response_Model())
        })
    }

}
