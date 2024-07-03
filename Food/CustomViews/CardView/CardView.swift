//
//  CardView.swift
//  Food
//
//  Created by APPLE on 16/05/2023.
//

import UIKit

class CardView:UIView {
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialSetup()
    }
    //Mark : - apply show on the view 
    private func initialSetup(){
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = .zero
        layer.cornerRadius = 10
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 10
        conerRadius = 10
        
    }
}
