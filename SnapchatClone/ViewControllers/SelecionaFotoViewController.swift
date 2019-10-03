//
//  SelecionaFotoViewController.swift
//  SnapchatClone
//
//  Created by Fellipe Ricciardi Chiarello on 18/09/19.
//  Copyright © 2019 Fellipe Ricciardi Chiarello. All rights reserved.
//

import UIKit
import Firebase

class SelecionaFotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imagePicker = UIImagePickerController()
    var idImagem = NSUUID().uuidString
    var urlRecuperada = ""
    
    @IBOutlet weak var fotoSelecionada: UIImageView!
    @IBOutlet weak var descricaoImagem: UITextField!
    
    @IBOutlet weak var proximo: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setuoBarButtonItems()
        self.title = "Foto"
        imagePicker.delegate = self
        
        
        //Desativando botao Proximo até q a foto seja carregada
        self.proximo.isEnabled = false
        self.proximo.backgroundColor = UIColor.gray
    }
    
    
    @IBAction func botaoProximo(_ sender: UIView) {
        self.proximo.isEnabled = false
        self.proximo.setTitle("Carregando...", for: .normal)
        
        let armazenamento = Storage.storage().reference()
        let imagens = armazenamento.child("imagens") //cria uma pasta no firebase para armazanar arquivos
        if let imagemSelecionada = fotoSelecionada.image {
            
            let imagemDados = imagemSelecionada.jpegData(compressionQuality: 0.2)
            imagens.child("\(self.idImagem).jpg").putData(imagemDados!, metadata: nil) { (metaDados, erro) in
                if erro == nil, metaDados != nil {
                    armazenamento.downloadURL { (url, error) in
                        if url != nil{
                            guard let urlFinal = url?.absoluteString else {return}
                            print(url as Any)
                            self.urlRecuperada = urlFinal
                            print(urlFinal)
                        }
                    }
                }
            }
        }
        print(urlRecuperada)
        presentNewScreen()
    }
    
    func presentNewScreen() {
        let usuariosTableView = UsuariosTableViewController.init(nibName: "UsuariosTableViewController", bundle: nil)
            present(usuariosTableView, animated: true) {
            usuariosTableView.descricao = self.descricaoImagem.text!
            usuariosTableView.urlImagem = self.urlRecuperada
            usuariosTableView.idImagem = self.idImagem as String
                print(self.urlRecuperada)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let imagemRecuperada = info[ UIImagePickerController.InfoKey.originalImage ] as! UIImage
        self.proximo.isEnabled = true
        self.proximo.backgroundColor = UIColor(displayP3Red: 0.553, green: 0.369, blue: 0.749, alpha: 1)
        imagePicker.dismiss(animated: true, completion: nil)
        fotoSelecionada.image = imagemRecuperada
    }
    
    func setuoBarButtonItems() {
        let openLibrary = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(abrirAlbum))
        let openCam = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(abrirCamera))
        navigationItem.rightBarButtonItems = [openCam, openLibrary]
    }
    
    @objc func abrirCamera() {
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func abrirAlbum() {
        imagePicker.sourceType = .savedPhotosAlbum
        present(imagePicker, animated: true, completion: nil)
    }
    
}
