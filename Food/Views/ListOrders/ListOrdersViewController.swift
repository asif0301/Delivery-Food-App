//
//  ListOrdersViewController.swift
//  Food
//
//  Created by APPLE on 11/07/2023.
//

import UIKit
import ProgressHUD

class ListOrdersViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var orders : [Orders] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Orders"
        registerCelss()
        ProgressHUD.show()
    }
    override func viewDidAppear(_ animated: Bool) {
        
        NetworkService.shared.fetchOrder {[weak self] (result) in
            switch result {
                
            case .success(let orders):
                ProgressHUD .dismiss()
                self?.orders = orders
                self?.tableView.reloadData()
            case .failure(let error):
                ProgressHUD .showError(error.localizedDescription)
            }
        }
    }
    
    private func registerCelss() {
        tableView.register(UINib(nibName: DishListTableCell.identifier, bundle: nil), forCellReuseIdentifier: DishListTableCell.identifier)
    }
}
extension ListOrdersViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: DishListTableCell.identifier) as! DishListTableCell
        cell.Setup(order: orders[indexPath.row])
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = DishDetailViewController.instatiate()
        controller.dish = orders[indexPath.row].dish
        navigationController?.pushViewController(controller, animated: true)
    }
}
