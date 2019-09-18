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
        let alerta = UIAlertController(title: titulo, message: mensagem, preferredStyle: .alert)
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
                            
                            guard let erroR = erro as? NSError else {
                                print("Autenticado!")
                                self.exibirMensagem(titulo: "Cadastro OK", mensagem: "Cadastro efetuado com Sucesso!")
                                
                                return
                            }
                            
                            guard let erroTexto = erroR.localizedDescription as? String else {
                                return
                            }
                                var mensagemErro = ""
                                switch erroTexto {
                                case "ERROR_INVALID_EMAIL":
                                    mensagemErro = "E-mail digitado não é válido."
                                    break
                                case "The password must be 6 characters long or more":
                                    mensagemErro = "Senha fraca: Sua senha deve conter no mínimo 6 caracteres com letras e números!"
                                    break
                                case "The email address is already in use by another account.":
                                    mensagemErro = "E-mail já cadastrado"
                                    break
                                default:
                                    mensagemErro = "Tentativa de acesso inválido"
                                    print(erroTexto)
                                }
                                self.exibirMensagem(titulo: "Dados inválidos!", mensagem: mensagemErro)
                            }
                    }else{
                        self.exibirMensagem(titulo: "Senhas divergentes", mensagem: "Senhas digitadas não coincidem!")
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
