//
//  GroupDetailTableViewController.swift
//  bThere
//
//  Created by Nejc Lubej on 06/05/2017.
//  Copyright © 2017 Nejc Lubej. All rights reserved.
//

import UIKit

class GroupDetailTableViewController: UITableViewController {
    
    @IBAction func addGroupMember(_ sender: UIBarButtonItem) {
        groupMembers.append(GroupMember(memberName: "Test", memberNickName: "My nickname"))
        self.tableView.reloadData()
    }
    
    let CellIdentifier = "GroupDetailCell"
    var groupMembers = [GroupMember]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Group Members"
        groupMembers = getGroupMembers()
    }
    
    public func getGroupMembers() -> [GroupMember]{
        return [GroupMember(memberName: "Aleksander Bajc", memberNickName: "Aco"),
                GroupMember(memberName: "Nejc Lubej", memberNickName: "The Man"),
                GroupMember(memberName: "Matic Lubej", memberNickName: "The SmartGuy"),
                GroupMember(memberName: "Tadej Ludvik", memberNickName: "Ginger :P")]
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
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: CellIdentifier)
        let member = groupMembers[indexPath.row]
        // At this point, we definitely have a cell -- either dequeued or newly created,
        // so let's force unwrap the optional into a UITableViewCell
        cell.textLabel?.text = member.name
        cell.detailTextLabel?.text = member.nickName
        
        return cell
    }
 

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { [unowned self] action, index in
            self.isEditing = false
            self.groupMembers.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
        
        return [delete]
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
