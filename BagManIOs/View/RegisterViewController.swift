//
//  RegisterViewController.swift
//  BagManIOs
//
//  Created by Sabri on 25/12/2017.
//  Copyright © 2017 utt. All rights reserved.
//

import UIKit
import SQLite
import RNCryptor

class RegisterViewController: UIViewController {

    var database: Connection!
    var db: Bdd!
    
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // border design on text field
        self.userEmailTextField.layer.borderColor = UIColor.white.cgColor
        self.userEmailTextField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        self.userPasswordTextField.layer.borderColor = UIColor.white.cgColor
        self.userPasswordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        self.repeatPasswordTextField.layer.borderColor = UIColor.white.cgColor
        self.repeatPasswordTextField.attributedPlaceholder = NSAttributedString(string: "Confirm Password", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        self.userEmailTextField.layer.borderWidth = 1.0
        self.userPasswordTextField.layer.borderWidth = 1.0
        self.repeatPasswordTextField.layer.borderWidth = 1.0
        
        // initialisation de la variable pour intéragir avec la db
        self.db = Bdd()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerButton(_ sender: Any) {
        let userEmail = userEmailTextField.text
        let userPassword = userPasswordTextField.text
        let repeatPassword = repeatPasswordTextField.text
        var emailExist = false
        
        // Check empty fields
        if((userEmail?.isEmpty)! || (userPassword?.isEmpty)! || (repeatPassword?.isEmpty)!) {
            // Display message alert
            displayAlertMessage(userMessage: "All field are required")
            return
        } else if (userPasswordTextField.text?.count)! <= 8 {
            displayAlertMessage(userMessage: "Password must have more than 8 characters")
        }
        
        if (userPassword != repeatPassword) {
            // Display alert message
            displayAlertMessage(userMessage: "Passwords do not match")
            return
        }
        
        // Store data
        do {
            let query = try self.db.database.prepare(db.MODEL_NAME_AUTH)
            for q in query {
                // décypter les email de la bdd
                print("====", q[db.EMAIL])
                let fk = q[db.EMAIL]
                let email = try RNCryptor.decrypt(data: fk, withPassword: "sabri")
                let emails = String(data: email, encoding: .utf8)
                print("====", email)
                if emails == userEmail {
                    emailExist = true
                    print("===", emailExist)
                    debugPrint(emailExist)
                }
             }
            
            if emailExist {
                displayAlertMessage(userMessage: "Email already exist")
            } else {
                let myAlert = UIAlertController(title: "Alert", message: "Registration is successful. Thank you !", preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) { action in
                    self.dismiss(animated: true, completion: nil)
                }
                
                db.insertAccount(email: userEmail!, password: userPassword!)
                myAlert.addAction(okAction)
                self.present(myAlert, animated: true, completion: nil)
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
