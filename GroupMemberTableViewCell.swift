//
//  GroupMemberTableViewCell.swift
//  bThere
//
//  Created by Nejc Lubej on 09/05/2017.
//  Copyright © 2017 Nejc Lubej. All rights reserved.
//

import UIKit

class GroupMemberTableViewCell: UITableViewCell {

    @IBOutlet weak var memberName: UILabel!
    @IBOutlet weak var memberNickname: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var groupMember: GroupMember? {
        didSet{
            updateUI()
        }
    }
    
    private func updateUI() {
        memberName?.text = groupMember?.name
        memberNickname?.text = groupMember?.nickName
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
