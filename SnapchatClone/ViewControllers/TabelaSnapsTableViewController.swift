//
//  TabelaSnapsTableViewController.swift
//  SnapchatClone
//
//  Created by Fellipe Ricciardi Chiarello on 18/09/19.
//  Copyright © 2019 Fellipe Ricciardi Chiarello. All rights reserved.
//

import UIKit
import Firebase

class TabelaSnapsTableViewController: UITableViewController {
    
    var snaps: [Snaps] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setuoBarButtonItems()
        self.title = "Snaps"
        recuperaUsuario()
        
    }
    
    func recuperaUsuario() {
        let autenticacao = Auth.auth()
        let usuarioLogado = autenticacao.currentUser?.uid
        
        if let idUsuarioLogado = usuarioLogado {
            let database = Database.database().reference()
            let usuarios = database.child("usuarios")
            let snaps = usuarios.child(idUsuarioLogado).child("Snaps")
            
            snaps.observe(DataEventType.childAdded) { (snapshot) in
            
                let dados = snapshot.value as? NSDictionary
                
                let snap = Snaps()
                
                snap.descricao = snapshot.key
                snap.nome = dados?["nome"] as! String
                snap.de = dados?["de"] as! String
                snap.descricao = dados?["descricao"] as! String
                snap.urlImagem = dados?["urlImagem"] as! String
                snap.idImagem = dados?["idImagem"] as! String
                
                self.snaps.append(snap)
                print(self.snaps)
                
            }
        }
    }
    
    func setuoBarButtonItems() {
        let logoutButton = UIBarButtonItem(title: "Logout", style: .done, target: self, action: #selector(deslogarUsuario))
        navigationItem.leftBarButtonItem = logoutButton
        
        let addSnapButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(irParaSelecionarFoto))
        navigationItem.rightBarButtonItem = addSnapButton
        
    }
    
    @objc func deslogarUsuario () {
        
        let autenticacao = Auth.auth()
        do {
            try autenticacao.signOut()
            //            let telaInicial = ViewController.init()
            self.navigationController?.popViewController(animated: true)
        } catch {
            print("Erro ao deslogar!")
        }
    }
    
    @objc func irParaSelecionarFoto () {
        let snapsViewController = SelecionaFotoViewController.init(nibName: "SelecionaFotoViewController", bundle: nil)
        self.navigationController?.pushViewController(snapsViewController, animated: true)
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
}
