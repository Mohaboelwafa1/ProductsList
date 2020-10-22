//
//  APIManager.swift
//  Weather
//
//  Created by Mohammed hassan on 8/7/20.
//  Copyright © 2020 Mohammed hassan. All rights reserved.
//

import SwiftyJSON

class APIManager: NSObject, OperationalRepository {

    internal func getProductsList(completionHandler: @escaping (_ result:ProductsResponseModel?, _ statusCode : Int, _ error_Response_Model:Error_Response_Model?) -> Void) {
        let Newurl = BaseApi.mainPath
        excuteServerOperation(url: Newurl, way: .get, completionHandler: { (result, statusCode, errorModel ) in
            do{
                let jsonDecoder = JSONDecoder()
                var responseModel : ProductsResponseModel!
                var errorModel : Error_Response_Model!
                if(statusCode == 200){
                    responseModel = try jsonDecoder.decode(ProductsResponseModel.self, from: result as! Data)
                    errorModel = nil
                } else {
                    responseModel = nil
                    errorModel = Error_Response_Model.init()
                }
                completionHandler(responseModel, statusCode, errorModel)
            }
            catch{}
        } )
    }
}
