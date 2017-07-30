//
//  GroupDetailTableViewController.swift
//  bThere
//
//  Created by Nejc Lubej on 06/05/2017.
//  Copyright © 2017 Nejc Lubej. All rights reserved.
//

import UIKit

class GroupDetailTableViewController: UITableViewController {
    
    @IBAction func cancelToSearchUserView(_ sender: UIStoryboardSegue) {
    
    }

    @IBAction func returnUserSearchViewData(_ sender: UIStoryboardSegue) {
        if let data = sender.source as? UserSearchTableViewController {
            print(data.selectedUser)
//            groupMembers.append(GroupMember(memberName: data.selectedUser.name, memberNickName: data.selectedUser.nickName))

            self.tableView.reloadData()
        }
    }
    
    let CellIdentifier = "GroupDetailCell"
    var group : Group!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Group Members"
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return group.users.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier, for: indexPath)
        let user = group.users[indexPath.row]
        
        if let cellGroupMember = cell as? GroupUserCell {
            cellGroupMember.user = user
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
