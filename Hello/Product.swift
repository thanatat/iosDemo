//
//  Product.swift
//  Hello
//
//  Created by Thanatat Boorapan on 25/8/18.
//  Copyright © 2018 Thanatat Boorapan. All rights reserved.
//

import Foundation

struct Product: Decodable {
    let productCode: String
    let productName: String
    let price: String
    let rating: Int?
    let comments: [Comment]
    
//    private enum CodingKeys: String, CodingKey {
//        case ProductCode
//        case ProductName, price, rating
//    }
}

struct Comment: Decodable {
    let message: String
}
