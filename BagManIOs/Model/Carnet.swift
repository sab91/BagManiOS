//
//  Carnet.swift
//  BagManIOs
//
//  Created by if26 on 14/12/2017.
//  Copyright © 2017 utt. All rights reserved.
//

import Foundation

class Carnet: BaseModel {
    var name:String
    var pages:[Int]
    
    init(name_pf:String) {
        self.name = name_pf
        self.pages = [Int]()
        
        super.init()
    }
    
    init(id_pf:Int, name_pf:String, createdAt_cf:Date, updatedAt_cf:Date) {
        self.name = name_pf
        self.pages = [Int]()
        
        super.init(createdAt: createdAt_cf, updatedAt: updatedAt_cf)
        self.id = id_pf
    }
    
    override func toString() -> String {
        return "Carnet : \(self.id) / \(self.name)"
    }
    
    
}
