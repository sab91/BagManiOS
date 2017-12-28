//
//  PageView.swift
//  BagManIOs
//
//  Created by Sabri on 22/12/2017.
//  Copyright © 2017 utt. All rights reserved.
//

import UIKit
import SQLite

class PageView: UIViewController, UITextViewDelegate {
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
        
        contentPage.delegate = self
        
        self.db = Bdd()
        
        titrePage.text = titre
        summaryPage.text = summary
        contentPage.text = content
        creationDatePage.text = String(describing: createAt)
        updateDatePage.text = String(describing: updatedAt)
        
//        contentPage.isSelectable = true
//        contentPage.dataDetectorTypes = UIDataDetectorTypes.address
//        contentPage.dataDetectorTypes = UIDataDetectorTypes.phoneNumber
//        contentPage.dataDetectorTypes = UIDataDetectorTypes.link
        
//        contentPage.autocorrectionType = UITextAutocorrectionType.yes
//        contentPage.spellCheckingType = UITextSpellCheckingType.yes
        
        adjustUITextViewHeight(arg: contentPage)
        
    }
    
    // Action du bouton save pour enregistrer dans la bdd les modifs
    @IBAction func savePageModifications(_ sender: Any) {
        let saveButton = self.toolbarItems?.last
        let carnetId = UserDefaults.standard.integer(forKey: "idCarnet")
        let page = db.getPageRow(pageId_pf: id_page)
        page.content = contentPage.text
        let carnet = db.getCarnetRow(carnetId_pf: carnetId)
        db.updatePage(page: page, id_p: id_page)
        db.updateCarnet(carnet: carnet, id_c: carnetId)
        saveButton?.isEnabled = false
        
    }
    
    // Activer le bouton save lors de la modification du contenue
    func textViewDidChange(_ textView: UITextView) {
        let saveButton = self.toolbarItems?.last
        saveButton?.isEnabled = true
    }
    
    // auto resize text view with content
    func adjustUITextViewHeight(arg : UITextView)
    {
        arg.translatesAutoresizingMaskIntoConstraints = true
        arg.sizeToFit()
        //arg.isScrollEnabled = false
    }
    
    
}

