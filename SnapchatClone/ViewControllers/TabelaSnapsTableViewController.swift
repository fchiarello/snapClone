//
//  TabelaSnapsTableViewController.swift
//  SnapchatClone
//
//  Created by Fellipe Ricciardi Chiarello on 18/09/19.
//  Copyright © 2019 Fellipe Ricciardi Chiarello. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class TabelaSnapsTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var snap: [Snaps] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setuoBarButtonItems()
        self.title = "Snaps"
        recuperaUsuario()
        self.tableView.reloadData()
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
                
                snap.identificador = snapshot.key
                snap.nome = dados?["nome"] as! String
                snap.de = dados?["de"] as! String
                snap.descricao = dados?["descricao"] as! String
                snap.urlImagem = dados?["urlImagem"] as! String
                snap.idImagem = dados?["idImagem"] as! String
                
                
                self.snap.append(snap)
                self.tableView.reloadData()
            }
            
            snaps.observe(DataEventType.childRemoved) { (snapshot) in
                print(snapshot)
                
                var indice = 0
                for snap in self.snap {
                    print("Índice atual" + String(indice))
                    
                    if snap.identificador == snapshot.key {
                        self.snap.remove(at: indice)
                        print("Snap REmovido" + snap.identificador)
                    }
                    indice = indice + 1
                }
                self.tableView.reloadData()
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
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        let totalSnaps = snap.count
        
        if totalSnaps == 0 {
            return 1
        }else {
            return snap.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "celulaSnap")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "celulaSnap", for: indexPath)
        
        let totalSnaps =  snap.count
        
        if totalSnaps == 0 {
            cell.textLabel?.text = "Nenhum Snap pra você :)"
        }else{
            let snap = self.snap[ indexPath.row ]
            cell.textLabel?.text = snap.nome
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let totalSnaps = snap.count
        
        if totalSnaps > 0 {
            let detalhesViewController = DetalhesViewController.init(nibName: "DetalhesViewController", bundle: nil)
            self.navigationController?.pushViewController(viewController: detalhesViewController, animated: true, completion: {
                
                let snap = self.snap[ indexPath.row ]
                print(snap.identificador)
                
                
                detalhesViewController.descricao.text = snap.descricao
                let urlImagem = URL(string: snap.urlImagem)
                
                let downloadImagem = detalhesViewController.imagem
                
                detalhesViewController.identificador = snap.identificador
                detalhesViewController.idImagem = snap.idImagem
                
                downloadImagem?.sd_setImage(with: urlImagem, completed: { (image, error, cache, url) in
                    if error == nil {
                        print("imagem exibida")
                    }
                })
            })
        }
    }
}

extension UINavigationController {

  public func pushViewController(viewController: UIViewController,
                                 animated: Bool,
                                 completion: (() -> Void)?) {
    CATransaction.begin()
    CATransaction.setCompletionBlock(completion)
    pushViewController(viewController, animated: animated)
    CATransaction.commit()
  }

}




