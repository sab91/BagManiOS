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
    var createdAt:Double
    var updatedAt:Double
    
    init() {
        // Vu qu'il faut absolument instancier les parametres, -1 pour un id signifie qu'il n'est pas encore attribué dans la bdd
        self.id = -1
        self.createdAt = Date().timeIntervalSince1970
        self.updatedAt = Date().timeIntervalSince1970
    }
    
    init(createdAt:Double, updatedAt:Double) {
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.id = -1
    }
    
    func toString() -> String {
        return ""
    }
    
}
