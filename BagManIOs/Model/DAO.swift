//
//  DAO.swift
//  BagManIOs
//
//  Created by Sabri on 20/12/2017.
//  Copyright © 2017 utt. All rights reserved.
//

import Foundation
import SQLite

class DAO {
    
//    static let NAME = Expression<String>("name")
//    static let TITLE = Expression<String>("title")
//    static let CONTENT = Expression<String>("content")
//    static let SUMMARY = Expression<String>("summary")
//    static let CREATED_AT = Expression<Date>("created_at")
//    static let UPDATED_AT = Expression<Date>("updated_at")
//    static let ID = Expression<Int>("id")
    
    static func objectToPage(cursor: Row) -> Page {
         let TITLE = Expression<String>("title")
         let CONTENT = Expression<String>("content")
         let SUMMARY = Expression<String>("summary")
         let CREATED_AT = Expression<Date>("created_at")
         let UPDATED_AT = Expression<Date>("updated_at")
         let CARNET_ID = Expression<Int>("carnet_id")
         let ID = Expression<Int>("id")
        
        return Page(id_pf: cursor[ID], title_pf: cursor[TITLE], content_pf: cursor[CONTENT], summary_pf: cursor[SUMMARY], createdAt_pf: cursor[CREATED_AT], updatedAt_pf: cursor[UPDATED_AT], carnetId_pf: cursor[CARNET_ID])
    }
    
    static func objectToCarnet(cursor: Row) -> Carnet {
        let NAME = Expression<String>("name")
        let CREATED_AT = Expression<Date>("created_at")
        let UPDATED_AT = Expression<Date>("updated_at")
        let ID = Expression<Int>("id")
        
        return Carnet(id_pf: cursor[ID], name_pf: cursor[NAME], createdAt_cf: cursor[CREATED_AT], updatedAt_cf: cursor[UPDATED_AT])
    }
    
}
