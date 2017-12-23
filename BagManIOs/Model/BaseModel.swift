//
//  BaseModel.swift
//  BagManIOs
//
//  Created by if26 on 14/12/2017.
//  Copyright © 2017 utt. All rights reserved.
//

import Foundation

class BaseModel {
    var id:Int
    var createdAt:Date
    var updatedAt:Date
    
    init() {
        // Vu qu'il faut absolument instancier les parametres, -1 pour un id signifie qu'il n'est pas encore attribué dans la bdd
        self.id = -1
        self.createdAt = Date()
        self.updatedAt = Date()
    }
    
    init(createdAt:Date, updatedAt:Date) {
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.id = -1
    }
    
    func toString() -> String {
        return ""
    }
    
}
