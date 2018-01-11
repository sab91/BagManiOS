//
//  PageView.swift
//  BagManIOs
//
//  Created by Sabri on 21/12/2017.
//  Copyright © 2017 utt. All rights reserved.
//

import UIKit
import SQLite
import RNCryptor

class PageListView: UITableViewController, UISearchBarDelegate {
    let password = "sabri"
    var page: [Page] = []
    var currentPage: [Page] = []
    var carnet_id: Int!
    var idPageCell: String = "cell_p"
    var database: Connection!
    var db: Bdd!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // initialisation de la variable pour intéragir avec la db
        self.db = Bdd()
        
    
        
        alterView()


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
//         Uncomment the following line to display an Edit button in the navigation bar for this view controller.
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
            let currentEmail = UserDefaults.standard.string(forKey: "currentEmail")!
            print("=====current email: ", currentEmail)
            UserDefaults.standard.set(carnet_id, forKey: "idCarnet")
            page = db.getPagesByCarnet(carnetId_pf: carnet_id)
            dump(db.getListPage())
            currentPage = page
            tableView.reloadData()
        }
    }
    

    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return currentPage.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // #warning Incomplete implementation, return the number of rows
        return "Liste des pages"
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idPageCell, for: indexPath)
        
        cell.textLabel?.text = "\(currentPage[indexPath.row].title)"
//        print(indexPath.section)
//        print(indexPath.row)
        cell.detailTextLabel?.text = "Dernière mis à jour le : \(currentPage[indexPath.row].updatedAt)"
        
        
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
            
            // cellule sur laquelle on clique
            let cell = tableView.cellForRow(at: indexPath)
            // récupération de son title (nom de la page)
            let title = cell?.textLabel?.text
            // id de la donnée dans le tableau page
            var idRow = 0
            // id de la page dans la base de données
            var idPage = 0
            // compteur dans le tableau page qui permettra de savoir quelle donnée supprimer dans le tableau
            var i=0
            
            for c in currentPage {
                // recherche dans le tableau page l'id correspondant à celui de la base de données
                if c.title == title {
                    idPage = c.id // id dans la base de données
                    idRow = i // id dans le tableau page
                    //print("=====", idPage)
                }
                i+=1
            }
            
            // suppresion de la page dans la bdd
            db.deletePage(id_p: idPage)
            
            // supression de la page dans le tableau page pour ne pas qu'il réapparait lorque l'on change de view et que l'on revient
            currentPage.remove(at: idRow)
            
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
    // Ici on transmet les valeurs de la page pour que son contenue soit affiché dans la vue suivante
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var idPageToSegue = 0
        
        guard let pageView = segue.destination as? PageView else {return}
        if let cell = sender as? UITableViewCell, let title = cell.textLabel?.text {
            
            do{
                let query = try self.db.database.prepare(db.MODEL_NAME_PAGE)
                for q in query {
                    print("Title store in bdd =====", q[db.TITLE])
                    let fk = db.decrypt(donnee: q[db.TITLE])
                    if fk == title {
                        idPageToSegue = q[db.id_page]
                    }
                    print("Title decrypted from bdd =====",fk)
                }
                
            } catch {
                print (error)
            }
            
            let pageSegue = db.getPageRow(pageId_pf: idPageToSegue)
            
            
            pageView.id_page = idPageToSegue
            pageView.titre = pageSegue.title
            pageView.summary = pageSegue.summary
            pageView.content = pageSegue.content
            pageView.createAt = pageSegue.createdAt
            pageView.updatedAt = pageSegue.updatedAt
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
        searchBar.placeholder = "Rechercher une Page"
    }
    
    // Filtrage des données en fonction de la recherche tapée
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            currentPage = page
            tableView.reloadData()
            return
        }
        currentPage = page.filter({ p -> Bool in
            return p.title.lowercased().contains(searchText.lowercased())
        })
        dump(currentPage)
        tableView.reloadData()
    } // called when text changes (including clear)
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        
    }
    
}


