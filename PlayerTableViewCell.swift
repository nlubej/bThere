//
//  PlayerTableViewCell.swift
//  bThere
//
//  Created by Nejc Lubej on 13/05/2017.
//  Copyright © 2017 Nejc Lubej. All rights reserved.
//

import UIKit
import MGSwipeTableCell

class PlayerTableViewCell: MGSwipeTableCell {
    
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var playerStatus: UIImageView!
    @IBOutlet weak var nickname: UILabel!
    @IBOutlet weak var name: UILabel!
    
    var player: MatchUser? {
        didSet{
            updateUI()
        }
    }
    private func hexToInt(hex : String) -> Int {
        return Int(UInt64(hex, radix:16)!)
    }
    
    private func updateUI() {
        name?.text = player?.user.fullName
        nickname?.text = player?.user.nickname
        
        if player?.responseStatusId != nil {
            
            playerStatus.image = MatchEventStatus.getStatusImage((player?.responseStatusId)!)
            
            playerStatus.image = playerStatus.image!.withRenderingMode(.alwaysTemplate)
            playerStatus.tintColor = UIColor(int: hexToInt(hex: MatchEventStatus.statusToColor(statusId: player?.responseStatusId)))
        }
        
        if player?.user.picture != nil {
            picture.layer.cornerRadius = picture.frame.size.width / 2;
            picture.clipsToBounds = true;
            picture.contentMode = .scaleAspectFill
            picture.image =  UIImage(data: (player?.user.picture!)!)
        }
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
