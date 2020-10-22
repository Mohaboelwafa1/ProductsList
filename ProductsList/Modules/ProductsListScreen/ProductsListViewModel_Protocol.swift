//
//  ProductsListViewModel_Protocol.swift
//  Weather
//
//  Created by Mohammed hassan on 10/21/20.
//  Copyright © 2020 Mohammed hassan. All rights reserved.
//
import RealmSwift

protocol ProductsListViewModel_Protocol {
    typealias ChangeHandler = (() -> Void)
    var changeHandler: ChangeHandler? { get set }
    var productsResponseModel: ProductsResponseModel { get }
    var cellsModel: [ProductCellModel] { get set }
    var productsList: Results<ProductsDBModel>? { get set }
    var dbHandler: DBHandler { get }

    func prepareCellModel() -> [ProductCellModel]
    func getProductsListOffline() -> Results<ProductsDBModel>?
    func getProductsList(completionHandler: @escaping (
        _ ResponseModel:Results<ProductsDBModel>?,
        _ statusCode : Int,
        _ error_Response_Model:Error_Response_Model
        ) -> Void)
}
