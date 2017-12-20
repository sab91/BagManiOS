//
//  ViewController.swift
//  BagManIOs
//
//  Created by if26 on 14/12/2017.
//  Copyright © 2017 utt. All rights reserved.
//

import UIKit
import SQLite

class ViewController: UIViewController {
    var database: Connection!
    var db: Bdd!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.db = Bdd()
        // initialisation de la bdd
        
        
        // Manipulation d'objets Pages
        let page1:Page = Page(title_pf: "Title1", content_pf:"Content1", summary_pf:"Summary1")
        let page2:Page = Page(title_pf: "Title2", content_pf:"Content2", summary_pf:"Summary2")
        let page3:Page = Page(title_pf: "Title3", content_pf:"Content3", summary_pf:"Summary3")
        let page4:Page = Page(title_pf: "Title4", content_pf:"Content4", summary_pf:"Summary4")
        let page5:Page = Page(title_pf: "Title5", content_pf:"Content5", summary_pf:"Summary5")
        
//        print(page1.toString())
//        print(page2.toString())
        
        let carnet1:Carnet = Carnet(name_pf: "Carnet1")
        let carnet2:Carnet = Carnet(name_pf: "Carnet2")
        let carnet3:Carnet = Carnet(name_pf: "Carnet3")
        let carnet4:Carnet = Carnet(name_pf: "Carnet4")
        
//        print(carnet1.toString())
//        print(carnet2.toString())
        
        // tests insertions
//        db.insertCarnet(carnet: carnet1)
//        db.insertCarnet(carnet: carnet2)
//        db.insertCarnet(carnet: carnet3)
//
//        db.insertPage(page: page1)
//        db.insertPage(page: page2)
//        db.insertPage(page: page3)
        
        // tests updates
        db.updatePage(page: page4, id_p: 1)
//        db.updateCarnet(carnet: carnet4, id_c: 1)
        
        // tests deletes
//        db.deletePage(id_p: 1)
//        db.deleteCarnet(id_c: 1)
        
//        db.deleteTables()
        db.getListPage()
        print("================================")
        db.getListCarnet()
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

