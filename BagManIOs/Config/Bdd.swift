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
    //let id = Expression<Int64>("id")
    
    init() {
        self.DATABASE_NAME = "bagman.db"
        self.DATABASE_VERSION = 1
        self.MODEL_NAME_PAGE = Table("page")
        self.MODEL_NAME_CARNET = Table("carnet")
        
        createDb()
        
        createTables()
    }

    
    func createDb() {
        
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("users").appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            self.database = database
            
            
        } catch {
            print(error)
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    /**
     * Méthode aggregatrice de la création de l'ensemble des tables
     * Idée qu'on peut tout faire en one-shot au lieu de faire x appels dans le onCreate(db)
     */
    
    func createTables() {
    
        createPageTable()
        createCarnetTable()
        print("Created table")
       
    }
    
//    public void createCompleteTables() {
//        // Try - Catch pour choper les erreurs lors de la création des tables
//        try {
//        createPageTable();
//        createCarnetTable();
//        } catch (Exception ex){
//        // Essayer de préciser quel Table pose problème
//        Log.e("===", "Probleme dans la création des tables");
//        }
//    }
    
    
    /**
     * Méthode de création de la table Page
     */
//    public void createPageTable() {
//        try {
//        database.execSQL(FeedPage.SQL_CREATE_PAGES);
//        Log.i("==", FeedPage.MODEL_NAME + " is created");
//        } catch(Exception ex) {
//        Log.i("===", ex.getMessage());
//        }
//    }
    
    func createPageTable() {
        let id_p = Expression<Int>("id")
        let TITLE = Expression<String>("title")
        let CONTENT = Expression<String>("content")
        let SUMMARY = Expression<String>("summary")
        let CREATED_AT = Expression<String>("created_at")
        let UPDATED_AT = Expression<String>("updated_at")
        
        do {
            try database.run(MODEL_NAME_PAGE.create { t in
                t.column(id_p, primaryKey: true)
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
    
//    public void createCarnetTable() {
//        try {
//        database.execSQL(FeedCarnet.SQL_CREATE_CARNET);
//        Log.i("==", FeedCarnet.MODEL_NAME + " is created");
//        } catch(Exception ex) {
//        Log.i("===", ex.getMessage());
//        }
//    }
    
    func createCarnetTable() {
        let id_c = Expression<Int>("id")
        let NAME = Expression<String>("name")
        let CREATED_AT = Expression<String>("created_at")
        let UPDATED_AT = Expression<String>("updated_at")
        
        do {
            try database.run(MODEL_NAME_CARNET.create { t in
                t.column(id_c, primaryKey: true)
                t.column(NAME)
                t.column(CREATED_AT)
                t.column(UPDATED_AT)
            })
            print("======creation ", MODEL_NAME_CARNET)
        } catch {
            print(error)
        }
    }
    
    /**
     * Suppresion de l'ensemble des tables de la bdd
     * Methode qui appelle les méthodes de suppression de chaque tables
     */
//    public void deleteTables() {
//        deletePageTable();
//    }
    
    func deleteTables() {
       
        deletePageTable()
        deleteCarnetTable()
        print("Deleted table")
        
    }
    
    
    /**
     * Méthode de suppression de la table Page
     */
//    public void deletePageTable() {
//        try {
//        database.execSQL(FeedPage.SQL_DELETE_PAGES);
//        Log.i("==", FeedPage.MODEL_NAME + " has been deleted");
//        } catch(Exception ex) {
//        Log.i("===", "Prob de suppression");
//        }
//    }
    
    func deletePageTable() {
        do {
            try database.run(MODEL_NAME_PAGE.drop())
            print("======delete ", MODEL_NAME_PAGE)
        } catch {
            print(error)
        }
        
    }
    
//    public void deleteCarnetTable() {
//        try {
//        database.execSQL(FeedCarnet.SQL_DELETE_CARNET);
//        Log.i("==", FeedCarnet.MODEL_NAME + " has been deleted");
//        } catch(Exception ex) {
//        Log.i("===", "Prob de suppression");
//        }
//    }
//
    func deleteCarnetTable() {
        do {
            try database.run(MODEL_NAME_CARNET.drop())
            print("======delete ", MODEL_NAME_CARNET)
        } catch {
            print(error)
        }
        
    }
    
    /**
     * Classe / structure du modele Page
     * Toutes les infos sur la strucutre et les commandes SQL de base
     */
//    class FeedPage {
//        var MODEL_NAME: Expression<String>
//        var TITLE: Expression<String>
//        var CONTENT: Expression<String>
//        var SUMMARY: Expression<String>
//        var CREATED_AT: Expression<String>
//        var UPDATED_AT: Expression<String>
////        var SQL_CREATE_CARNET: String = "CREATE TABLE \(MODEL_NAME) (\(ID) INTEGER PRIMARY KEY, \(TITLE) TEXT, \(CONTENT) TEXT, \(SUMMARY) TEXT, \(CREATED_AT) INTEGER, \(UPDATED_AT) INTEGER)"
////        var SQL_DELETE_CARNET: String = "DROP TABLE IF EXISTS \(MODEL_NAME)"
//
//        init() {
//            self.MODEL_NAME = Expression<String>("page")
//            self.TITLE = Expression<String>("title")
//            self.CONTENT = Expression<String>("content")
//            self.SUMMARY = Expression<String>("summary")
//            self.CREATED_AT = Expression<String>("created_at")
//            self.UPDATED_AT = Expression<String>("updated_at")
//        }
//    }
    
    /**
     * Future classe pour Carnet, sous la même forme que Page
     */
    
//    class FeedCarnet {
//
//        var MODEL_NAME: String = "carnet"
//        var NAME: String = "name"
//        var CREATED_AT: String = "created_at"
//        var UPDATED_AT: String = "updated_at"
////        var SQL_CREATE_CARNET: String = "CREATE TABLE \(MODEL_NAME) (\(_ID) INTEGER PRIMARY KEY, \(NAME) TEXT, \(CREATED_AT) INTEGER, \(UPDATED_AT) INTEGER)"
////        var SQL_DELETE_CARNET: String = "DROP TABLE IF EXISTS \(MODEL_NAME)"
//
//    }
    
    


    // Afficher le contenu de la table page
    func getListPage() {
        
        do {
            let pages = try self.database.prepare(self.MODEL_NAME_PAGE)
            for page in pages {
                print("title: \(page[Expression<String>("title")])")
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
                print("name: \(carnet[Expression<String>("name")])")
            }
        } catch {
            print(error)
        }
    }
    
    
    func onUpgrade() {
        print("===Upgrade")
        //DATABASE_VERSION = 1
        deleteTables()
        createTables()
    }
    
    func getDatabase() -> Connection {
        return self.database
    }
}


