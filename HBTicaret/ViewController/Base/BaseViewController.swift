//
//  BaseViewController.swift
//  HBTicaret
//
//  Created by halil ibrahim Elkan on 27.05.2022.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.titleView = UIImageView(image: UIImage(named: "logo"))
        
        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButton
        navigationItem.backBarButtonItem?.tintColor = UIColor.black
        
        let cartButton = UIBarButtonItem(image: UIImage(named: "basket"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.showCartPage))
        cartButton.tintColor = UIColor(named: "black")
        navigationItem.rightBarButtonItem = cartButton
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor.white
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    @objc private func showCartPage() {
        Logger.log(text: #function)
        
        DispatchQueue.main.async {
            
            let cartPage = CartViewController()
            self.navigationController?.pushViewController(cartPage, animated: true)
        }
    }
}
