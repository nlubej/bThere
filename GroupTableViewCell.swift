//
//  GroupTableViewCell.swift
//  bThere
//
//  Created by Nejc Lubej on 06/05/2017.
//  Copyright © 2017 Nejc Lubej. All rights reserved.
//

import UIKit

class GroupTableViewCell: UITableViewCell {

    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var membersCount: UILabel!
    
    var group : Group? {
        didSet{
            updateUI()
        }
    }
    
    private func updateUI() {
        groupName?.text = group?.groupName
        membersCount?.text = String(describing: (group?.groupMembersCount)!) + " Members"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
