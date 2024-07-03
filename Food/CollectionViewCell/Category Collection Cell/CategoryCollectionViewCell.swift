//
//  CategoryCollectionViewCell.swift
//  Food
//
//  Created by APPLE on 16/05/2023.
//

import UIKit
import Kingfisher

class CategoryCollectionViewCell: UICollectionViewCell {
    
    static let identifire = String(describing: CategoryCollectionViewCell.self )

    @IBOutlet var categorytitleLbl: UILabel!
    @IBOutlet var categoryImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setup(category:DishCategory) {
       
        categorytitleLbl.text = category.name
        categoryImageView.kf.setImage(with: category.image?.asUrl)
    }
}
