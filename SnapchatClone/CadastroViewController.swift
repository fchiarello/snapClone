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
    
    func exibirMensagem(titulo: String, mensagem: String) {
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
                                if let codigoErro = erroR.userInfo["error_name"]{
                                    let erroTexto = codigoErro as! String
                                    var mensagemErro = ""
                                    switch erroTexto {
                                    case "ERROR_INVALID_EMAIL":
                                        mensagemErro = "E-mail digitado não é válido."
                                        break
                                    case "ERROR_WEAK_PASSWORD":
                                        mensagemErro = "Senha fraca: Sua senha deve conter no mínimo 6 caracteres com letras e números!"
                                        break
                                    case "ERROR_EMAIL_ALREADY_IN_USE":
                                        mensagemErro = "E-mail já cadastrado"
                                        break
                                    default:
                                        mensagemErro = "Tentativa de acesso inválido"
                                    }
                                    self.exibirMensagem(titulo: "Dados inválidos!", mensagem: mensagemErro)
                                }
                            }
                        }
                    }else{
                        self.exibirMensagem(titulo: "Senhas divergentes!", mensagem: "As senhas digitadas não conferem.")
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
