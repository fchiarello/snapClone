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
    
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }    
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}