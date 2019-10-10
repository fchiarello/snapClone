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
        
        let storage = Storage.storage().reference()
        let imagesFolder = storage.child("imagens")
        let imagesFile = imagesFolder.child("\(idImagem).jpg")
        
        //image recover
        if let imageRecovered = fotoSelecionada.image{
            if let imgData = imageRecovered.jpegData(compressionQuality: 0.2) {
                imagesFile.putData(imgData, metadata: nil) { (metadata, error) in
                    if error == nil {
                        imagesFile.downloadURL { (url, error) in
                            print(url?.absoluteString as Any)
                            let urlFinal = url?.absoluteString
                            self.urlRecuperada = urlFinal!
                            self.presentNewScreen()
                        }
                        print("Sucesso ao Salvar")
                    }
                    else {
                        print("erro ao fazer download do arquivo")
                    }
                }
            }
        }
    }
    
    func presentNewScreen() {
        let usuariosTableView = UsuariosTableViewController.init(nibName: "UsuariosTableViewController", bundle: nil)
        
        self.navigationController?.pushViewController(viewController: usuariosTableView, animated: true, completion: {
            usuariosTableView.descricao = self.descricaoImagem.text!
            usuariosTableView.urlImagem = self.urlRecuperada as String
            usuariosTableView.idImagem = self.idImagem as String
        })
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
