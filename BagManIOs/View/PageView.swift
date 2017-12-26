//
//  PageView.swift
//  BagManIOs
//
//  Created by Sabri on 22/12/2017.
//  Copyright © 2017 utt. All rights reserved.
//

import UIKit
import SQLite

class PageView: UIViewController {
    var id_page: Int = 0
    var titre: String = "titre"
    var summary: String = "summary"
    var content: String = "content"
    var createAt: Date = Date()
    var updatedAt: Date = Date()
    var database: Connection!
    var db: Bdd!
    
    @IBOutlet weak var contentPage: UITextView!
    @IBOutlet weak var titrePage: UILabel!
    @IBOutlet weak var summaryPage: UILabel!
    @IBOutlet weak var creationDatePage: UILabel!
    @IBOutlet weak var updateDatePage: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.db = Bdd()
        
        titrePage.text = titre
        summaryPage.text = summary
        contentPage.text = content
        creationDatePage.text = String(describing: createAt)
        updateDatePage.text = String(describing: updatedAt)
    }
    
    @IBAction func savePageModifications(_ sender: Any) {
        let carnetId = UserDefaults.standard.integer(forKey: "idCarnet")
        let page = Page(title_pf: titrePage.text!, content_pf: contentPage.text!, summary_pf: summaryPage.text!, carnetId_pf: carnetId)
        db.updatePage(page: page, id_p: id_page)
    }
    
    
}

