//
//  DishLandscapeCollectionView.swift
//  Food
//
//  Created by APPLE on 16/05/2023.
//

import UIKit

class DishLandscapeCollectionView: UICollectionViewCell {
    
    static let identifire = String(describing: DishLandscapeCollectionView.self)

    @IBOutlet var dishImageView: UIImageView!
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var descriptionLbl: UILabel!
    @IBOutlet var caloriesLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(dish:Dishes) {
        
        dishImageView.kf.setImage(with: dish.image?.asUrl)
        titleLbl.text = dish.name
        descriptionLbl.text = dish.description
        caloriesLbl.text = dish.formattedCalories
                
    }

}
