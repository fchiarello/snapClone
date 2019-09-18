//
//  SelecionaFotoViewController.swift
//  SnapchatClone
//
//  Created by Fellipe Ricciardi Chiarello on 18/09/19.
//  Copyright © 2019 Fellipe Ricciardi Chiarello. All rights reserved.
//

import UIKit

class SelecionaFotoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setuoBarButtonItems()
    }
    
    func setuoBarButtonItems() {
        let openCam = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(abrirCamera))
        navigationItem.rightBarButtonItem = openCam
        
        navigationController?.navigationBar.topItem?.title = "Snaps"
    }
    
    @objc func abrirCamera() {
        print("Abriu")
    }
    
    


}
