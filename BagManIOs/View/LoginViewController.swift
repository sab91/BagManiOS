//
//  LoginViewController.swift
//  BagManIOs
//
//  Created by Sabri on 25/12/2017.
//  Copyright © 2017 utt. All rights reserved.
//

import UIKit
import SQLite
import RNCryptor

class LoginViewController: UIViewController {
    
    var database: Connection!
    var db: Bdd!

    
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.navigationController?.navigationBar.barTintColor = .cyan
        
        self.userEmailTextField.layer.borderColor = UIColor.white.cgColor
        self.userPasswordTextField.layer.borderColor = UIColor.white.cgColor

        self.userEmailTextField.layer.borderWidth = 1.0
        self.userPasswordTextField.layer.borderWidth = 1.0
        
        

        
//        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
//        tap.cancelsTouchesInView = false
//        self.view.addGestureRecognizer(tap)
        
        // initialisation de la variable pour intéragir avec la db
        self.db = Bdd()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButton(_ sender: Any) {
        let userEmail = userEmailTextField.text
        let userPassword = userPasswordTextField.text
        var emailExist = false
        
        var dbemail = ""
        var dbmdp = ""
//        var dbcreation = Date()
//        var dbupdate = Date()
        
        // Check empty fields
        if((userEmail?.isEmpty)! || (userPassword?.isEmpty)!) {
            // Display message alert
            displayAlertMessage(userMessage: "All field are required")
            return
        }
        
        
        do {
            let query = try self.db.database.prepare(db.MODEL_NAME_AUTH)
            for q in query {
                // décypter les email de la bdd
                if db.decrypt(donnee: q[db.EMAIL]) == userEmail {
                    emailExist = true
                    dbemail = db.decrypt(donnee: q[db.EMAIL])
                    dbmdp = db.decrypt(donnee: q[db.MDP])
                }
            }
            if emailExist {
                if (userEmail == dbemail && userPassword == dbmdp) {
                    let myAlert = UIAlertController(title: "Alert", message: "Authentification successful. You're logged", preferredStyle: UIAlertControllerStyle.alert)
                    let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) { action in
                        self.dismiss(animated: true, completion: nil)
                    }
                    
                    UserDefaults.standard.set(userEmail, forKey: "currentEmail")
                    UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                    UserDefaults.standard.synchronize()
                    
                    myAlert.addAction(okAction)
                    self.present(myAlert, animated: true, completion: nil)
                    
                } else {
                    displayAlertMessage(userMessage: "Incorrect password")
                }
            } else {
                displayAlertMessage(userMessage: "Email doesn't exist")
            }
            
            
        } catch {
            print(error)
        }
    }
    
    
    
    // function to display alert message
    func displayAlertMessage(userMessage: String) {
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
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
