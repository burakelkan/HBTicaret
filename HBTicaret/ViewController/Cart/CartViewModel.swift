//
//  CartViewModel.swift
//  HBTicaret
//
//  Created by halil ibrahim Elkan on 27.05.2022.
//

import Foundation

protocol CartViewModelDelegate {
    
    func didFinishNetworkOperations()
    
    func didRetrieveError(_ error: Error)
    
    func didSuccessBuyCart()
}

class CartViewModel {
    
    private let network = Network()
    var products: [Product] = []
    var delegate: CartViewModelDelegate?
    
    func fetchProducts() {
        
        network.request(endpointType: .cart) { (result: Result<BaseResponse<CartResponse>, CustomError>) in
            
            self.didRetrieveResult(result)
        }
    }
    
    func buyCart() {
        
        network.request(endpointType: .clearCart) { (result: Result<BaseResponse<CartResponse>, CustomError>) in
            
            self.didRetrieveResult(result)
            self.delegate?.didSuccessBuyCart()
        }
    }
    
    func removeProduct(id: Int) {
        
        network.request(endpointType: .removeProduct(id: id)) { (result: Result<BaseResponse<CartResponse>, CustomError>) in
            
            self.didRetrieveResult(result)
        }
    }
    
    private func didRetrieveResult(_ result: Result<BaseResponse<CartResponse>, CustomError>) {
        
        switch result {
            
        case .failure(let error):
            self.delegate?.didRetrieveError(error)
            
        case .success(let response):
            self.products = response.result?.products ?? []
            self.delegate?.didFinishNetworkOperations()
        }
    }
}
