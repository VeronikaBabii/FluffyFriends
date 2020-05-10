//
//  SignUpViewController.swift
//  FluffyFriends
//
//  Created by Veronika Babii on 05.05.2020.
//  Copyright © 2020 Veronika Babii. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class SignUpViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
    }
    
    func setUpElements() {
        errorLabel.alpha = 0
        
        Utilities.styleTextField(firstNameTextField)
        Utilities.styleTextField(lastNameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(signUpButton)
    }
    
    // check the fields and validate that the data is correct.
       // if everything is correct - return nil (optional type). otherwise, return error message. (method return optional String)
       func validateFields() -> String? {
           
           // check that all fields are filled in
           // if when we get rid of all white spaces and new lines in a field and still have "" (any of fields are empty), then return error
           if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
               lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
               emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
               passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
               return "Please fill in all fields!"
           }
           
           // check if the password is secure ( ! is unwrapper from ?, means that there is a text for sure)
           let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
           
           // password isn't secure enough
           if Utilities.isPasswordValid(cleanedPassword) == false {
               return "Please make sure your password is at least 8 characters, contains a special character and a number!"
           }
           return nil
       }
       
       @IBAction func signUpTapped(_ sender: Any) {
           
           let error = validateFields()
           
           if error != nil {
               showError(error!)
           } else {
               
               // create cleaned versions of the data
               let firstname = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
               let lastname = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
               let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
               let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
               
               Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                   if err != nil  {
                       self.showError("Error creating user!")
                   } else {
                       let db = Firestore.firestore()
                       
                       // push user data to the db
                       db.collection("users").document(result!.user.uid).setData([
                           "firstname":firstname,
                           "lastname":lastname,
                           "uid":result!.user.uid]) { (error) in
                               if error != nil  { self.showError("Error saving user data!") }
                       }
                       self.transitionToHome()
                   }
               }
           }
       }
       
       @IBAction func backButtonTapped(_ sender: Any) {
           let mainVC = storyboard?.instantiateViewController(identifier: Constants.Storyboard.mainViewController) as? ViewController
           
           view.window?.rootViewController = mainVC
           view.window?.makeKeyAndVisible()
       }
       
       func showError(_ message:String) {
           errorLabel.text = message // show error message in our label
           errorLabel.alpha = 1 // visible
       }
       
       // method to go to the home screen (sign rootVC to any other VC we're now)
       func transitionToHome() {
           // reference to TabBarViewController (this returns view controller, so we cast it as (?as) TabBarViewController type)
           let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? TabBarViewController
           
           // swap - sign homeVC to the rootVC
           view.window?.rootViewController = homeViewController
           // show homeVC as rootVC instead
           view.window?.makeKeyAndVisible()
       }

}