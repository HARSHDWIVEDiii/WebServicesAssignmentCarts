//
//  Carts.swift
//  WebServicesAssignmentCarts
//
//  Created by Mac on 30/12/23.
//

import Foundation
struct Carts {
    var id : Int
    var userId : Int
    var date : String
    var products : [Product]
}

struct Product {
    var productId : Int
    var quantity : Int
}
