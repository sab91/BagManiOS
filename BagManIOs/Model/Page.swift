//
//  Page.swift
//  BagManIOs
//
//  Created by if26 on 14/12/2017.
//  Copyright © 2017 utt. All rights reserved.
//

import Foundation

class Page: BaseModel {
    var title:String
    var content:String
    var summary:String
    var carnet_id: Int
    
    init(id_pf:Int, title_pf:String, content_pf:String, summary_pf:String, carnetId_pf: Int) {
        self.title = title_pf
        self.summary = summary_pf
        self.content = content_pf
        self.carnet_id = carnetId_pf
        
        super.init()
        self.id = id_pf
    }
    
    init(title_pf:String, content_pf:String, summary_pf:String, carnetId_pf: Int) {
        self.title = title_pf
        self.content = content_pf
        self.summary = summary_pf
        self.carnet_id = carnetId_pf
        
        super.init()
    }
    
    init(id_pf:Int, title_pf:String, content_pf:String, summary_pf:String, createdAt_pf:Date, updatedAt_pf:Date, carnetId_pf: Int) {
        self.title = title_pf
        self.content = content_pf
        self.summary = summary_pf
        self.carnet_id = carnetId_pf
        
        super.init(createdAt: createdAt_pf, updatedAt: updatedAt_pf)
        self.id = id_pf
    }
    
    override func toString() -> String {
        return "Page \(self.id) : \(self.title) / \(self.content) / \(self.summary)"
    }
}
