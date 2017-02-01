//
//  SignInVC.swift
//  Dev-Social
//
//  Created by Raycho Karaivanov on 30/01/2017.
//  Copyright © 2017 Raycho Karaivanov. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase

class SignInVC: UIViewController {

    @IBOutlet weak var emailField: FancyField!
    @IBOutlet weak var pwdField: FancyField!
    @IBOutlet weak var fancyStackView: UIStackView!
    @IBOutlet weak var fancyStackTop: NSLayoutConstraint!
    @IBOutlet weak var signInBtn: FancyBtn!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        emailField.addTarget(self, action: #selector(moveViewUp(_:)), for: .editingDidBegin)
        pwdField.addTarget(self, action: #selector(moveViewUp(_:)), for: .editingDidBegin)

        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        
    }
    
    func dismissKeyboard() {
        
        view.endEditing(true)
        if fancyStackTop.constant == -100 {
            fancyStackTop.constant = 0.0
        }
    }
    
   
    
    func moveViewUp(_ textField: UITextField) {
        
        fancyStackTop.constant = -100
    }
    
    
    
    @IBAction func facebookBtnPressed(_ sender: Any) {
        
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("RORO: Unable to authenticate with Facebook \(error?.localizedDescription)")
            } else if result?.isCancelled == true {
                print("RORO: User cancelled Facebook authentication ")
            } else {
                print("RORO: Successfully authenticated with Facebook")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
            }
        }
        
    }
    
    func firebaseAuth(_ credential: FIRAuthCredential) {
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
                print("RORO: Unable to authenticate with Firebase - \(error?.localizedDescription)"   )
            } else {
                print("RORO: Successfully authenticated with Firebase")
            }
        })
    }

    @IBAction func signInBtnPressed(_ sender: Any) {
        
        if let email = emailField.text, let pwd = pwdField.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: pwd, completion: { (user, error) in
                if error == nil {
                    print("RORO: Email User authenticated with Firebase")
                } else {
                    FIRAuth.auth()?.createUser(withEmail: email, password: pwd, completion: { (user, error) in
                        if error != nil {
                            
                            print("RORO: Unable to authenticate with Firebase using email: \(error?.localizedDescription)")
                        } else {
                            print("RORO: Successfully authenticated with Firebase")
                        }
                    })
                }
            })
        }
    }
    
    

}

