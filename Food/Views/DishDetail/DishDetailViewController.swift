////
////  DishDetailViewController.swift
////  Food
////
////  Created by APPLE on 17/05/2023.
////
//
//import UIKit
//import ProgressHUD
//
//class DishDetailViewController: UIViewController {
//
//    @IBOutlet var dishImageView: UIImageView!
//    @IBOutlet var caloriesLbl: UILabel!
//    @IBOutlet var titleLbl: UILabel!
//    @IBOutlet var descriptionLbl: UILabel!
//    @IBOutlet var nameTxtField: UITextField!
//
//    var dish : Dishes!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        populateView()
//    }
//
//    private func populateView(){
//        dishImageView.kf.setImage(with: dish.image?.asUrl)
//        titleLbl.text = dish.name
//        descriptionLbl.text = dish.description
//        caloriesLbl.text = dish.formattedCalories
//    }
//
//    @IBAction func placeOrderBtnClick(_ sender: UIButton) {
//
//        guard let name = nameTxtField.text?.trimmingCharacters(in: .whitespaces),!name.isEmpty else {
//            ProgressHUD.showError("Please enter your name")
//            return
//        }
//        ProgressHUD.show("Placing Order...")
//        NetworkService.shared.placeOrder(dishId: dish.id ?? "", name: name) { (result) in
//            switch result {
//
//            case .success(_):
//                ProgressHUD.showSuccess("Your order has been received")
//            case .failure(let error):
//                ProgressHUD.showError(error.localizedDescription)
//            }
//        }
//    }
//}

import UIKit
import ProgressHUD

class DishDetailViewController: UIViewController {

    @IBOutlet var dishImageView: UIImageView!
    @IBOutlet var caloriesLbl: UILabel!
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var descriptionLbl: UILabel!
    @IBOutlet var nameTxtField: UITextField!
    
    var dish: Dishes!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateView()
    }
    
    private func populateView() {
        dishImageView.kf.setImage(with: dish.image?.asUrl)
        titleLbl.text = dish.name
        descriptionLbl.text = dish.description
        caloriesLbl.text = dish.formattedCalories
    }
    
    @IBAction func placeOrderBtnClick(_ sender: UIButton) {
        guard let name = nameTxtField.text?.trimmingCharacters(in: .whitespaces), !name.isEmpty else {
            ProgressHUD.showError("Please enter your name")
            return
        }
        ProgressHUD.show("Placing Order...")
        NetworkService.shared.placeOrder(dishId: dish.id ?? "", name: name) { (result) in
            switch result {
            case .success(_):
                ProgressHUD.showSuccess("Your order has been received")
            case .failure(let error):
                ProgressHUD.showError(error.localizedDescription)
            }
        }
    }
}

