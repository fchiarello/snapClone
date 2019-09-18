//
//  CadastroViewController.swift
//  SnapchatClone
//
//  Created by Fellipe Ricciardi Chiarello on 16/09/19.
//  Copyright © 2019 Fellipe Ricciardi Chiarello. All rights reserved.
//

import UIKit
import Firebase

class CadastroViewController: UIViewController {
    
    @IBOutlet weak var emailCadastro: UITextField!
    
    @IBOutlet weak var senhaCadastro: UITextField!
    
    @IBOutlet weak var confirmaSenhaCadastro: UITextField!
    
    func exibirMensagem() {
        let alerta = UIAlertController(title: "Dados Inválidos", message: "Senha e Confirmação de Senha são diferentes!", preferredStyle: .alert)
        let acaoCancelar = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alerta.addAction(acaoCancelar)
        present(alerta, animated: true, completion: nil)
    }
    
    @IBAction func cadastrarCadastro(_ sender: Any) {
        if let emailR = self.emailCadastro.text{
            if let senhaR = self.senhaCadastro.text{
                if let confirmaR = self.confirmaSenhaCadastro.text{
                    if senhaR == confirmaR{
                        let autenticacao = Auth.auth()
                        autenticacao.createUser(withEmail: emailR, password: senhaR) { (usuario, erro) in
                            if erro == nil {
                                print("Autenticado!")
                            }else{
                                let erroR = erro! as NSError
                                //ERROR_INVALID_EMAIL
                                //ERROR_WEAK_PASSWORD
                                //ERROR_EMAIL_ALREADY_IN_USE
                                if let codigoErro = erroR.userInfo{
                                    let erroTexto = codigoErro as! String
                                    if codigoErro == "ERROR_INVALID_EMAIL"{
                                        
                                    }else if erroTexto == "ERROR_WEAK_PASSWORD"
                                }
                            }
                        }
                    }else{
                        self.exibirMensagem()
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
