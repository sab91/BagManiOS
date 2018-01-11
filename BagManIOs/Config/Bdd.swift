//
//  Bdd.swift
//  BagManIOs
//
//  Created by Sabri on 17/12/2017.
//  Copyright © 2017 utt. All rights reserved.
//

import UIKit
import SQLite
import RNCryptor

class Bdd {
    
    let password = "sabri"
    //var DATABASE_VERSION: Int
    var DATABASE_NAME: String
    var database: Connection!
    let MODEL_NAME_PAGE: Table
    let MODEL_NAME_CARNET: Table
    let MODEL_NAME_AUTH: Table
    let NAME = Expression<Data>("name")
    let EMAIL_ACCOUNT = Expression<Data>("email_account")
    let TITLE = Expression<Data>("title")
    let CONTENT = Expression<Data>("content")
    let SUMMARY = Expression<Data>("summary")
    let CREATED_AT = Expression<Date>("created_at")
    let UPDATED_AT = Expression<Date>("updated_at")
    let CARNET_ID = Expression<Int>("carnet_id")
    let id_page = Expression<Int>("id_page")
    let id_carnet = Expression<Int>("id_carnet")
    let EMAIL = Expression<Data>("email")
    let MDP = Expression<Data>("password")
    
    // Constructeur
    init() {
        self.DATABASE_NAME = "bagmandb"
        //self.DATABASE_VERSION = 1
        self.MODEL_NAME_PAGE = Table("page")
        self.MODEL_NAME_CARNET = Table("carnet")
        self.MODEL_NAME_AUTH = Table("auth")
        
        // initialisation de la bdd
        createDb()
        // initialisation des tables de la bdd
        createTables()
    }
    
    // ================= Création ================

    // Création de la base de données
    func createDb() {

        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent(DATABASE_NAME).appendingPathExtension("sqlite3")
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
        createAuthTable()
//        print("Created table")
       
    }
    
    

    // Création de la table page
    func createPageTable() {
        do {
            try database.run(MODEL_NAME_PAGE.create { t in
                t.column(id_page, primaryKey: true)
                t.column(TITLE)
                t.column(CONTENT)
                t.column(SUMMARY)
                t.column(CREATED_AT)
                t.column(UPDATED_AT)
                t.column(CARNET_ID)
                //Tentative de création de clé étrangère
                t.foreignKey(CARNET_ID, references: MODEL_NAME_CARNET, id_carnet)
            })
//            print("=====creation ", MODEL_NAME_PAGE)
        } catch {
            print(error)
        }
        
    }
    

    // Création de la table carnet
    func createCarnetTable() {

        
        do {
            try database.run(MODEL_NAME_CARNET.create { t in
                t.column(id_carnet, primaryKey: true)
                t.column(NAME)
                t.column(CREATED_AT)
                t.column(UPDATED_AT)
                t.column(EMAIL_ACCOUNT)
                t.foreignKey(EMAIL_ACCOUNT, references: MODEL_NAME_AUTH, EMAIL)
                
            })
//            print("======creation ", MODEL_NAME_CARNET)
        } catch {
            print(error)
        }
    }
    
    // Création de la table authentification
    func createAuthTable() {
        
        do {
            try database.run(MODEL_NAME_AUTH.create { t in
                //t.column(id, primaryKey: true)
                t.column(EMAIL, primaryKey: true)
                t.column(MDP)
                t.column(CREATED_AT)
                t.column(UPDATED_AT)
            })
//            print("======creation ", MODEL_NAME_AUTH)
        } catch {
            print(error)
        }
    }
    
    
    
    ///++++++
    
    func crypter(string: String) -> Data {
        
        // Encryption
//        let myString: String = "aaa"
        //NSData * data = [myString, dataUsingEncoding: NSUTF8StringEncoding]
        let str = string.data(using: .utf8)
        let ciphertext = RNCryptor.encrypt(data: str!, withPassword: password)
        
        
        return ciphertext
    }
    
    func decrypt(donnee: Data) -> String {

        var string: String = ""
        // Decryption
        do {
            let originalData = try RNCryptor.decrypt(data: donnee, withPassword: password)
            string = String(data: originalData, encoding: .utf8)!

        } catch {
            print(error)
        }
        return string
    }
    
    //+++++++
    
    // =============== Insert =====================
    
    // Insertion d'une page dans la bdd
    func insertPage(page: Page) {
        let titleCrypt = crypter(string: page.title)
        let summaryCrypt = crypter(string: page.summary)
        let contentCrypt = crypter(string: page.content)

        let insertTable =  self.MODEL_NAME_PAGE.insert(TITLE <- titleCrypt , SUMMARY <- summaryCrypt , CONTENT <- contentCrypt , CREATED_AT <- page.createdAt, UPDATED_AT <- page.updatedAt, CARNET_ID <- page.carnet_id)
        
       
        do {
            try self.database.run(insertTable)
            print("new page inserted")
        } catch {
            print(error)
        }
    }
    
    
    // Insertion d'un carnet dans la base
    func insertCarnet(carnet: Carnet) {
        let nameCrypt = crypter(string: carnet.name)
        let emailCrypt = crypter(string: carnet.email)
        let insertTable =  self.MODEL_NAME_CARNET.insert(NAME <- nameCrypt, CREATED_AT <- carnet.createdAt, UPDATED_AT <- carnet.updatedAt, EMAIL_ACCOUNT <- emailCrypt)
        
        do {
            try self.database.run(insertTable)
            print("new carnet inserted")
        } catch {
            print(error)
        }
    }
    
    // Insérer un nouveau compte dans la bdd
    func insertAccount(email: String, password: String) {
        let emailCrypt = crypter(string: email)
        let mdpCrypt = crypter(string: password)
        let insertTable =  self.MODEL_NAME_AUTH.insert(EMAIL <- emailCrypt, MDP <- mdpCrypt, CREATED_AT <- Date(), UPDATED_AT <- Date())
        
        do {
            try self.database.run(insertTable)
            print("new account inserted")
           
        } catch {
            print(error)
        }
    }
    
    
    
    // ================ Update ====================
    // Mettre à jour un compte dans la bdd
    func updateAccount(email: String, mdp: String) {

        let emailCrypt = crypter(string: email)
        let mdpCrypt = crypter(string: mdp)

        let data = self.MODEL_NAME_AUTH.filter(self.EMAIL == emailCrypt)
        let updateData = data.update(EMAIL <- emailCrypt, MDP <- mdpCrypt, CREATED_AT <- self.CREATED_AT, UPDATED_AT <- Date())
        
        do {
            try self.database.run(updateData)
            print("updated account")
        } catch {
            print(error)
        }
    }
    
    
    
    // Mettre à jour les données d'une page et modifier les données dans la bdd
    func updatePage(page: Page, id_p: Int) {
        
        let titleCrypt = crypter(string: page.title)
        let summaryCrypt = crypter(string: page.summary)
        let contentCrypt = crypter(string: page.content)
        
        let data = self.MODEL_NAME_PAGE.filter(self.id_page == id_p)
        let updateData = data.update(self.TITLE <- titleCrypt, self.SUMMARY <- summaryCrypt, self.CONTENT <- contentCrypt, self.CREATED_AT <- page.createdAt, self.UPDATED_AT <- Date(), self.CARNET_ID <- page.carnet_id)

        do {
            try self.database.run(updateData)
            print("updated data")
        } catch {
            print(error)
        }
    }
    
    
    // Mettre à jour les données d'un carnet et modifier les données dans la bdd
    func updateCarnet(carnet: Carnet, id_c: Int) {
        
        let nameCrypt = crypter(string: carnet.name)
        let emailCrypt = crypter(string: carnet.email)

        let data = self.MODEL_NAME_CARNET.filter(self.id_carnet == id_c)
        let updateData = data.update(self.NAME <- nameCrypt, self.CREATED_AT <- carnet.createdAt, self.UPDATED_AT <- Date(), self.EMAIL_ACCOUNT <- emailCrypt)

        do {
            try self.database.run(updateData)
            print("User updated")
        } catch {
            print(error)
        }
    }
    
    
    
    // =============== Suppression ================
    
    // Supprimer une page
    func deletePage(id_p: Int) {
        
        var queryId: Int = 0
        do {
            let query = MODEL_NAME_PAGE.select(id_page).filter(id_page == id_p)
            let qr = try database.prepare(query)
            for q in qr {
                //print("id: \(q[id])")
                queryId = q[id_page]
            }
        } catch {
            print(error)
        }
        
        let data = self.MODEL_NAME_PAGE.filter(self.id_page == queryId)
        let deleteUser = data.delete()

        do {
            try self.database.run(deleteUser)
            print("page deleted")
        } catch {
            print(error)
        }
    }
    
    //Supprimer les pages correspondant au carnet supprimé
    func deletePageByCarnet(carnet_id: Int) {
        do{
            let query = try self.database.prepare(MODEL_NAME_PAGE.filter(CARNET_ID == carnet_id))
            for q in query {
                let id_d = q[id_page]
                deletePage(id_p: id_d)
            }
        } catch {
            print(error)
        }
    }
    
    // Supprimer un carnet
    func deleteCarnet(id_c : Int) {
        
        var queryId: Int = 0
        do {
            let query = MODEL_NAME_CARNET.select(id_carnet).filter(id_carnet == id_c)
            let qr = try database.prepare(query)
            for q in qr {
                //print("id: \(q[id])")
                queryId = q[id_carnet]
            }
        } catch {
            print(error)
        }
        
        let data = self.MODEL_NAME_CARNET.filter(self.id_carnet == queryId)
        let deleteUser = data.delete()

        do {
            try self.database.run(deleteUser)
        } catch {
            print(error)
        }
    }
    
    // Supprimer un compte dans la bdd
    func deleteAccount(email: String) {
        let email = email.data(using: .utf8)
        let data = self.MODEL_NAME_AUTH.filter(self.EMAIL == email!)
        let deleteUser = data.delete()
        
        do {
            try self.database.run(deleteUser)
            print("Account deleted")
        } catch {
            print(error)
        }
    }
    

    // Suppression de l'ensemble des tables de la bdd
    func deleteTables() {
       
        deletePageTable()
        deleteCarnetTable()
        deleteAccountTable()
        print("Deleted all tables")
        
    }
    
    
    // Suppression de la table de la bdd qui contient les pages
    func deletePageTable() {
        do {
            try database.run(MODEL_NAME_PAGE.drop())
            print("Page table deleted")
        } catch {
            print(error)
        }
        
    }
    
    // Suppression de la table de la bdd qui contient les carnets
    func deleteCarnetTable() {
        do {
            try database.run(MODEL_NAME_CARNET.drop())
            print("Carnet table deleted")
        } catch {
            print(error)
        }
        
    }
    
    // Supprimer la table auth de la bdd
    func deleteAccountTable() {
        do {
            try self.database.run(MODEL_NAME_AUTH.drop())
            print("Account table deleted")
        } catch {
            print(error)
        }
    }

    
    // =========== Affichage de contenu ==============

    // Afficher le contenu de la table page
    func getListPage() -> [Page] {
        var tabPage: [Page] = []
        do {
            let pages = try self.database.prepare(self.MODEL_NAME_PAGE)
            for page in pages {
                tabPage.append(DAO.objectToPage(cursor: page))
            }
        } catch {
            print(error)
        }
        return tabPage
    }
    
    // Afficher le contenu de la table carnet
    func getListCarnet(email: String) -> [Carnet] {
        var tabCarnet: [Carnet] = []
        
        do {
            let carnets = try self.database.prepare(self.MODEL_NAME_CARNET)
            for carnet in carnets {
                if decrypt(donnee: carnet[EMAIL_ACCOUNT]) == email {
                    tabCarnet.append(DAO.objectToCarnet(cursor: carnet))
                }
            }
        } catch {
            print(error)
        }
        
        return tabCarnet
    }

    
    
    // ============ conversion d'objet ==============

    // Chope un objet page dans la bdd en fonction d'un id
    func getPageRow(pageId_pf: Int) -> Page {
        var page: Page = Page(title_pf: "title", content_pf: "content", summary_pf: "summary", carnetId_pf: 0)
        do{
            let query = try self.database.prepare(MODEL_NAME_PAGE.filter(id_page == pageId_pf))
            for p in query {
                page = DAO.objectToPage(cursor: p)
            }
        } catch {
            print(error)
        }
        
        return page
    }
    
    // Chope un objet carnet dans la bdd en fonction d'un id
    func getCarnetRow(carnetId_pf: Int) -> Carnet {
        var carnet: Carnet = Carnet(name_pf: "name", email_pf: "email")
        do{
            let query = try self.database.prepare(MODEL_NAME_CARNET.filter(id_carnet == carnetId_pf))
            for c in query {
                carnet = DAO.objectToCarnet(cursor: c)
            }
        } catch {
            print(error)
        }
        
        return carnet
    }
    
    //Recuperation de toutes les pages appartenant au carnet précisé
    func getPagesByCarnet(carnetId_pf: Int) -> [Page] {
        //let query = self.MODEL_NAME_PAGE.filter(self.CARNET_ID == carnetId_pf)
        //return Array(database.run(query))
        
        var tabPage: [Page] = []
        do{
            let query = try self.database.prepare(MODEL_NAME_PAGE.filter(CARNET_ID == carnetId_pf))
            for p in query {
                tabPage.append(DAO.objectToPage(cursor: p))
                //print(p)
            }
        } catch {
            print(error)
        }
        
        return tabPage
    }
}


