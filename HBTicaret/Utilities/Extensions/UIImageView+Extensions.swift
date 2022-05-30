//
//  UIImageView+Extensions.swift
//  HBTicaret
//
//  Created by halil ibrahim Elkan on 27.05.2022.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    
    func setImage(with imageUrl: String?) {
        
        guard let imageUrl = imageUrl,
              let url = URL(string: imageUrl) else { return }
        
        self.kf.setImage(with: url)
    }
}
