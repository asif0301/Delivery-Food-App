//
//  HomeViewController.swift
//  Food
//
//  Created by APPLE on 15/05/2023.
//

import UIKit
import ProgressHUD
class HomeViewController: UIViewController {

    @IBOutlet var categoryCollectionView: UICollectionView!
    @IBOutlet var popularCollectionView: UICollectionView!
    @IBOutlet var specialCollectionView: UICollectionView!
    
    
    
    var categories : [DishCategory] = []
    
    var popular :[Dishes] = []
    
    var special:[Dishes] = [
//        .init(id: "101", name: "Emmanul", image: "https://picsum.photos/100/200", description: "This are best I have ever test", calories: 25)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        popularCollectionView.delegate = self
        popularCollectionView.dataSource = self
        specialCollectionView.dataSource = self
        specialCollectionView.delegate = self
        registeredCell()
        
        ProgressHUD.show()
        NetworkService.shared.fetchAllCategories { [weak self] (result) in
            switch result {
                
            case .success(let allDishes):
                ProgressHUD.dismiss()
                self?.categories = allDishes.categories ?? []
                self?.popular = allDishes.populars ?? []
               self?.special = allDishes.specials ?? []
                
                self?.categoryCollectionView.reloadData()
                self?.popularCollectionView.reloadData()
                self?.specialCollectionView.reloadData()
            case .failure(let error):
                ProgressHUD.showError(error.localizedDescription)
            }
        }
        
//        NetworkService.shared.myFirstRequest { (result) in
//            switch result {
//            case .success(let data):
//                for dish in data {
//                    print(dish.name ?? "")
//                }
//            case .failure(let error):
//                print("The error is: \(error.localizedDescription)")
//            }
//        }
    }
    private func registeredCell() {
        
        categoryCollectionView.register(UINib(nibName: CategoryCollectionViewCell.identifire, bundle: nil), forCellWithReuseIdentifier: CategoryCollectionViewCell.identifire)
        
        popularCollectionView.register(UINib(nibName: DishPortraitCollectionViewCell.identifire, bundle: nil), forCellWithReuseIdentifier: DishPortraitCollectionViewCell.identifire)
        
        specialCollectionView.register(UINib(nibName: DishLandscapeCollectionView.identifire, bundle: nil), forCellWithReuseIdentifier: DishLandscapeCollectionView.identifire)
    }

}

extension HomeViewController : UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
  //MARK: - switch mulitple Arrary data
        switch collectionView {
        case categoryCollectionView:
            return categories.count
        case popularCollectionView:
            return popular.count
        case specialCollectionView:
            return special.count
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //MARK: - switch mulitple collectionView cell
        switch collectionView {
        case categoryCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifire, for: indexPath) as! CategoryCollectionViewCell
            cell.setup(category:categories[indexPath.row] )
            return cell
        case popularCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DishPortraitCollectionViewCell.identifire, for: indexPath) as! DishPortraitCollectionViewCell
            cell.setup(dish: popular[indexPath.row] )
            return cell
        case specialCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DishLandscapeCollectionView.identifire, for: indexPath) as! DishLandscapeCollectionView
            cell.setup(dish: special[indexPath.row])
            return cell
        default: return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == categoryCollectionView {
            let controller = ListDishesViewController.instatiate()
            controller.category = categories[indexPath.row]
            navigationController?.pushViewController(controller, animated: true)
        }else {
            let controller = DishDetailViewController.instatiate()
            controller.dish = collectionView == popularCollectionView ? popular[indexPath.row] : special[indexPath.row]
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    
}
