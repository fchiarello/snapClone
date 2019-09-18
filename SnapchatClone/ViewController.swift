//
//  ViewController.swift
//  SnapchatClone
//
//  Created by Fellipe Ricciardi Chiarello on 16/09/19.
//  Copyright © 2019 Fellipe Ricciardi Chiarello. All rights reserved.
//

import UIKit
import Foundation
import Firebase

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let autenticacao = Auth.auth()
        autenticacao.addStateDidChangeListener { (autenticada, usuario) in
            

        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @IBAction func loginUsuario(_ sender: Any) {
        let loginViewController = LoginViewController.init(nibName: "LoginViewController", bundle: nil)
        navigationController?.pushViewController(loginViewController, animated: true)
    }
 
    @IBAction func cadastroUsuario(_ sender: Any) {
        let cadastroUsuario = CadastroViewController.init(nibName: "CadastroViewController", bundle: nil)
        navigationController?.pushViewController(cadastroUsuario, animated: true)
        
    }


}

