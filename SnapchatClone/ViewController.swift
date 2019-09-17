//
//  ViewController.swift
//  SnapchatClone
//
//  Created by Fellipe Ricciardi Chiarello on 16/09/19.
//  Copyright © 2019 Fellipe Ricciardi Chiarello. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    @IBAction func loginUsuario(_ sender: Any) {
        let loginViewController = LoginViewController.init(nibName: "LoginViewController", bundle: nil)
        self .present(loginViewController, animated: true, completion: nil)
    }
    
    @IBAction func cadastroUsuario(_ sender: Any) {
        let cadastroViewController = CadastroViewController.init(nibName: "CadastroViewController", bundle: nil)
        self .present(cadastroViewController, animated: true, completion: nil)
    }
    
    
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


}

