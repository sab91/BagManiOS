//
//  CarnetView.swift
//  BagManIOs
//
//  Created by Sabri on 20/12/2017.
//  Copyright © 2017 utt. All rights reserved.
//

import UIKit
import SQLite

class CarnetListView: UITableViewController, UISearchBarDelegate {
    var carnet: [Carnet] = []
    var page: [Page] = []
    var currentCarnet: [Carnet] = []
    var idCarnetCell: String = "cell"
    var database: Connection!
    var db: Bdd!
    var idCell: [Int] = []
    var currentEmail: String = ""
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // initialisation de la bdd
        self.db = Bdd()
        
        
        //création de compte test
//        db.insertAccount(email: "sa@hh.fr", password: "aaa")
//        db.insertAccount(email: "ma@hh.fr", password: "bbb")

        
        // Manipulation d'objets Carnet
//        let carnet1:Carnet = Carnet(name_pf: "Carnet1", email_pf: "sa@hh.fr")
//        let carnet2:Carnet = Carnet(name_pf: "Carnet2", email_pf: "sa@hh.fr")
//        let carnet3:Carnet = Carnet(name_pf: "Carnet3", email_pf: "sa@hh.fr")
//        let carnet4:Carnet = Carnet(name_pf: "Carnet4", email_pf: "ma@hh.fr")
        
        // test insertions carnets
//                carnet1.id = db.insertCarnet(carnet: carnet1)
//                carnet2.id = db.insertCarnet(carnet: carnet2)
//                carnet3.id = db.insertCarnet(carnet: carnet3)
//                carnet4.id = db.insertCarnet(carnet: carnet4)
        
        //        print(carnet1.toString())
        //        print(carnet2.toString())
        
        // Manipulation d'objets Pages
//        let page1:Page = Page(title_pf: "Title1", content_pf: "Content1", summary_pf: "Summary1", carnetId_pf: carnet1.id)
//        let page2:Page = Page(title_pf: "Title2", content_pf:"Content2", summary_pf:"Summary2", carnetId_pf: carnet2.id)
//        let page3:Page = Page(title_pf: "Title3", content_pf:"Content3", summary_pf:"Summary3", carnetId_pf: carnet3.id)
//        let page4:Page = Page(title_pf: "Title4", content_pf:"Content4", summary_pf:"Summary4", carnetId_pf: carnet4.id)
//        let page5:Page = Page(title_pf: "Title5", content_pf:"Content5", summary_pf:"Summary5", carnetId_pf: carnet1.id)
        
        //        print(page1.toString())
        //        print(page2.toString())
        
        
        
        // tests insertions pages
        //
//                page1.id = db.insertPage(page: page1)
//                page2.id = db.insertPage(page: page2)
//                page3.id = db.insertPage(page: page3)
//                page4.id = db.insertPage(page: page4)
//                page5.id = db.insertPage(page: page5)
        
        
        
        // tests updates
//        displayCarnet(tabCarnet: db.getListCarnet(email: "sa@hh.fr"))
        //        var listPage = db.getListPage()
//        displayPage(tabPage: db.getListPage())
        
        //        db.updatePage(page: page3, id_p: carnet1.id)
        //        db.updateCarnet(carnet: carnet2, id_c: carnet3.id)
        
        // tests deletes
//                db.deletePage(id_p: 1)
        //        db.deleteCarnet(id_c: 1)
        //        print("================================")
        
        //        db.getListCarnet()
        
        //        db.getListPage()
        
//                db.deleteTables()
        //        db.getListPage()
        //        print("================================")
        
        //self.db = Bdd()
        
        
//        carnet = db.getListCarnet(email: currentEmail)
//        page = db.getListPage()
//        currentCarnet = carnet
        alterView()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//         self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.toolbarItems?.append(editButtonItem)

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(_ animated: Bool) {
        let userLoggedIn = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
        if !userLoggedIn {
            self.performSegue(withIdentifier: "loginView", sender: self)
        } else {
            currentEmail = UserDefaults.standard.string(forKey: "currentEmail")!
            print("=====current email: ", currentEmail)
            carnet = db.getListCarnet(email: currentEmail)
            page = db.getListPage()
            currentCarnet = carnet
            tableView.reloadData()
        }
    }
    
    @IBAction func logoutButton(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
        UserDefaults.standard.set("", forKey: "currentEmail")
        UserDefaults.standard.synchronize()
        self.performSegue(withIdentifier: "loginView", sender: self)

    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return currentCarnet.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // #warning Incomplete implementation, return the number of rows
        return "Liste des carnets"
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idCarnetCell, for: indexPath)
        
        cell.textLabel?.text = "\(currentCarnet[indexPath.row].name)"
//        print(indexPath.section)
//        print(indexPath.row)
        cell.detailTextLabel?.text = "Dernière mis à jour le : \(currentCarnet[indexPath.row].updatedAt)"        
        return cell
    }

    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
     // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
         if editingStyle == .delete {
             // Delete the row from the data source
           
            // cellule sur laquelle on clique
            let cell = tableView.cellForRow(at: indexPath)
            // récupération de son title (nom du carnet)
            let title = cell?.textLabel?.text
            // id de la donnée dans le tableau carnet
            var idRow = 0
            // id du carnet dans la base de données
            var idCarnet = 0
            // compteur dans le tableau carnet qui permettra de savoir quelle donnée supprimer dans le tableau
            var i=0

            for c in currentCarnet {
                // recherche dans le tableau carnet l'id correspondant à celui de la base de données
                if c.name == title {
                    idCarnet = c.id // id dans la base de données
                    idRow = i // id dans le tableau carnet
                    //print("=====", idCarnet)
                }
                i+=1
            }
           
            // suppresion du carnet dans la bdd
            db.deleteCarnet(id_c: idCarnet)
            //supprimer les pages associées au carnet
            db.deletePageByCarnet(carnet_id: idCarnet)

            // supression du carnet dans le tableau carnet pour ne pas qu'il réapparait lorque l'on fait change de view et que l'on revient
            currentCarnet.remove(at: idRow)
            
            // suppression de la ligne (cell) avec effet
            tableView.deleteRows(at: [indexPath], with: .fade)
            
         } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
         }
     }
 
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
     // MARK: - Navigation
     
    // Cette fonction permet de transmettre des données vers une autre View
    // Ici on transmet l'id du carnet pour qu'il affiche uniquement les pages avec la foreign key carnet_id correspondante
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var id = 0
        guard let pageListView = segue.destination as? PageListView else {return}
        if let cell = sender as? UITableViewCell, let title = cell.textLabel?.text {
            do{
                let query = try self.db.database.prepare(db.MODEL_NAME_CARNET.filter(db.NAME == title))
                for q in query {
                    id = q[db.id]
                }
            } catch {
                print (error)
            }
            pageListView.carnet_id = id
        }
    }
 
    
    // MARK: - Search bar
    
    
    private func setUpSearchBar() {
        searchBar.delegate = self
    }
    
    // Mettre la search bar en haut et la garder même lors du scroll
    func alterView() {
        tableView.tableHeaderView = UIView()
        navigationItem.titleView = searchBar
        searchBar.placeholder = "Rechercher un carnet"
    }
    
    // Filtrage des données en fonction de la recherche tapée
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            currentCarnet = carnet
            tableView.reloadData()
            return
        }
        currentCarnet = carnet.filter({ carnet -> Bool in
            //guard let text = searchBar.text else { return false }
            return carnet.name.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    } // called when text changes (including clear)
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        
    }
    
    
    /////// test affichage =======================
    func displayPage(tabPage: [Page]) {
        for page in tabPage {
            print(page.toString())
        }
    }
    
    
    func displayCarnet(tabCarnet: [Carnet]) {
        for carnet in tabCarnet{
            print(carnet.toString())
        }
    }
    

    
}

