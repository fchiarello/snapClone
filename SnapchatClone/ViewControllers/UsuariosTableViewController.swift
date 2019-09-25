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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Usuarios"
        
        tableView.register(CelulaUsuariosTableViewCell.self, forCellReuseIdentifier: "celulaUsuario")
        
        let dataBase = Database.database().reference()
        let usuarios = dataBase.child("usuarios")
        usuarios.observe(DataEventType.childAdded) { (snapshot) in
            let dados = snapshot.value as! NSDictionary
            
            //Recuperar dados do Usuarios
            let emailUsuario = dados["email"] as! String
            let nomeUsuario = dados["nome"] as! String
            let uidUsuario = snapshot.key
            
            //adiciona usuarios ao array
            let usuario = Usuario(email: emailUsuario, nome: nomeUsuario, uid: uidUsuario)
            self.usuarios.append(usuario)
            
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
        
        return celula
    }
   

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
