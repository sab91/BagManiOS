//
//  Bdd.swift
//  BagManIOs
//
//  Created by Sabri on 17/12/2017.
//  Copyright © 2017 utt. All rights reserved.
//

import UIKit
import SQLite

class Bdd {
    var DATABASE_VERSION: Int
    var DATABASE_NAME: String
    var database: Connection!
    let MODEL_NAME_PAGE: Table
    let MODEL_NAME_CARNET: Table
    let NAME: Expression<String>
    let TITLE: Expression<String>
    let CONTENT: Expression<String>
    let SUMMARY: Expression<String>
    let CREATED_AT: Expression<String>
    let UPDATED_AT: Expression<String>
    let id: Expression<Int>
    
    // Constructeur
    init() {
        self.DATABASE_NAME = "bagman.db"
        self.DATABASE_VERSION = 1
        self.MODEL_NAME_PAGE = Table("page")
        self.MODEL_NAME_CARNET = Table("carnet")
        self.NAME = Expression<String>("name")
        self.TITLE = Expression<String>("title")
        self.CONTENT = Expression<String>("content")
        self.SUMMARY = Expression<String>("summary")
        self.CREATED_AT = Expression<String>("created_at")
        self.UPDATED_AT = Expression<String>("updated_at")
        self.id = Expression<Int>("id")
        
        createDb()
        
        createTables()
    }

    // Création de la base de données
    func createDb() {
        
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("users").appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            self.database = database
            
            
        } catch {
            print(error)
        }
        
    }
    
    
    // Création de toutes les tables necessaire à l'application pour la perssistence des données (page et carnet)
    func createTables() {
    
        createPageTable()
        createCarnetTable()
        print("Created table")
       
    }
    
    

    // Création de la table page
    func createPageTable() {

        
        do {
            try database.run(MODEL_NAME_PAGE.create { t in
                t.column(id, primaryKey: true)
                t.column(TITLE)
                t.column(CONTENT)
                t.column(SUMMARY)
                t.column(CREATED_AT)
                t.column(UPDATED_AT)
            })
            print("=====creation ", MODEL_NAME_PAGE)
        } catch {
            print(error)
        }
        
    }
    

    // Création de la table carnet
    func createCarnetTable() {

        
        do {
            try database.run(MODEL_NAME_CARNET.create { t in
                t.column(id, primaryKey: true)
                t.column(NAME)
                t.column(CREATED_AT)
                t.column(UPDATED_AT)
            })
            print("======creation ", MODEL_NAME_CARNET)
        } catch {
            print(error)
        }
    }
    
    // Insertion d'une page dans la bdd
    func insertPage(page: Page) {
        let insertTable =  self.MODEL_NAME_PAGE.insert(TITLE <- page.title, SUMMARY <- page.summary, CONTENT <- page.content, CREATED_AT <- "date_creation", UPDATED_AT <- "date_update")
        
        do {
            try self.database.run(insertTable)
            print("new page inserted")
        } catch {
            print(error)
        }
    }
    
    
    // Insertion d'un carnet dans la base
    func insertCarnet(carnet: Carnet) {
        let insertTable =  self.MODEL_NAME_CARNET.insert(NAME <- carnet.name, CREATED_AT <- "date_creation", UPDATED_AT <- "date_update")
        
        do {
            try self.database.run(insertTable)
            print("new carnet inserted")
        } catch {
            print(error)
        }
    }
    
    // Mettre à jour les données d'une page et modifier les données dans la bdd
//    func updatePage(page: Page) {
//        let dataId = Int(page.title)
//        let data = self.MODEL_NAME_PAGE.filter(self.id == dataId)
//        let updateData = data.update(self.TITLE <- page.title, self.SUMMARY <- page.summary, self.CONTENT <- page.content, self.CREATED_AT <- "page.createdAt", self.UPDATED_AT <- "page.updatedAt")
//
//        do {
//            try self.database.run(updateData)
//            print("updated data")
//        } catch {
//            print(error)
//        }
//    }
    
    
    // Mettre à jour les données d'un carnet et modifier les données dans la bdd
//    func updateCarnet(carnet: Carnet) {
//        let dataId = Int(carnet.name)
//        let data = self.MODEL_NAME_CARNET.filter(self.id == dataId)
//        let updateData = data.update(self.NAME <- carnet.name, self.CREATED_AT <- "carnet.createdAt", self.UPDATED_AT <- "carnet.updatedAt")
//
//        do {
//            try self.database.run(updateData)
//            print("User updated")
//        } catch {
//            print(error)
//        }
//    }
    
    
    // Supprimer une page
    func deletePage(page: Page) {
        var qid: Int = 0
        let query = MODEL_NAME_PAGE.select("id").filter(TITLE == page.title)
        for q in try self.database.prepare(query) {
            print("id: \(q[id])")
            qid = q[id]
            
            // id: 1, email: alice@mac.com, name: Optional("Alice")
        }
        let data = self.MODEL_NAME_PAGE.filter(self.id == qid)
        let deleteUser = data.delete()

        do {
            try self.database.run(deleteUser)
        } catch {
            print(error)
        }
    }
    
    // Supprimer un carnet
//    func deleteCarnet(carnet : Carnet) {
//        let dataId = Int(carnet.name)
//        let data = self.MODEL_NAME_CARNET.filter(self.id == dataId)
//        let deleteUser = data.delete()
//
//        do {
//            try self.database.run(deleteUser)
//        } catch {
//            print(error)
//        }
//    }
    

    // Suppression de l'ensemble des tables de la bdd
    func deleteTables() {
       
        deletePageTable()
        deleteCarnetTable()
        print("Deleted table")
        
    }
    
    
    // Suppression de la table de la bdd qui contient les pages
    func deletePageTable() {
        do {
            try database.run(MODEL_NAME_PAGE.drop())
            print("======delete ", MODEL_NAME_PAGE)
        } catch {
            print(error)
        }
        
    }
    
    // Suppression de la table de la bdd qui contient les carnets
    func deleteCarnetTable() {
        do {
            try database.run(MODEL_NAME_CARNET.drop())
            print("======delete ", MODEL_NAME_CARNET)
        } catch {
            print(error)
        }
        
    }
    



    // Afficher le contenu de la table page
    func getListPage() {
        
        do {
            let pages = try self.database.prepare(self.MODEL_NAME_PAGE)
            for page in pages {
                print("title: \(page[self.TITLE])")
            }
        } catch {
            print(error)
        }
    }
    
    // Afficher le contenu de la table carnet
    func getListCarnet() {
        
        do {
            let carnets = try self.database.prepare(self.MODEL_NAME_CARNET)
            for carnet in carnets {
                print("name: \(carnet[self.NAME])")
            }
        } catch {
            print(error)
        }
    }
    

    
}


