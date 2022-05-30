//
//  PopupViewController.swift
//  HBTicaret
//
//  Created by halil ibrahim Elkan on 27.05.2022.
//

import UIKit

class PopupViewController: UIViewController {

    @IBOutlet private weak var titleLabel: UILabel!
    
    private let text: String
    private let actionButton: () -> Void
    
    init(text: String, actionButton: @escaping () -> Void) {
        self.text = text
        self.actionButton = actionButton
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.titleLabel.text = text
    }

    @IBAction private func actionOkButton(_ sender: UIButton) {
        self.dismiss(animated: true)
        actionButton()
    }
}
