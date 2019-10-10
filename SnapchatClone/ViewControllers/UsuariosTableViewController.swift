//
//  UsuariosTableViewController.swift
//  SnapchatClone
//
//  Created by Fellipe Ricciardi Chiarello on 25/09/19.
//  Copyright © 2019 Fellipe Ricciardi Chiarello. All rights reserved.
//

import UIKit
import Firebase

class UsuariosTableViewController: UITableViewController {
    
    var usuarios: [Usuario] = []
    var urlImagem = ""
    var descricao = ""
    var idImagem = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Usuarios"
        tableView.register(CelulaUsuariosTableViewCell.self, forCellReuseIdentifier: "celulaUsuario")
        let dataBase = Database.database().reference()
        let usuarios = dataBase.child("usuarios")
        usuarios.observe(DataEventType.childAdded) { (snapshot) in
            let dados = snapshot.value as! NSDictionary
            
            //ID usuario logado
            
            let autenticacao = Auth.auth()
            let usuarioLogado = autenticacao.currentUser?.uid
            
            //Recuperar dados do Usuarios
            let emailUsuario = dados["email"] as! String
            let nomeUsuario = dados["nome"] as! String
            let uidUsuario = snapshot.key
            
            //adiciona usuarios ao array
            let usuario = Usuario(email: emailUsuario, nome: nomeUsuario, uid: uidUsuario)
            if uidUsuario != usuarioLogado {
                self.usuarios.append(usuario)
            }
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.usuarios.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celula = tableView.dequeueReusableCell(withIdentifier: "celulaUsuario", for: indexPath) as! CelulaUsuariosTableViewCell
        
        let usuarioCelula = self.usuarios[indexPath.row]
        celula.textLabel?.text = usuarioCelula.nome
        celula.detailTextLabel?.text = usuarioCelula.email
        
        return celula
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let usuarioSelecionado = self.usuarios[indexPath.row]
        let idUsuarioSelecionado = usuarioSelecionado.uid
        
        //Recupera referencia do banco de dados
        let dataBase = Database.database().reference()
        let usuarios = dataBase.child("usuarios")
        let snaps = usuarios.child(idUsuarioSelecionado).child("Snaps")
        let autenticacao = Auth.auth()
        if let idUsuarioLogado = autenticacao.currentUser?.uid{
            let usuarioLogado = usuarios.child(idUsuarioLogado)
            usuarioLogado.observeSingleEvent(of: DataEventType.value) { (snapshot) in
                let dados = snapshot.value as? NSDictionary
                let snap = [
                    "de": dados?["email"] as! String,
                    "nome": dados?["nome"] as! String,
                    "descricao": self.descricao,
                    "urlImagem": self.urlImagem as String,
                    "idImagem": self.idImagem as String,
                ]
                snaps.childByAutoId().setValue(snap)
            }
        }
//        let tabelaSnaps = TabelaSnapsTableViewController.init(nibName: "TabelaSnapsTableViewController", bundle: nil)
//        self.navigationController?.pushViewController(tabelaSnaps, animated: true)
        
        navigationController?.popToRootViewController(animated: true)
    }
}
