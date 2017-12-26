//
//  CreateCarnetView.swift
//  BagManIOs
//
//  Created by Sabri on 26/12/2017.
//  Copyright © 2017 utt. All rights reserved.
//

import UIKit
import SQLite

class CreateCarnetView: UIViewController {
    
    var database: Connection!
    var db: Bdd!
    
    @IBOutlet weak var titreCarnetTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.db = Bdd()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createCarnet(_ sender: Any) {
        let currentEmail = UserDefaults.standard.string(forKey: "currentEmail")
        let carnet = Carnet(name_pf: titreCarnetTextField.text!, email_pf: currentEmail!)
        let idCarnet = db.insertCarnet(carnet: carnet)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
