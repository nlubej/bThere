//
//  SearchMemberTableViewCell.swift
//  bThere
//
//  Created by Nejc Lubej on 10/05/2017.
//  Copyright © 2017 Nejc Lubej. All rights reserved.
//

import UIKit

class SearchMemberTableViewCell: UITableViewCell {

    @IBOutlet weak var memberName: UILabel!
    @IBOutlet weak var memberNickname: UILabel!
    
    var member : GroupMember? {
        didSet{
            updateUI()
        }
    }
    
    private func updateUI() {
        memberName?.text = member?.name
        memberNickname?.text = member?.nickName
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
