//
//  GroupMemberTableViewCell.swift
//  bThere
//
//  Created by Nejc Lubej on 09/05/2017.
//  Copyright © 2017 Nejc Lubej. All rights reserved.
//

import UIKit

class GroupUserCell: UITableViewCell {

    @IBOutlet weak var memberName: UILabel!
    @IBOutlet weak var memberNickname: UILabel!
    @IBOutlet weak var userProfile: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var user: User? {
        didSet{
            updateUI()
        }
    }
    
    private func updateUI() {
        memberName?.text = user?.name
        memberNickname?.text = user?.nickname
        userProfile = HelperMethods.toRoundImageView(imageView: userProfile, imageData: (user?.picture)!)
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
