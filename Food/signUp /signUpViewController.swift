//
//  signUpViewController.swift
//  Food
//
//  Created by APPLE on 24/08/2023.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore


class signUpViewController: UIViewController {
    
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var signUpBtn: UIButton!

    //MARK: Variable and properties
    var iconClick = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()
    }
    func setUpElements() {
        
        // Hide the error label
        //  errorLbl.alpha = 0
        
        // Style the elements
        Utilities.styleTextField(firstNameTextField)
        Utilities.styleTextField(lastNameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(signUpBtn)
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    func isPasswordValid(_ password : String) -> Bool {
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    @IBAction func SignUpBtnTapped(_ sender: Any) {
        
        guard let firstName = firstNameTextField.text,firstName != "" else {
            showAlert(title: "First Name", message: "Please enter firstName")
            return
        }
        guard let lastName = lastNameTextField.text,lastName != "" else {
            showAlert(title: "First Name", message: "Please enter firstName")
            return
        }
        guard let email = emailTextField.text, email != "" else {
            self.showAlert(title: "Email", message: "Please enter email")
            return  }
        if !self.isValidEmail(email) {
            self.showAlert(title: "Email", message: "invalid email formate")
            return }
        
        guard let password = passwordTextField.text, password != "" else {
            self.showAlert(title: "Password", message: "Please enter password")
            return }
        if !self.isPasswordValid(password) {
            self.showAlert(title: "Password", message: "invalid Password formate")
            return }
        
        if password.count < 8 {
            self.showAlert(title: "Password", message: "password must have 8 characters")
            return
        }
        
        // Create the user
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            // Check for errors
            if let error = error {
                // Handle signup error
                print("Signup error: \(error.localizedDescription)")
            } else {
                
                // User was created successfully, now store the first name and last name
                let db = Firestore.firestore()
                
                db.collection("users").addDocument(data: ["firstname":firstName, "lastname":lastName, "uid": result!.user.uid ]) { (error) in
                    if let error = error {
                        print("Error saving user data: \(error.localizedDescription)")
                    }
                }
                self.transitionToHome()
            }
        }
    }
    
    
    func transitionToHome() {
        
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? OnboardingViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
        
    }
    @IBAction func showPasswordTappedBtn(_ sender: UIButton) {
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

extension UIViewController {
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message:
                                                    message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
        }))
        self.present(alertController, animated: true, completion: nil)
    }
}
