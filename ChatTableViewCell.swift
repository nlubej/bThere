//
//  ChatTableViewCell.swift
//  bThere
//
//  Created by Nejc Lubej on 16/05/2017.
//  Copyright © 2017 Nejc Lubej. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var entryDate: UILabel!
    @IBOutlet weak var chatText: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var comment : CommentEntry? {
        didSet{
            updateUI()
        }
    }
    
    private func updateUI() {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d yyyy, HH:mm"
        entryDate?.text = formatter.string(from: (comment?.entryDate)!)
        
        userName?.text = comment?.user.fullName
        chatText?.text = comment?.comment
        
        profilePicture.image = comment?.user.picture
        profilePicture.layer.cornerRadius = floor(profilePicture.frame.size.width / 2);
        profilePicture.clipsToBounds = true;
        profilePicture.contentMode = .scaleAspectFill
        
    }
}
