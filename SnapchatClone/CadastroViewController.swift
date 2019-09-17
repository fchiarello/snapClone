//
//  CadastroViewController.swift
//  SnapchatClone
//
//  Created by Fellipe Ricciardi Chiarello on 16/09/19.
//  Copyright © 2019 Fellipe Ricciardi Chiarello. All rights reserved.
//

import UIKit

class CadastroViewController: UIViewController {
    
    @IBOutlet weak var emailCadastro: UITextField!
    
    @IBOutlet weak var senhaCadastro: UITextField!
    
    @IBOutlet weak var confirmaSenhaCadastro: UITextField!
    
    @IBAction func cadastrarCadastro(_ sender: Any) {
        if let emailR = self.emailCadastro.text{
            if let senhaR = self.senhaCadastro.text{
                if let confirmaR = self.confirmaSenhaCadastro.text{
                    if senhaR == confirmaR{
                        print("Cadastro ok")
                    }else{
                        print("Erro Cadastro!")
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setuoBarButtonItems()
       
    }
    
    func setuoBarButtonItems() {
//        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(voltarControllerInicial))
//        navigationItem.leftBarButtonItem = backButton
        let backButton = UIBarButtonItem(title: "back", style: .done, target: self, action: #selector(voltarControllerInicial))
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc func voltarControllerInicial () {
        self.navigationController?.popViewController(animated: true)
        print("VOLTOU")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

}
