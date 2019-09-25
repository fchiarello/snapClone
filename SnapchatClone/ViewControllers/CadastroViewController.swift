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
    
    @IBOutlet weak var nomeCompleto: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setuoBarButtonItems()
        self.title = "Criar Conta"
    }
    
    @IBAction func cadastrarCadastro(_ sender: Any) {
        if let emailR = self.emailCadastro.text{
            if let nomeR = self.nomeCompleto.text{
                if let senhaR = self.senhaCadastro.text{
                    if let confirmaR = self.confirmaSenhaCadastro.text{
                        if nomeR != "" {
                        if senhaR == confirmaR{
                            let autenticacao = Auth.auth()
                            autenticacao.createUser(withEmail: emailR, password: senhaR) { (usuario, erro) in
                                guard let erroR = erro as NSError? else {
                                    
                                    let dataBase = Database.database().reference()
                                    let usuarios = dataBase.child("usuarios")
                                    let usuarioDados = [ "nome": nomeR , "email": emailR  ]
                                        
                                        usuarios.child(usuario!.user.uid).setValue(usuarioDados)
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
                                let alerta = Alertas(titulo: "Dados Inválidos!", mensagem: mensagemErro)
                                self.present(alerta.getAlerta(), animated: true, completion: nil)
                            }
                        }else{
                            let alerta = Alertas(titulo: "Senhas Divergentes!", mensagem: "Senhas digitadas não coincidem!")
                            self.present(alerta.getAlerta(), animated: true, completion: nil)
                        }
                        }else{
                            let alerta = Alertas(titulo: "Dados incompletos!", mensagem: "Preenchimento do nome é obrigatório!")
                            self.present(alerta.getAlerta(), animated: true, completion: nil)
                        }
                    }
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
}
