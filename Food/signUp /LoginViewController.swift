//
//  LoginViewController.swift
//  Food
//
//  Created by APPLE on 24/08/2023.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

class LoginViewController: UIViewController {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var logInBtn: UIButton!
  
    //MARK: Variable and properties
    var iconClick = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpElements()
    }
    

    func setUpElements() {

        // Style the elements
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(logInBtn)
        
    }

    @IBAction func LogInBtnTapped(_ sender: Any) {
        
        // TODO: Validate Text Fields
        guard let email = emailTextField.text , email != "" else{
            showAlert(title: "Email", message: "Please enter email")
            return
        }
        guard let password = passwordTextField.text , password != "" else{
            showAlert(title: "Password", message: "Please enter password")
            return
        }
        
        // Signing in the user
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            if let error = error {
                // Handle signup error
                print("signIn error: \(error.localizedDescription)")
            }
            else {
                
                let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? OnboardingViewController
                
                self.view.window?.rootViewController = homeViewController
                self.view.window?.makeKeyAndVisible()
            }
        }
    }
    
    @IBAction func showPasswordBtn(_ sender: UIButton) {
        if (iconClick == true){
            passwordTextField.isSecureTextEntry = false
            sender.setImage(#imageLiteral(resourceName:"showEye"), for: .normal)
        }else {
            passwordTextField.isSecureTextEntry = true
            sender.setImage(#imageLiteral(resourceName:"hiddenEye"), for: .normal)
        }
        iconClick = !iconClick
    }
}
