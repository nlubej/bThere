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
    
    var player: MatchPlayer? {
        didSet{
            updateUI()
        }
    }
    private func hexToInt(hex : String) -> Int {
        return Int(UInt64(hex, radix:16)!)
    }
    
    private func updateUI() {
        name?.text = player?.fullName
        nickname?.text = player?.nickname
        
        playerStatus.image = UIImage(named: MatchEventStatus.statusToIcon(statusId: player?.status))
        
        playerStatus.image = playerStatus.image!.withRenderingMode(.alwaysTemplate)
        playerStatus.tintColor = UIColor(int: hexToInt(hex: MatchEventStatus.statusToColor(statusId: player?.status)))
        
        picture.layer.cornerRadius = picture.frame.size.width / 2;
        picture.clipsToBounds = true;
        picture.contentMode = .scaleAspectFill
        picture.image = player?.picture
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
