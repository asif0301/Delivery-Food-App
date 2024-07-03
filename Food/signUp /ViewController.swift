//
//  ViewController.swift
//  Food
//
//  Created by APPLE on 24/08/2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var signUpBtn: UIButton!
    @IBOutlet var logInBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        signUpBtn.layer.cornerRadius = 30
        logInBtn.layer.cornerRadius = 30
    }
    
    @IBAction func signUpBtnTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "signUpViewController")as! signUpViewController
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func logInUpBtnTapped(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true, completion: nil)
    }
  

}
