//
//  ProductCollectionViewCell.swift
//  HBTicaret
//
//  Created by halil ibrahim Elkan on 27.05.2022.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var typeLabel: UILabel!
    @IBOutlet private weak var oldPriceLabel: UILabel!
    @IBOutlet private weak var newPriceLabel: UILabel!
    
    func configure(with product: Product) {
        
        nameLabel.text = product.productName
        typeLabel.text = product.type
        oldPriceLabel.text = product.oldPrice?.toStringWithCurrency
        newPriceLabel.text = product.newPrice?.toStringWithCurrency
        
        imageView.setImage(with: product.productImage)
    }
}
