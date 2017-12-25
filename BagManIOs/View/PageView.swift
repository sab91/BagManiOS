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
    
    @IBOutlet weak var titrePage: UILabel!
    @IBOutlet weak var contentPage: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titrePage.text = "Content"
        contentPage.text = content
        
    }
    
}

