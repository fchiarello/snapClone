//
//  Usuario.swift
//  SnapchatClone
//
//  Created by Fellipe Ricciardi Chiarello on 25/09/19.
//  Copyright © 2019 Fellipe Ricciardi Chiarello. All rights reserved.
//

import UIKit

class Usuario {
    var email: String
    var nome: String
    var uid: String
    
    init(email: String, nome: String, uid: String) {
        self.email = email
        self.nome = nome
        self.uid = uid
    }
    
}
