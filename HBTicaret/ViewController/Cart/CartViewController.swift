//
//  CartViewController.swift
//  HBTicaret
//
//  Created by halil ibrahim Elkan on 27.05.2022.
//

import UIKit

class CartViewController: BaseViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    private let viewModel = CartViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "CartTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CartTableViewCell")
        
        tableView.dataSource = self
        tableView.delegate = self
        
        viewModel.delegate = self
        
        viewModel.fetchProducts()
    }
    
    @IBAction private func actionBuyButton(_ sender: UIButton) {
        
        viewModel.buyCart()
    }
}

extension CartViewController: CartViewModelDelegate {
    
    func didFinishNetworkOperations() {
        
        DispatchQueue.main.async {
            
            self.tableView.reloadData()
        }
    }
    
    func didRetrieveError(_ error: Error) {
        Logger.log(text: error.localizedDescription)
    }
    
    func didSuccessBuyCart() {
        
        DispatchQueue.main.async {
            
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
}

extension CartViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartTableViewCell") as! CartTableViewCell
        
        let product = viewModel.products[indexPath.row]
        
        cell.configure(with: product)
        
        cell.onActionRemoveButton = {
            
            guard let id = product.id else { return }
            
            self.viewModel.removeProduct(id: id)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}
