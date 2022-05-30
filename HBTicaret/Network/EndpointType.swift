//
//  EndpointType.swift
//  HBTicaret
//
//  Created by halil ibrahim Elkan on 27.05.2022.
//

import Foundation

enum EndpointType {
    
    case products
    case productDetails(id: Int)
    case cart
    case addToCart(productId: Int)
    case removeProduct(id: Int)
    case clearCart
    
    var endpoint: String {
        
        switch self {
        case .products:
            return "products"
        case .productDetails(let id):
            return "products/" + id.toString
        case .cart:
            return "cart/" + Network.cartId.toString
        case .addToCart(let productId):
            return "addtocart/" + Network.cartId.toString + "/" + productId.toString
        case .removeProduct(let id):
            return "removeproduct/" + Network.cartId.toString + "/" + id.toString
        case .clearCart:
            return "clearcart/" + Network.cartId.toString
        }
    }
    
    var method: HttpMethod {
        
        switch self {
        case .products:
            return .GET
        case .productDetails:
            return .GET
        case .cart:
            return .GET
        case .addToCart:
            return .POST
        case .removeProduct:
            return .GET
        case .clearCart:
            return .GET
        }
    }
}
