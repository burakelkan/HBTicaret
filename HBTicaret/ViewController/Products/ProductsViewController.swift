//
//  ProductsViewController.swift
//  HBTicaret
//
//  Created by halil ibrahim Elkan on 27.05.2022.
//

import UIKit

class ProductsViewController: BaseViewController {

    @IBOutlet private weak var collectionView: UICollectionView!
    
    private var products: [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
        
        let nib = UINib(nibName: "ProductCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "ProductCollectionViewCell")
        
        fetchProducts()
    }
    
    func fetchProducts() {
        
        let network = Network()
        
        network.request(endpointType: .products) { (result: Result<BaseResponse<[Product]>, CustomError>) in
            
            switch result {
                
            case .success(let response):
                
                self.products = response.result ?? []
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                
                
            case .failure(let error):
                Logger.log(text: error.message)
            }
        }
    }
}

extension ProductsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as! ProductCollectionViewCell
        cell.configure(with: products[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Logger.log(text: products[indexPath.row].productName ?? "isim bulunamadı !", type: .warning)
        
        guard let id = products[indexPath.row].id else { return }
        
        let productDetails = ProductDetailsViewController(productId: id)
        
        DispatchQueue.main.async {
            
            self.navigationController?.pushViewController(productDetails, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width: CGFloat = (self.view.frame.width - 30) / 2
        let height: CGFloat = width * 2
        
        return CGSize(width: width, height: height)
    }
}
