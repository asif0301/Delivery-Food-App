//
//  OnBoardingCollectionViewCell.swift
//  Food
//
//  Created by APPLE on 12/05/2023.
//

import UIKit

class OnBoardingCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: OnBoardingCollectionViewCell.self)
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var slideTitleLbl: UILabel!
    @IBOutlet var slideDescription: UILabel!
    
    func setup(_ slide: OnboardingSlide){
        imageView.image = slide.image
        slideTitleLbl.text = slide.title
        slideDescription.text = slide.descrition
        
    }
    
}
