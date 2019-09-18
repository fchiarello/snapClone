//
//  LoginViewController.swift
//  SnapchatClone
//
//  Created by Fellipe Ricciardi Chiarello on 16/09/19.
//  Copyright © 2019 Fellipe Ricciardi Chiarello. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailLogin: UITextField!
    
    @IBOutlet weak var senhaLogin: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    func exibirMensagem(titulo: String, mensagem: String) {
        let alerta = UIAlertController(title: titulo, message: mensagem, preferredStyle: .alert)
        let acaoCancelar = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alerta.addAction(acaoCancelar)
        present(alerta, animated: true, completion: nil)
    }
    
    @IBAction func entrarLogin(_ sender: Any) {
        if let emailR = self.emailLogin.text{
            if let senhaR = self.senhaLogin.text{
                let autenticacao = Auth.auth()
                autenticacao.signIn(withEmail: emailR, password: senhaR) { (usuario, erro) in
                    guard let erroR = erro as NSError? else{
                        print("Entrou!")
                        let snapsViewController = TabelaSnapsTableViewController.init(nibName: "TabelaSnapsTableViewController", bundle: nil)
                        self.navigationController?.pushViewController(snapsViewController, animated: true)
                        return
                    }
                    guard let erroTexto = erroR.localizedDescription as? String else{
                        return
                    }
                    var mensagemErro = ""
                    switch erroTexto {
                    case "The email address is badly formatted.":
                        mensagemErro = "E-mail digitado não é válido."
                        break
                    case "The password is invalid or the user does not have a password.":
                        mensagemErro = "Sua senha está incorreta!"
                        break
                    default:
                        mensagemErro = "Tentativa de acesso inválido"
                    }
                    self.exibirMensagem(titulo: "Dados inválidos!", mensagem: mensagemErro)
                }
            }
        }
        
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
