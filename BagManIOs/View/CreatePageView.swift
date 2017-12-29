//
//  CreatePageView.swift
//  BagManIOs
//
//  Created by Sabri on 26/12/2017.
//  Copyright © 2017 utt. All rights reserved.
//

import UIKit
import SQLite

class CreatePageView: UIViewController {

    var database: Connection!
    var db: Bdd!
    
    @IBOutlet weak var titlePageTextField: UITextField!
    @IBOutlet weak var summaryPageTextField: UITextField!
    @IBOutlet weak var contentPageTextField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // initialisation de la variable pour intéragir avec la db
        self.db = Bdd()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createPageButton(_ sender: Any) {
        let carnetId = UserDefaults.standard.integer(forKey: "idCarnet")
        let page = Page(title_pf: titlePageTextField.text!, content_pf: contentPageTextField.text!, summary_pf: summaryPageTextField.text!, carnetId_pf: carnetId)
        db.insertPage(page: page)
        displayAlertMessage(userMessage: "Nouvelle page créée")

    }
    
    
    func displayAlertMessage(userMessage: String) {
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) { action in
            self.navigationController?.popViewController(animated: true)
        }
        
        myAlert.addAction(okAction)
        self.present(myAlert, animated: true, completion: nil)
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
