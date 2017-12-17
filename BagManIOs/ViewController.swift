//
//  ViewController.swift
//  BagManIOs
//
//  Created by if26 on 14/12/2017.
//  Copyright © 2017 utt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Manipulation d'objets Pages
        let page1:Page = Page(title_pf: "Title1", content_pf:"Content1", summary_pf:"Summary1")

        let page2:Page = Page(title_pf: "Title2", content_pf:"Content2", summary_pf:"Summary2")
        
        print(page1.toString())
        print(page2.toString())
        
        let carnet1:Carnet = Carnet(name_pf: "Carnet1")
        let carnet2:Carnet = Carnet(name_pf: "Carnet2")
        
        print(carnet1.toString())
        print(carnet2.toString())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

