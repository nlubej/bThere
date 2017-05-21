//
//  UserSearchTableViewController.swift
//  bThere
//
//  Created by Nejc Lubej on 07/05/2017.
//  Copyright © 2017 Nejc Lubej. All rights reserved.
//

import UIKit

class UserSearchTableViewController: UITableViewController, UISearchBarDelegate  {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    let CellIdentifier = "SearchMemberCell"
    
    var data = [GroupMember]()
    var groupMembers = [GroupMember]()
    var selectedUser : GroupMember!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        data = getGroupMembers();
        groupMembers = data
        searchBar.delegate = self
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    public func getGroupMembers() -> [GroupMember]{
        return [GroupMember(memberName: "Aleksander Bajc", memberNickName: "Aco"),
                GroupMember(memberName: "Nejc Lubej", memberNickName: "The Man"),
                GroupMember(memberName: "Matic Lubej", memberNickName: "The SmartGuy"),
                GroupMember(memberName: "Tadej Ludvik", memberNickName: "Ginger :P")]
    }
    
    // This method updates filteredData based on the text in the Search Box
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // When there is no text, filteredData is the same as the original data
        // When user has entered text into the search box
        // Use the filter method to iterate over all items in the data array
        // For each item, return true if the item should be included and false if the
        // item should NOT be included
        
        if !searchText.isEmpty {
            groupMembers = data.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
        else {
            groupMembers = data
        }
        
        tableView.reloadData()
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
        return groupMembers.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier, for: indexPath)
        let groupMember = groupMembers[indexPath.row]
        
        if let searchUserMember = cell as? SearchMemberTableViewCell {
            searchUserMember.member = groupMember
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedUser = groupMembers[indexPath.row]
        performSegue(withIdentifier: "returnUserSeque", sender: self)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "GroupDetailSeque" {
            //if let ivc = segue.destination.contentViewControler as? GroupDetailTableViewController {
            
        }
    }

    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
 

}
