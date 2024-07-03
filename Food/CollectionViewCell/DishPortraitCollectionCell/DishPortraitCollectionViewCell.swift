//
//  DishPortraitCollectionViewCell.swift
//  Food
//
//  Created by APPLE on 16/05/2023.
//

import UIKit

class DishPortraitCollectionViewCell: UICollectionViewCell {

    static let identifire = String(describing: DishPortraitCollectionViewCell.self )
    
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var dishImageView: UIImageView!
    @IBOutlet var caloriesLbl: UILabel!
    @IBOutlet var descriptionLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(dish: Dishes) {
        
        titleLbl.text = dish.name
        descriptionLbl.text = dish.description
        caloriesLbl.text = dish.formattedCalories
        dishImageView.kf.setImage(with: dish.image?.asUrl)
        
    }

}
