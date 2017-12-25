////
////  ViewController.swift
////  BagManIOs
////
////  Created by if26 on 14/12/2017.
////  Copyright © 2017 utt. All rights reserved.
////
//
//import UIKit
//import SQLite
//
//class ViewController: UIViewController {
//    var database: Connection!
//    var db: Bdd!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//
//        
//        self.db = Bdd()
//        // initialisation de la bdd
//        
//
//        
////        let carnet1:Carnet = Carnet(name_pf: "Carnet1")
////        carnet1.id = db.insertCarnet(carnet: carnet1)
//        
//        //A tester
////        let page1:Page = Page(title_pf: "Title1", content_pf:"Content1", summary_pf:"Summary1", carnetId_pf: carnet1.id)
//        
////        page1.id = db.insertPage(page: page1)
////        page2.id = db.insertPage(page: page2)
//        
//        //affichage des pages en lien avec le carnet1
////        print(carnet1.toString())
//        //displayPage(tabPage: db.getPagesByCarnet(carnetId_pf: carnet1.id))
//        
//        // Manipulation d'objets Carnet
//        let carnet1:Carnet = Carnet(name_pf: "Carnet1")
//        let carnet2:Carnet = Carnet(name_pf: "Carnet2")
//        let carnet3:Carnet = Carnet(name_pf: "Carnet3")
//        //let carnet4:Carnet = Carnet(name_pf: "Carnet4")
//        
//        // test insertions carnets
////        carnet1.id = db.insertCarnet(carnet: carnet1)
////        carnet2.id = db.insertCarnet(carnet: carnet2)
////        carnet3.id = db.insertCarnet(carnet: carnet3)
//        
//        //        print(carnet1.toString())
//        //        print(carnet2.toString())
//        
//        // Manipulation d'objets Pages
//        let page1:Page = Page(title_pf: "Title1", content_pf: "Content1", summary_pf: "Summary1", carnetId_pf: carnet1.id)
//        let page2:Page = Page(title_pf: "Title2", content_pf:"Content2", summary_pf:"Summary2", carnetId_pf: carnet1.id)
//        let page3:Page = Page(title_pf: "Title3", content_pf:"Content3", summary_pf:"Summary3", carnetId_pf: carnet2.id)
//        let page4:Page = Page(title_pf: "Title4", content_pf:"Content4", summary_pf:"Summary4", carnetId_pf: carnet2.id)
//        let page5:Page = Page(title_pf: "Title5", content_pf:"Content5", summary_pf:"Summary5", carnetId_pf: carnet2.id)
//        
////        print(page1.toString())
////        print(page2.toString())
//        
//
//        
//        // tests insertions pages
////
////        page1.id = db.insertPage(page: page1)
////        page2.id = db.insertPage(page: page2)
////        page3.id = db.insertPage(page: page3)
////        page4.id = db.insertPage(page: page4)
////        page5.id = db.insertPage(page: page5)
//
//       
//        
//        // tests updates
//        displayCarnet(tabCarnet: db.getListCarnet())
////        var listPage = db.getListPage()
//        displayPage(tabPage: db.getListPage())
//
////        db.updatePage(page: page3, id_p: carnet1.id)
////        db.updateCarnet(carnet: carnet2, id_c: carnet3.id)
//        
//        // tests deletes
////        db.deletePage(id_p: 1)
////        db.deleteCarnet(id_c: 1)
////        print("================================")
//
////        db.getListCarnet()
//        
////        db.getListPage()
//
////        db.deleteTables()
////        db.getListPage()
////        print("================================")
//        
//    }
//    
//    func displayPage(tabPage: [Page]) {
//        for page in tabPage {
//            print(page.toString())
//        }
//    }
//    
//    
//    func displayCarnet(tabCarnet: [Carnet]) {
//        for carnet in tabCarnet{
//            print(carnet.toString())
//        }
//    }
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//
//}
//
