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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setuoBarButtonItems()
        self.title = "Snaps"
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
