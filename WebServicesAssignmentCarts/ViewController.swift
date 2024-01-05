//
//  ViewController.swift
//  WebServicesAssignmentCarts
//
//  Created by Mac on 30/12/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cartsCollectionView: UICollectionView!
    var cartsCollectionViewCell : CartsCollectionViewCell?
    var cartsDetailViewController : CartsDetailViewController?
    
    var carts : [Carts] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerXIBWithCollectionView()
        dataFetchingFromAPI()
        initializeCollectionView()
    }
    
    func registerXIBWithCollectionView()
    {
        cartsCollectionView.dataSource = self
        cartsCollectionView.delegate = self
    }
    func initializeCollectionView()
    {
        let uinib = UINib(nibName: "CartsCollectionViewCell", bundle: nil)
        cartsCollectionView.register(uinib, forCellWithReuseIdentifier: "CartsCollectionViewCell")
    }
    
    func dataFetchingFromAPI(){
        let url = URL(string: "https://fakestoreapi.com/carts#")
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "GET"
        let urlSesson = URLSession(configuration: .default)
        var urlDataTask = urlSesson.dataTask(with: urlRequest) { data, response , error in
            let urlResponse = try! JSONSerialization.jsonObject(with: data!) as! [[String : Any]]
            
            for eachResponse in urlResponse
            {
                let cartDictonary = eachResponse as! [String : Any]
                let cartId = cartDictonary["id"] as! Int
                let cartUserid = cartDictonary["userId"] as! Int
                let cartDate = cartDictonary["date"] as! String
                let cartProduct = cartDictonary["products"] as! [[String:Any]]
                
                for productsResponse in cartProduct
                {
                  let cartProductId = productsResponse["productId"] as! Int
                    let cartQuantity = productsResponse["quantity"] as! Int
                    
                    let productsObject = Product(productId: cartProductId, quantity: cartQuantity)
                    let cartObject = Carts(id: cartId, userId: cartUserid, date: cartDate, products: [productsObject])
                    self.carts.append(cartObject)
                    
                }
                DispatchQueue.main.async {
                    self.cartsCollectionView.reloadData()
                }
            }
            
        }
        urlDataTask.resume()
    }

}
extension ViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        carts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cartsCollectionViewCell = self.cartsCollectionView.dequeueReusableCell(withReuseIdentifier: "CartsCollectionViewCell", for: indexPath) as! CartsCollectionViewCell
        cartsCollectionViewCell.userIdLabel.text = String(carts[indexPath.item].userId)
        for i in 0...carts[indexPath.item].products.count-1{
            cartsCollectionViewCell.userIdLabel.text = carts[indexPath.item].products[i].productId.codingKey.stringValue
            cartsCollectionViewCell.quantityLabel.text = carts[indexPath.item].products[i].productId.codingKey.stringValue
        }
        return cartsCollectionViewCell
    }
}
extension ViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        cartsDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "CartsDetailViewController") as! CartsDetailViewController
        cartsDetailViewController?.cartsDetailsContainer = carts[indexPath.item]
        navigationController?.pushViewController(cartsDetailViewController!, animated: true)
    }
}

extension ViewController : UICollectionViewDelegateFlowLayout{
    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let flowlayout = collectionViewLayout as! UICollectionViewFlowLayout
            
            let spaceBetweenTheCells : CGFloat = (flowlayout.minimumInteritemSpacing ?? 0.0) + (flowlayout.sectionInset.left ?? 0.0) + (flowlayout.sectionInset.right ?? 0.0)
            
            let size = (cartsCollectionView.frame.width - spaceBetweenTheCells) / 2.0
            
            return CGSize(width: size, height: size)
    }
}
