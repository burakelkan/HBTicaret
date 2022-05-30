//
//  ProductDetailsViewController.swift
//  HBTicaret
//
//  Created by halil ibrahim Elkan on 27.05.2022.
//

import UIKit

class ProductDetailsViewController: BaseViewController {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    
    private let id: Int
    
    private let network = Network()
    
    init(productId: Int) {
        self.id = productId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchProductDetails()
    }
    
    private func fetchProductDetails() {
        
        network.request(endpointType: .productDetails(id: self.id)) { (result: Result<BaseResponse<Product>, CustomError>) in
            
            switch result {
                
            case .failure(let error):
                Logger.log(text: error.message)
                
            case .success(let response):
                
                DispatchQueue.main.async {
                    
                    self.imageView.setImage(with: response.result?.productImage)
                    self.nameLabel.text = response.result?.productName
                    self.priceLabel.text = response.result?.newPrice?.toStringWithCurrency
                }
            }
        }
        
        
    }
    
    @IBAction private func actionStoresButton(_ sender: UIButton) {
        
        DispatchQueue.main.async {
            
            let stores = StoresViewController()
            self.navigationController?.pushViewController(stores, animated: true)
        }
    }
    
    @IBAction private func actionAddToCartButton(_ sender: UIButton) {
        
        network.request(endpointType: .addToCart(productId: id)) { (result: Result<BaseResponse<CartResponse>, CustomError>) in
            
            switch result {
                
            case .failure(let error):
                Logger.log(text: error.message)
                
            case .success(let response):
                
                DispatchQueue.main.async {
                    
                    let popup = PopupViewController(text: "Ürününüz sepetinize başarılı bir şekilde eklendi.", actionButton: self.actionOKButton)
                    popup.modalTransitionStyle = .crossDissolve
                    popup.modalPresentationStyle = .overCurrentContext
                    self.navigationController?.present(popup, animated: true, completion: nil)
                }
            }
        }
    }
    
    private func actionOKButton() {
        
        DispatchQueue.main.async {
            
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
}
