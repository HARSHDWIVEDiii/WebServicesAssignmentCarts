//
//  CartsDetailViewController.swift
//  WebServicesAssignmentCarts
//
//  Created by Mac on 30/12/23.
//

import UIKit

class CartsDetailViewController: UIViewController {
    
    
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var productIdLabel: UILabel!
    
    @IBOutlet weak var quantityLabel: UILabel!
    var cartsDetailsContainer : Carts?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindingData()
    }
    func bindingData(){
        self.idLabel.text = cartsDetailsContainer?.id.description.codingKey.stringValue
        self.userIdLabel.text = cartsDetailsContainer?.userId.description.codingKey.stringValue
        self.dateLabel.text = cartsDetailsContainer?.date.description.codingKey.stringValue
        
        for i in 0...((cartsDetailsContainer?.products.count)!-1){
            self.productIdLabel.text = (cartsDetailsContainer?.products[i].productId.codingKey.stringValue)
            self.quantityLabel.text = (cartsDetailsContainer?.products[i].quantity.codingKey.stringValue)
        }
    }
}
