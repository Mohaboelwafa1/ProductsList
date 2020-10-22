//
//  productsResponseModel.swift
//  Weather
//
//  Created by Mohammed hassan on 10/21/20.
//  Copyright © 2020 Mohammed hassan. All rights reserved.
//
import Foundation

// MARK: - Welcome
struct ProductsResponseModel: Codable {
    let data: DataClass
    let errors, meta: String

    init(){
        data = DataClass()
        errors = "errors"
        meta = "meta"
    }
}

// MARK: - DataClass
struct DataClass: Codable {
    let products: [Product]
    let message: String

    init(){
        products = [Product()]
        message = "message"
    }
}

// MARK: - Product
struct Product: Codable {
    let createdAt, updatedAt: String
    let isFavorite: Bool
    let id: Int
    let nameEn, nameAr, descriptionEn, descriptionAr: String
    let price: Double
    let isActive, isQuantities: Bool
    let categoryID, storeID, sellerID: Int
    let shareableLink: String
    let links: [Link]
    let category: Category

    enum CodingKeys: String, CodingKey {
        case createdAt, updatedAt
        case isFavorite = "is_favorite"
        case id
        case nameEn = "name_en"
        case nameAr = "name_ar"
        case descriptionEn = "description_en"
        case descriptionAr = "description_ar"
        case price
        case isActive = "is_active"
        case isQuantities = "is_quantities"
        case categoryID = "category_id"
        case storeID = "store_id"
        case sellerID = "seller_id"
        case shareableLink = "shareable_link"
        case links = "Links"
        case category = "Category"
    }

    init(){
        createdAt = "createdAt"
        updatedAt = "updatedAt"
        isFavorite = false
        id = 0
        nameEn = "name_en"
        nameAr = "name_ar"
        descriptionEn = "description_en"
        descriptionAr = "description_ar"
        price = 0.0
        isActive = false
        isQuantities = false
        categoryID = 0
        storeID = 0
        sellerID = 0
        shareableLink = "shareable_link"
        links =  [Link()]
        category = Category()
    }
}

// MARK: - Category
struct Category: Codable {
    let createdAt, updatedAt: String
    let id: Int
    let nameEn, nameAr: String
    let isActive: Bool
    let link: Link

    enum CodingKeys: String, CodingKey {
        case createdAt, updatedAt, id
        case nameEn = "name_en"
        case nameAr = "name_ar"
        case isActive = "is_active"
        case link = "Link"
    }

    init(){
        createdAt = "createdAt"
        updatedAt = "updatedAt"
        id = 0
        nameEn = "name_en"
        nameAr = "name_ar"
        isActive = false
        link = Link()
    }
}

// MARK: - Link
struct Link: Codable {
    let createdAt, updatedAt: String
    let id: Int
    let targetType: String
    let targetID: Int
    let link: String
    let linkType: String
    let isActive: Bool

    enum CodingKeys: String, CodingKey {
        case createdAt, updatedAt, id
        case targetType = "target_type"
        case targetID = "target_id"
        case link
        case linkType = "link_type"
        case isActive = "is_active"
    }

    init(){
        createdAt = "AtedAt"
        updatedAt = "AtedAt"
        id = 0
        targetType = "TargetType"
        targetID = 0
        link = "link"
        linkType = "LinkType"
        isActive = false
       }
}
