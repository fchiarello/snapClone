//
//  DetalhesViewController.swift
//  SnapchatClone
//
//  Created by Fellipe Ricciardi Chiarello on 1/4/20.
//  Copyright © 2020 Fellipe Ricciardi Chiarello. All rights reserved.
//

import UIKit
import Firebase

class DetalhesViewController: UIViewController {
    
    @IBOutlet weak var imagem: UIImageView!
    
    @IBOutlet weak var descricao: UILabel!
    
    @IBOutlet weak var contador: UILabel!
    
    
    var snap = Snaps()
    var identificador = ""
    var tempo = 11
    var idImagem = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            self.tempo = self.tempo - 1
            
            self.contador.text = String(self.tempo)
            
            if self.tempo == 0 {
                timer.invalidate()
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let autenticacao = Auth.auth()
        
        if let idUsuarioLogado = autenticacao.currentUser?.uid{
            let database = Database.database().reference()
            let usuarios = database.child("usuarios")
            let childSnaps = usuarios.child(idUsuarioLogado).child("Snaps")
            
            childSnaps.child(self.identificador).removeValue()
        }
        
        let storage = Storage.storage().reference()
        let imagens = storage.child("imagens")
        imagens.child("\(self.idImagem).jpg").delete { (error) in
            if error != nil {
                print("Erro ao excluir")
            }else {
                print("Sucesso ao excluir")
            }
        }
    }
}
