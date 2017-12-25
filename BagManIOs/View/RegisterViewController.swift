//
//  RegisterViewController.swift
//  BagManIOs
//
//  Created by Sabri on 25/12/2017.
//  Copyright © 2017 utt. All rights reserved.
//

import UIKit
import SQLite

class RegisterViewController: UIViewController {

    var database: Connection!
    var db: Bdd!
    
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // initialisation de la bdd
        self.db = Bdd()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerButton(_ sender: Any) {
        let userEmail = userEmailTextField.text
        let userPassword = userPasswordTextField.text
        let repeatPassword = repeatPasswordTextField.text
        
        // Check empty fields
        if((userEmail?.isEmpty)! || (userPassword?.isEmpty)! || (repeatPassword?.isEmpty)!) {
            // Display message alert
            displayAlertMessage(userMessage: "All field are required")
            return
        }
        
        if (userPassword != repeatPassword) {
            // Display alert message
            displayAlertMessage(userMessage: "Passwords do not match")
            return
        }
        
        // Store data
        do {
            let query = try self.db.database.scalar(db.MODEL_NAME_AUTH.filter(db.EMAIL == userEmail!).count)
            print(query)
            if query > 0 {
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
