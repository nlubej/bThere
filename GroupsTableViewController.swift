//
//  GroupsTableViewController.swift
//  bThere
//
//  Created by Nejc Lubej on 06/05/2017.
//  Copyright © 2017 Nejc Lubej. All rights reserved.
//

import UIKit
import RealmSwift

class GroupsTableViewController: UITableViewController,
    UIImagePickerControllerDelegate,
UINavigationControllerDelegate {

    let CellIdentifier = "GroupCell"
    var selectedGroup : Group!
    var groups : Results<Group>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Groups"
        let dataModel = DataModel()
        groups = dataModel.getGroups()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return groups.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier, for: indexPath)
        
        let group = groups[indexPath.row]
        
        
        if let cellGroup = cell as? GroupTableViewCell {
            cellGroup.group = group
            
        }
        
        return cell
    }
    
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            selectedGroup = groups[indexPath.row]
        performSegue(withIdentifier: "GroupDetailSeque", sender: self)
    }
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GroupDetailSeque" {
            if let groupDetail = segue.destination.contentViewControler as? GroupDetailTableViewController {
                groupDetail.group = selectedGroup
            }
        }
     }
    
    
}
