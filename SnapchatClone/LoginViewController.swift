//
//  LoginViewController.swift
//  SnapchatClone
//
//  Created by Fellipe Ricciardi Chiarello on 16/09/19.
//  Copyright © 2019 Fellipe Ricciardi Chiarello. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailLogin: UITextField!
    
    @IBOutlet weak var senhaLogin: UITextField!
    @IBOutlet weak var btnClose: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func entrarLogin(_ sender: Any) {
        
    }
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
