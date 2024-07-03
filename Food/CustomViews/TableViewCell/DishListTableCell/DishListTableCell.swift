//
//  DishListTableCellTableViewCell.swift
//  Food
//
//  Created by APPLE on 10/07/2023.
//

import UIKit

class DishListTableCell: UITableViewCell {
    
    static let identifier = "DishListTableCell"
    
    @IBOutlet var dishImageView: UIImageView!
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var descriptionLbl: UILabel!
    
    func Setup(dish:Dishes){
        
        dishImageView.kf.setImage(with: dish.image?.asUrl )
        titleLbl.text = dish.name
        descriptionLbl.text = dish.description
    }
    
    func Setup(order:Orders){
        
        dishImageView.kf.setImage(with: order.dish?.image?.asUrl )
        titleLbl.text = order.dish?.name
        descriptionLbl.text = order.name
    }
    
}
