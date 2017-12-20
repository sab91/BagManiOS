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
    
    init(id_pf:Int, title_pf:String, content_pf:String, summary_pf:String) {
        self.title = title_pf
        self.summary = summary_pf
        self.content = content_pf
        
        super.init()
        self.id = id_pf
    }
    
    init(title_pf:String, content_pf:String, summary_pf:String) {
        self.title = title_pf
        self.content = content_pf
        self.summary = summary_pf
        
        super.init()
    }
    
    init(id_pf:Int, title_pf:String, content_pf:String, summary_pf:String, createdAt_pf:Date, updatedAt_pf:Date) {
        self.title = title_pf
        self.content = content_pf
        self.summary = summary_pf
        
        super.init(createdAt: 0, updatedAt: 0)
        self.id = id_pf
    }
    
    override func toString() -> String {
        return "Page \(self.id) : \(self.title) / \(self.content) / \(self.summary)"
    }
}
