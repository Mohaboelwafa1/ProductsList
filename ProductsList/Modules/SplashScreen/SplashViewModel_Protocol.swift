//
//  SplashViewModel_Protocol.swift
//  Weather
//
//  Created by Mohammed hassan on 10/21/20.
//  Copyright © 2020 Mohammed hassan. All rights reserved.
//
import RealmSwift

protocol SplashViewModel_Protocol {
    typealias ChangeHandler = (() -> Void)
    var changeHandler: ChangeHandler? { get set }
    var dbHandler: DBHandler { get }
    func getProductsList(completionHandler: @escaping (
        _ ResponseModel:Results<ProductsDBModel>?,
        _ statusCode : Int,
        _ error_Response_Model:Error_Response_Model
        ) -> Void)
}
