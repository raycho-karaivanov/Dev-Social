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

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func facebookBtnPressed(_ sender: Any) {
        
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("RORO: Unable to authenticate with Facebook")
            } else if result?.isCancelled == true {
                print("RORO: User cancelled Facebook authentication ")
            } else {
                print("ROR: Successfully authenticated with Facebook")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
            }
        }
        
    }
    
    func firebaseAuth(_ credential: FIRAuthCredential) {
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
                print("RORO: Unable to authenticate with Firebase - \(error)"   )
            } else {
                print("RORO: Successfully authenticated with Firebase")
            }
        })
    }

    
    

}

