//
//  FeedVC.swift
//  Dev-Social
//
//  Created by Raycho Karaivanov on 04/02/2017.
//  Copyright © 2017 Raycho Karaivanov. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase

class FeedVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

  
    @IBAction func backBtnPressed(_ sender: Any) {
        
        let keychainResult = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        print("RORO: ID removed from keychain \(keychainResult)")

        try! FIRAuth.auth()?.signOut()
        
        performSegue(withIdentifier: "toSignInVC", sender: nil)
        
    }

}
