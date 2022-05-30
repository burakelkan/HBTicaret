//
//  CartTableViewCell.swift
//  HBTicaret
//
//  Created by halil ibrahim Elkan on 27.05.2022.
//

import UIKit

class CartTableViewCell: UITableViewCell {

    @IBOutlet private weak var productImageView: UIImageView!
    @IBOutlet private weak var productNameLabel: UILabel!
    @IBOutlet private weak var productPriceLabel: UILabel!
    
    var onActionRemoveButton: (() -> Void)?
    
    func configure(with product: Product) {
        
        self.productImageView.setImage(with: product.productImage)
        self.productNameLabel.text = product.productName
        self.productPriceLabel.text = product.newPrice?.toStringWithCurrency
    }
    
    @IBAction func actionRemoveButton(_ sender: UIButton) {
        Logger.log(text: #function)
        self.onActionRemoveButton?()
    }
}
