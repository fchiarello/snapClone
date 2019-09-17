//
//  ViewController.swift
//  SnapchatClone
//
//  Created by Fellipe Ricciardi Chiarello on 16/09/19.
//  Copyright © 2019 Fellipe Ricciardi Chiarello. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(voltarControllerInicial))
//        navigationItem.leftBarButtonItem = backButton
    }

//    @objc func voltarControllerInicial () {
//        print("VOLTOU")
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @IBAction func loginUsuario(_ sender: Any) {
        let loginViewController = LoginViewController.init(nibName: "LoginViewController", bundle: nil)
        navigationController?.pushViewController(loginViewController, animated: true)
    }
    
    
    
    
    @IBAction func cadastroUsuario(_ sender: Any) {
//        let cadastroViewController = CadastroViewController.init(nibName: "CadastroViewController", bundle: nil)
//        self.present(cadastroViewController, animated: true, completion: nil)
        let cadastroUsuario = CadastroViewController.init(nibName: "CadastroViewController", bundle: nil)
        navigationController?.pushViewController(cadastroUsuario, animated: true)
        
    }


}

