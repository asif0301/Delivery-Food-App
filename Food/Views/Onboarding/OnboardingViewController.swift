//
//  OnboardingViewController.swift
//  Food
//
//  Created by APPLE on 12/05/2023.
//

import UIKit

class OnboardingViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var pageController: UIPageControl!
    @IBOutlet var nextBtn: UIButton!
    
    var Sildes : [OnboardingSlide] = []
    var currentPage = 0 {
        didSet {
            pageController.currentPage = currentPage
            if currentPage == Sildes.count - 1 {
                nextBtn.setTitle("Get started", for: .normal)
            } else {
                nextBtn.setTitle("Next", for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        Sildes = [
            OnboardingSlide(title: "Delicious Dishes", descrition: "Experience a variety of amazing dishes from different cultures around the world.", image: UIImage(imageLiteralResourceName: "slide1")),
            
            OnboardingSlide(title: "World-Class Chefs", descrition: "Our dishes are prepared by only the best.", image: UIImage(imageLiteralResourceName: "slide2")),
                            
            OnboardingSlide(title: "Instant World-Wide Delivery", descrition: "Your orders will be delivered instantly irrespective of your location around the world.", image:UIImage(imageLiteralResourceName: "slide3") )
        ]
        pageController.numberOfPages =  Sildes.count
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    @IBAction func nextBtnClicked(_ sender: UIButton) {
        
        if currentPage == Sildes.count - 1 {
            let controller = storyboard?.instantiateViewController(withIdentifier: "HomeNC") as! UINavigationController
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .flipHorizontal
            present(controller, animated: true, completion: nil)

            
        }else{
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
}
extension OnboardingViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Sildes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnBoardingCollectionViewCell.identifier , for: indexPath) as! OnBoardingCollectionViewCell
        
        cell.setup(Sildes[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:collectionView.frame.width , height: collectionView.frame.height)
    }
    //MARK : - rotation of page dot
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x/width)
       
    }
}
