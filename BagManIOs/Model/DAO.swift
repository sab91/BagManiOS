//
//  DAO.swift
//  BagManIOs
//
//  Created by Sabri on 20/12/2017.
//  Copyright © 2017 utt. All rights reserved.
//

import Foundation
import SQLite
import RNCryptor

let password = "sabri"

class DAO {
    
    
    static func objectToPage(cursor: Row) -> Page {

        let TITLE = Expression<Data>("title")
        let CONTENT = Expression<Data>("content")
        let SUMMARY = Expression<Data>("summary")
        let CREATED_AT = Expression<Date>("created_at")
        let UPDATED_AT = Expression<Date>("updated_at")
        let CARNET_ID = Expression<Int>("carnet_id")
        let ID = Expression<Int>("id_page")
      
        let title = Bdd().decrypt(donnee: cursor[TITLE])
        let summary = Bdd().decrypt(donnee: cursor[SUMMARY])
        let content = Bdd().decrypt(donnee: cursor[CONTENT])
        
        return Page(id_pf: cursor[ID], title_pf: title, content_pf: content, summary_pf: summary, createdAt_pf: cursor[CREATED_AT], updatedAt_pf: cursor[UPDATED_AT], carnetId_pf: cursor[CARNET_ID])
    }
    
    static func objectToCarnet(cursor: Row) -> Carnet {
        let NAME = Expression<Data>("name")
        let CREATED_AT = Expression<Date>("created_at")
        let UPDATED_AT = Expression<Date>("updated_at")
        let ID = Expression<Int>("id_carnet")
        let EMAIL_ACCOUNT = Expression<Data>("email_account")

        let name = Bdd().decrypt(donnee: cursor[NAME])
        let email = Bdd().decrypt(donnee: cursor[EMAIL_ACCOUNT])
        
        return Carnet(id_pf: cursor[ID], name_pf: name, createdAt_cf: cursor[CREATED_AT], updatedAt_cf: cursor[UPDATED_AT], email_pf: email)
    }
    
}
